import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'persistent_cache_provider.g.dart';

/// Custom Hive-based CacheStore implementation for persistent caching
/// This is used for static data like countries API that should persist across app restarts
class HiveCacheStore implements CacheStore {
  late Box<Map<dynamic, dynamic>> _box;
  final String boxName;

  HiveCacheStore({required this.boxName});

  /// Initialize the Hive box
  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.initFlutter();
      _box = await Hive.openBox<Map<dynamic, dynamic>>(boxName);
    } else {
      _box = Hive.box<Map<dynamic, dynamic>>(boxName);
    }
  }

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    await _box.clear();
    debugPrint('🗑️ [HIVE_CACHE] Cleaned all cache entries');
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    await _box.delete(key);
    debugPrint('🗑️ [HIVE_CACHE] Deleted cache entry: $key');
  }

  @override
  Future<CacheResponse?> get(String key) async {
    final data = _box.get(key);
    if (data == null) return null;

    try {
      return CacheResponse(
        cacheControl: CacheControl(),
        content: data['content'] as Uint8List?,
        date:
            data['date'] != null
                ? DateTime.parse(data['date'] as String)
                : null,
        eTag: data['eTag'] as String?,
        expires:
            data['expires'] != null
                ? DateTime.parse(data['expires'] as String)
                : null,
        headers: <int>[], // Headers simplified
        key: data['key'] as String,
        lastModified: data['lastModified'] as String?,
        maxStale:
            data['maxStale'] != null
                ? DateTime.fromMillisecondsSinceEpoch(data['maxStale'] as int)
                : null,
        priority: CachePriority.values[data['priority'] as int? ?? 0],
        requestDate: DateTime.parse(data['requestDate'] as String),
        responseDate: DateTime.parse(data['responseDate'] as String),
        url: data['url'] as String,
      );
    } catch (e) {
      debugPrint('❌ [HIVE_CACHE] Error reading cache entry $key: $e');
      await delete(key);
      return null;
    }
  }

  @override
  Future<void> set(CacheResponse response) async {
    final data = <String, dynamic>{
      'content': response.content,
      'date': response.date?.toIso8601String(),
      'eTag': response.eTag,
      'expires': response.expires?.toIso8601String(),
      'key': response.key,
      'lastModified': response.lastModified,
      'maxStale': response.maxStale?.millisecondsSinceEpoch,
      'priority': response.priority.index,
      'requestDate': response.requestDate.toIso8601String(),
      'responseDate': response.responseDate.toIso8601String(),
      'url': response.url,
    };

    await _box.put(response.key, data);
    debugPrint('💾 [HIVE_CACHE] Cached entry: ${response.key}');
  }

  @override
  Future<bool> exists(String key) async {
    return _box.containsKey(key);
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    // Simple implementation - delete all matching keys
    final keysToDelete = <String>[];
    for (final key in _box.keys) {
      if (pathPattern.hasMatch(key.toString())) {
        keysToDelete.add(key.toString());
      }
    }
    for (final key in keysToDelete) {
      await delete(key);
    }
    debugPrint(
      '🗑️ [HIVE_CACHE] Deleted ${keysToDelete.length} entries matching pattern',
    );
  }

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    // Return all matching entries
    final responses = <CacheResponse>[];
    for (final key in _box.keys) {
      if (pathPattern.hasMatch(key.toString())) {
        final response = await get(key.toString());
        if (response != null) {
          responses.add(response);
        }
      }
    }
    return responses;
  }

  @override
  bool pathExists(
    String url,
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) {
    for (final key in _box.keys) {
      if (pathPattern.hasMatch(key.toString())) {
        return true;
      }
    }
    return false;
  }

  /// Close the Hive box
  @override
  Future<void> close() async {
    if (_box.isOpen) {
      await _box.close();
    }
  }
}

/// Persistent cache provider specifically for static data like countries API
/// Uses custom HiveCacheStore for data that should persist across app restarts
/// Ideal for relatively static data that doesn't change frequently

@Riverpod(keepAlive: true)
Future<CacheStore> persistentCacheStore(Ref ref) async {
  debugPrint('🔧 [PERSISTENT_CACHE] Initializing persistent cache store...');

  try {
    // Use custom HiveCacheStore for persistent storage
    final store = HiveCacheStore(boxName: 'dio_cache_persistent');
    await store.init();

    debugPrint('✅ [PERSISTENT_CACHE] HiveCacheStore initialized successfully');
    debugPrint('📦 [PERSISTENT_CACHE] Cache box: dio_cache_persistent');
    debugPrint('♻️ [PERSISTENT_CACHE] Cache WILL persist across app restarts');
    debugPrint(
      '🎯 [PERSISTENT_CACHE] Ideal for static data (countries, sources)',
    );
    debugPrint('🚀 [PERSISTENT_CACHE] Hive provides fast key-value storage');

    return store;
  } catch (e, stackTrace) {
    debugPrint('❌ [PERSISTENT_CACHE] Error initializing HiveCacheStore: $e');
    debugPrint('❌ [PERSISTENT_CACHE] Stack trace: $stackTrace');
    rethrow;
  }
}

