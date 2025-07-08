import 'dart:convert';
import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_provider.g.dart';

@Riverpod(keepAlive: true)
Future<CacheStore> cacheStore(Ref ref) async {
  debugPrint('🔧 [CACHE] Initializing persistent cache store with Hive...');

  try {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String cachePath = '${appDocDir.path}/dio_cache';
    debugPrint('🔧 [CACHE] Cache path: $cachePath');

    // Initialize Hive for persistent storage
    await Hive.initFlutter(cachePath);

    // Create persistent cache store using Hive
    final store = HivePersistentCacheStore();
    await store.initialize();

    debugPrint('✅ [CACHE] HivePersistentCacheStore initialized successfully');
    debugPrint('🔧 [CACHE] Using custom Hive-based persistent storage');

    return store;
  } catch (e, stackTrace) {
    debugPrint('❌ [CACHE] Error initializing HivePersistentCacheStore: $e');
    debugPrint('❌ [CACHE] Stack trace: $stackTrace');

    // Fallback to memory cache if persistent storage fails
    debugPrint('🔧 [CACHE] Falling back to MemCacheStore for this session');
    return MemCacheStore();
  }
}

@Riverpod(keepAlive: true)
Future<CacheOptions> cacheOptions(Ref ref) async {
  final store = await ref.watch(cacheStoreProvider.future);

  return CacheOptions(
    store: store,
    policy: CachePolicy.forceCache, // Use cache aggressively
    hitCacheOnErrorExcept: [401, 403],
    maxStale: const Duration(days: 7), // Cache is valid for 7 days
    priority: CachePriority.normal,
    cipher: null,
    allowPostMethod: false,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  );
}

@Riverpod(keepAlive: true)
Future<DioCacheInterceptor> cacheInterceptor(Ref ref) async {
  final options = await ref.watch(cacheOptionsProvider.future);
  return DioCacheInterceptor(options: options);
}