@Riverpod(keepAlive: true)
Future<CacheOptions> persistentCacheOptions(Ref ref) async {
  final store = await ref.watch(persistentCacheStoreProvider.future);

  return CacheOptions(
    store: store,
    policy: CachePolicy.forceCache, // Prefer cache for static data
    hitCacheOnErrorExcept: [401, 403], // Don't cache auth errors
    maxStale: const Duration(days: 30), // Static data can be stale for longer
    priority: CachePriority.high, // High priority for static data
    cipher: null,
    allowPostMethod: false,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  );
}

@Riverpod(keepAlive: true)
Future<DioCacheInterceptor> persistentCacheInterceptor(Ref ref) async {
  final options = await ref.watch(persistentCacheOptionsProvider.future);
  return DioCacheInterceptor(options: options);
}

/// Helper methods for persistent cache management
class PersistentCacheHelper {
  /// Force refresh for static data - use when you know data has changed
  static CacheOptions forceRefresh(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.refresh);
  }

  /// Request policy for initial load - respects server headers
  static CacheOptions request(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.request);
  }

  /// Force cache - always use cache if available (default for persistent cache)
  static CacheOptions forceCache(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.forceCache);
  }

  /// Clear cache for a specific URL
  static Future<void> clearCacheForUrl(CacheStore store, String url) async {
    final key = CacheOptions.defaultCacheKeyBuilder(RequestOptions(path: url));
    await store.delete(key);
    debugPrint('🗑️ [PERSISTENT_CACHE] Cleared cache for: $url');
  }

  /// Clear all persistent cache
  static Future<void> clearAllCache(CacheStore store) async {
    await store.clean();
    debugPrint('🗑️ [PERSISTENT_CACHE] Cleared all persistent cache');
  }

  /// Get cache size information
  static Future<String> getCacheStats(CacheStore store) async {
    try {
      if (store is HiveCacheStore) {
        return 'Persistent cache (HiveCacheStore) - data persists across app restarts';
      }
      return 'Cache statistics not available for this store type';
    } catch (e) {
      return 'Error getting cache stats: $e';
    }
  }
}

/// Cache debugging for persistent cache
class PersistentCacheDebugger {
  /// Get cache information with persistent cache context
  static String getCacheInfo(Response response) {
    final buffer = StringBuffer();

    buffer.writeln('🔍 [PERSISTENT_CACHE DEBUG] Response Info:');
    buffer.writeln('Status: ${response.statusCode}');

    // Check if it came from cache
    final fromCache =
        response.statusCode == 304 ||
        response.headers['x-cache']?.first.contains('HIT') == true;
    buffer.writeln(fromCache ? '💾 From Persistent Cache' : '🌐 From Network');

    final headers = response.headers;
    final date = headers[HttpHeaders.dateHeader]?.first;
    final etag = headers[HttpHeaders.etagHeader]?.first;
    final expires = headers[HttpHeaders.expiresHeader]?.first;
    final lastModified = headers[HttpHeaders.lastModifiedHeader]?.first;
    final cacheControl = headers[HttpHeaders.cacheControlHeader]?.first;

    buffer.writeln('');
    buffer.writeln('📋 Response headers (cache related):');
    if (date != null) {
      buffer.writeln('${HttpHeaders.dateHeader}: $date');
    }
    if (etag != null) {
      buffer.writeln('${HttpHeaders.etagHeader}: $etag');
    }
    if (expires != null) {
      buffer.writeln('${HttpHeaders.expiresHeader}: $expires');
    }
    if (lastModified != null) {
      buffer.writeln('${HttpHeaders.lastModifiedHeader}: $lastModified');
    }
    if (cacheControl != null) {
      buffer.writeln('${HttpHeaders.cacheControlHeader}: $cacheControl');
    }

    buffer.writeln('');
    buffer.writeln(
      '💡 [PERSISTENT_CACHE] This cache persists across app restarts',
    );
    buffer.writeln(
      '🎯 [PERSISTENT_CACHE] Ideal for static data like countries',
    );

    return buffer.toString();
  }
}