/// Custom persistent cache store implementation using Hive
class HivePersistentCacheStore extends CacheStore {
  late Box<String> _cacheBox;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Open Hive box for serialized cache responses
      _cacheBox = await Hive.openBox<String>('dio_cache_responses');
      _initialized = true;
      debugPrint('✅ [HIVE] Cache box opened successfully');
    } catch (e) {
      debugPrint('❌ [HIVE] Failed to open cache box: $e');
      rethrow;
    }
  }

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    if (!_initialized) return;

    final keysToDelete = <String>[];

    for (final key in _cacheBox.keys) {
      try {
        final cachedResponse = await get(key.toString());
        if (cachedResponse != null) {
          final isStale = DateTime.now().isAfter(
            cachedResponse.expires ?? DateTime.now(),
          );

          if (staleOnly && !isStale) continue;

          // For now, we'll clean based on staleness only
          // Priority-based cleaning would require more complex metadata
          if (isStale) {
            keysToDelete.add(key.toString());
          }
        }
      } catch (e) {
        // If cache entry is corrupted, mark for deletion
        keysToDelete.add(key.toString());
      }
    }

    for (final key in keysToDelete) {
      await _cacheBox.delete(key);
    }

    debugPrint('🗑️ [HIVE] Cleaned ${keysToDelete.length} cache entries');
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    if (!_initialized) return;

    if (staleOnly) {
      // Check if stale before deleting
      final response = await get(key);
      if (response != null) {
        final isStale = DateTime.now().isAfter(
          response.expires ?? DateTime.now(),
        );
        if (!isStale) {
          return; // Don't delete if not stale
        }
      }
    }

    await _cacheBox.delete(key);
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    if (!_initialized) return;

    final keysToDelete = <String>[];

    for (final key in _cacheBox.keys) {
      if (pathPattern.hasMatch(key.toString())) {
        keysToDelete.add(key.toString());
      }
    }

    for (final key in keysToDelete) {
      await _cacheBox.delete(key);
    }
  }

  @override
  Future<bool> exists(String key) async {
    if (!_initialized) return false;
    return _cacheBox.containsKey(key);
  }

  @override
  Future<CacheResponse?> get(String key) async {
    if (!_initialized) return null;

    try {
      final cachedJson = _cacheBox.get(key);
      if (cachedJson == null) {
        debugPrint(
          '❌ [CACHE MISS] No cached data found for key: ${key.substring(0, 8)}...',
        );
        return null;
      }

      final cachedData = jsonDecode(cachedJson) as Map<String, dynamic>;
      final url = cachedData['url'] as String;
      final cacheDate = DateTime.fromMillisecondsSinceEpoch(
        cachedData['date'] as int,
      );
      final expiresDate =
          cachedData['expires'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                cachedData['expires'] as int,
              )
              : null;

      final isExpired =
          expiresDate != null && DateTime.now().isAfter(expiresDate);
      final age = DateTime.now().difference(cacheDate);

      debugPrint('✅ [CACHE HIT] Found cached data for: $url');
      debugPrint('📊 [CACHE] Age: ${age.inMinutes}min, Expired: $isExpired');

      // Deserialize CacheResponse from stored JSON
      return CacheResponse(
        key: cachedData['key'] as String,
        url: url,
        eTag: cachedData['eTag'] as String?,
        lastModified: cachedData['lastModified'] as String?,
        maxStale:
            cachedData['expires'] != null
                ? DateTime.fromMillisecondsSinceEpoch(
                  cachedData['expires'] as int,
                )
                : null,
        content:
            cachedData['content'] != null
                ? (cachedData['content'] as List).cast<int>()
                : <int>[],
        date: cacheDate,
        expires: expiresDate,
        headers: (cachedData['headers'] as List?)?.cast<int>(),
        priority: CachePriority.values[cachedData['priority'] as int? ?? 0],
        requestDate: DateTime.fromMillisecondsSinceEpoch(
          cachedData['requestDate'] as int,
        ),
        responseDate: DateTime.fromMillisecondsSinceEpoch(
          cachedData['responseDate'] as int,
        ),
        cacheControl: CacheControl(
          maxAge: cachedData['maxAge'] as int? ?? 0,
          maxStale: cachedData['maxStaleControl'] as int? ?? 0,
        ),
      );
    } catch (e) {
      debugPrint('❌ [HIVE] Error retrieving cache for key $key: $e');
      // Clean up corrupted cache entry
      await delete(key);
      return null;
    }
  }

  @override
  Future<void> set(CacheResponse response) async {
    if (!_initialized) return;

    try {
      // Override server expiration with our own 7-day expiration
      final now = DateTime.now();
      final customExpires = now.add(const Duration(days: 7));

      // Create an updated response with our custom expiration
      final updatedResponse = CacheResponse(
        key: response.key,
        url: response.url,
        eTag: response.eTag,
        lastModified: response.lastModified,
        maxStale: null,
        content: response.content,
        date: response.date ?? now,
        expires: customExpires, // Force 7-day expiration
        headers: response.headers,
        requestDate: response.requestDate,
        responseDate: response.responseDate,
        cacheControl: CacheControl(
          maxAge: 604800, // 7 days in seconds
          maxStale: 604800,
        ),
        priority: response.priority,
      );

      // Serialize CacheResponse to JSON
      final cacheData = {
        'key': updatedResponse.key,
        'url': updatedResponse.url,
        'eTag': updatedResponse.eTag,
        'lastModified': updatedResponse.lastModified,
        'content': updatedResponse.content,
        'date':
            updatedResponse.date?.millisecondsSinceEpoch ??
            now.millisecondsSinceEpoch,
        'expires': updatedResponse.expires?.millisecondsSinceEpoch,
        'headers': updatedResponse.headers,
        'priority': updatedResponse.priority.index,
        'requestDate': updatedResponse.requestDate.millisecondsSinceEpoch,
        'responseDate': updatedResponse.responseDate.millisecondsSinceEpoch,
        'maxAge': updatedResponse.cacheControl.maxAge,
        'maxStaleControl': updatedResponse.cacheControl.maxStale,
      };

      await _cacheBox.put(updatedResponse.key, jsonEncode(cacheData));

      final expiresIn = customExpires.difference(now);

      debugPrint('💾 [CACHE STORE] Cached: ${updatedResponse.url}');
      debugPrint(
        '⏰ [CACHE] Expires in: ${expiresIn.inDays}d ${expiresIn.inHours % 24}h ${expiresIn.inMinutes % 60}m',
      );
    } catch (e) {
      debugPrint('❌ [HIVE] Error storing cache for key ${response.key}: $e');
    }
  }

  @override
  Future<void> close() async {
    if (!_initialized) return;

    try {
      await _cacheBox.close();
      _initialized = false;
      debugPrint('🔒 [HIVE] Cache box closed');
    } catch (e) {
      debugPrint('❌ [HIVE] Error closing cache box: $e');
    }
  }

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    if (!_initialized) return [];

    final responses = <CacheResponse>[];

    for (final key in _cacheBox.keys) {
      if (pathPattern.hasMatch(key.toString())) {
        final response = await get(key.toString());
        if (response != null) {
          responses.add(response);
        }
      }
    }

    return responses;
  }
}
