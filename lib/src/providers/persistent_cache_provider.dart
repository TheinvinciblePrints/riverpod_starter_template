import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/utils/path_provider.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'persistent_cache_provider.g.dart';

/// Custom cache tracking interceptor to properly detect cache hits
class CacheTrackingInterceptor extends Interceptor {
  final CacheStore store;

  CacheTrackingInterceptor(this.store);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Store request start time
    options.extra['request_start_time'] = DateTime.now();

    // Check if cache exists before making request
    final cacheKey = CacheOptions.defaultCacheKeyBuilder(url: options.uri);
    final cacheExists = await store.exists(cacheKey);
    options.extra['cache_exists_before_request'] = cacheExists;

    debugPrint('🔍 [CACHE_TRACKING] Request: ${options.uri}');
    debugPrint('📦 [CACHE_TRACKING] Cache exists: $cacheExists');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestStartTime =
        response.requestOptions.extra['request_start_time'] as DateTime?;
    final cacheExistedBefore =
        response.requestOptions.extra['cache_exists_before_request'] as bool?;

    if (requestStartTime != null) {
      final responseTime = DateTime.now().difference(requestStartTime);
      response.extra['response_time_ms'] = responseTime.inMilliseconds;

      // Fast response + cache existed = likely cache hit
      if (cacheExistedBefore == true && responseTime.inMilliseconds < 100) {
        response.extra['likely_from_cache'] = true;
        debugPrint(
          '💾 [CACHE_TRACKING] Likely cache hit - fast response (${responseTime.inMilliseconds}ms)',
        );
      } else {
        response.extra['likely_from_cache'] = false;
        debugPrint(
          '🌐 [CACHE_TRACKING] Likely network response (${responseTime.inMilliseconds}ms)',
        );
      }
    }

    handler.next(response);
  }
}

/// Custom Hive-based CacheStore implementation for persistent caching
/// This is used for static data like countries API that should persist across app restarts

/// Persistent cache provider specifically for static data like countries API
/// Uses custom HiveCacheStore for data that should persist across app restarts
/// Ideal for relatively static data that doesn't change frequently

@Riverpod(keepAlive: true)
Future<CacheStore> persistentCacheStore(Ref ref) async {
  debugPrint('🔧 [PERSISTENT_CACHE] Initializing persistent cache store...');

  try {
    // Use custom HiveCacheStore for persistent storage
    final store = HiveCacheStore(AppPathProvider.path);

    debugPrint('✅ [PERSISTENT_CACHE] HiveCacheStore initialized successfully');
    debugPrint('📦 [PERSISTENT_CACHE] Cache box: dio_cache_persistent');
    debugPrint('♻️ [PERSISTENT_CACHE] Cache will persist across app restarts');

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
    hitCacheOnErrorCodes: [200, 201, 202, 204, 300, 301, 302, 304, 403, 404],
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

/// Provider for cache tracking interceptor
@Riverpod(keepAlive: true)
Future<CacheTrackingInterceptor> cacheTrackingInterceptor(Ref ref) async {
  final store = await ref.watch(persistentCacheStoreProvider.future);
  return CacheTrackingInterceptor(store);
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
    final key = CacheOptions.defaultCacheKeyBuilder(url: Uri.parse(url));
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

  /// Detect and clear corrupted cache for large data endpoints
  /// This is useful for endpoints that return large JSON arrays (like countries)
  static Future<bool> validateAndFixCacheForUrl(
    CacheStore store,
    String url,
  ) async {
    try {
      final key = CacheOptions.defaultCacheKeyBuilder(url: Uri.parse(url));

      if (store is HiveCacheStore) {
        // Check if cache entry exists
        final exists = await store.exists(key);
        if (!exists) {
          debugPrint('ℹ️ [PERSISTENT_CACHE] No cache entry found for: $url');
          return true; // No cache is fine
        }

        // Try to get the cache entry
        final response = await store.get(key);
        if (response == null) {
          debugPrint(
            '⚠️ [PERSISTENT_CACHE] Cache entry exists but returns null for: $url',
          );
          return true; // Already cleaned up by the get() method
        }

        // Validate content size for large data endpoints
        final content = response.content;
        if (content != null && content.isNotEmpty) {
          final contentString = String.fromCharCodes(content);

          // For countries endpoint, expect reasonably large JSON array
          if (url.contains('restcountries.com') &&
              contentString.length < 1000) {
            debugPrint(
              '⚠️ [PERSISTENT_CACHE] Suspiciously small countries cache: ${contentString.length} bytes',
            );
            await store.delete(key);
            debugPrint(
              '🗑️ [PERSISTENT_CACHE] Cleared small/corrupted countries cache',
            );
            return false;
          }

          // Basic JSON structure validation for array endpoints
          if (contentString.trim().startsWith('[') &&
              !contentString.trim().endsWith(']')) {
            debugPrint(
              '⚠️ [PERSISTENT_CACHE] Incomplete JSON array detected for: $url',
            );
            await store.delete(key);
            debugPrint('🗑️ [PERSISTENT_CACHE] Cleared incomplete JSON cache');
            return false;
          }
        }

        debugPrint('✅ [PERSISTENT_CACHE] Cache validation passed for: $url');
        return true;
      }
    } catch (e) {
      debugPrint('❌ [PERSISTENT_CACHE] Error validating cache for $url: $e');
      await clearCacheForUrl(store, url);
      return false;
    }

    return true;
  }
}

/// Cache debugging for persistent cache
class PersistentCacheDebugger {
  /// Get cache information with persistent cache context
  static String getCacheInfo(Response response) {
    final buffer = StringBuffer();

    buffer.writeln('🔍 [PERSISTENT_CACHE DEBUG] Response Info:');
    buffer.writeln('Status: ${response.statusCode}');

    // Enhanced cache detection - check multiple indicators
    bool fromCache = false;
    String cacheIndicator = '';

    // Check our custom cache tracking flag (most reliable)
    final dioCacheExtra = response.extra;
    if (dioCacheExtra.containsKey('likely_from_cache')) {
      fromCache = dioCacheExtra['likely_from_cache'] == true;
      if (fromCache) {
        cacheIndicator = 'CacheTrackingInterceptor';
        final responseTime = dioCacheExtra['response_time_ms'];
        if (responseTime != null) {
          cacheIndicator += ' (${responseTime}ms)';
        }
      }
    }

    // Fallback: Check dio_cache_interceptor specific headers
    if (!fromCache) {
      final dioCacheResponse = response.headers['dio-cache-response']?.first;
      if (dioCacheResponse != null) {
        fromCache = true;
        cacheIndicator = 'dio-cache-response header';
      }
    }

    // Fallback: Check for cache-specific extra data
    if (!fromCache && dioCacheExtra.containsKey('dio_cache_interceptor_key')) {
      fromCache = true;
      cacheIndicator = 'dio_cache_interceptor key present';
    }

    // Fallback: Check for response from cache store
    if (!fromCache && dioCacheExtra.containsKey('from_cache')) {
      fromCache = dioCacheExtra['from_cache'] == true;
      if (fromCache) {
        cacheIndicator = 'from_cache extra flag';
      }
    }

    // Fallback: Check standard cache headers
    if (!fromCache) {
      final xCache = response.headers['x-cache']?.first;
      if (xCache != null && xCache.contains('HIT')) {
        fromCache = true;
        cacheIndicator = 'x-cache header';
      }

      // Check for 304 Not Modified
      if (response.statusCode == 304) {
        fromCache = true;
        cacheIndicator = '304 Not Modified status';
      }
    }

    // Log cache extra data for debugging
    if (dioCacheExtra.isNotEmpty) {
      buffer.writeln('🔍 Extra data keys: ${dioCacheExtra.keys.toList()}');
      for (final key in dioCacheExtra.keys) {
        if (key.toString().toLowerCase().contains('cache') ||
            key.toString().toLowerCase().contains('dio') ||
            key.toString().contains('likely_from_cache') ||
            key.toString().contains('response_time')) {
          buffer.writeln('  $key: ${dioCacheExtra[key]}');
        }
      }
    }

    // Display cache status with clear indicators
    if (fromCache) {
      buffer.writeln('💾 🟢 FROM PERSISTENT CACHE ($cacheIndicator)');
      buffer.writeln('✅ Cache hit - data served from local storage');
    } else {
      buffer.writeln('🌐 🔵 FROM NETWORK (fresh data)');
      buffer.writeln('📡 Network request - data fetched from server');
    }

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

    // Add response time information
    final responseTime = response.extra['response_time'];
    if (responseTime != null) {
      buffer.writeln('⏱️ Response time: ${responseTime}ms');
    }

    // Add content size information
    final contentLength =
        response.headers[HttpHeaders.contentLengthHeader]?.first;
    if (contentLength != null) {
      buffer.writeln('📊 Content length: $contentLength bytes');
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

  /// Get detailed cache information for debugging
  static Future<Map<String, dynamic>> getCacheDetails(
    CacheStore store,
    String url,
  ) async {
    final details = <String, dynamic>{
      'url': url,
      'exists': false,
      'contentSize': 0,
      'contentPreview': '',
      'lastModified': null,
      'expires': null,
    };

    try {
      final key = CacheOptions.defaultCacheKeyBuilder(url: Uri.parse(url));

      if (store is HiveCacheStore) {
        details['exists'] = await store.exists(key);

        if (details['exists'] == true) {
          final response = await store.get(key);
          if (response != null) {
            final content = response.content;
            if (content != null) {
              details['contentSize'] = content.length;
              final contentString = String.fromCharCodes(content);
              details['contentPreview'] =
                  contentString.length > 100
                      ? '${contentString.substring(0, 100)}...'
                      : contentString;
            }
            details['lastModified'] = response.lastModified;
            details['expires'] = response.expires?.toIso8601String();
          }
        }
      }
    } catch (e) {
      details['error'] = e.toString();
    }

    return details;
  }

  /// Check cache status before making a request
  static Future<String> getCacheStatusBeforeRequest(
    CacheStore store,
    String url,
  ) async {
    final buffer = StringBuffer();

    try {
      final key = CacheOptions.defaultCacheKeyBuilder(url: Uri.parse(url));
      final exists = await store.exists(key);

      buffer.writeln('🔍 [PERSISTENT_CACHE] Pre-request cache check:');
      buffer.writeln('URL: $url');
      buffer.writeln('Cache key: $key');

      if (exists) {
        buffer.writeln('💾 ✅ Cache entry EXISTS');

        // Try to get cache details
        final response = await store.get(key);
        if (response != null) {
          final now = DateTime.now();
          final expires = response.expires;

          buffer.writeln(
            '📅 Cached on: ${response.date?.toIso8601String() ?? 'Unknown'}',
          );
          buffer.writeln(
            '⏰ Expires: ${expires?.toIso8601String() ?? 'No expiration'}',
          );

          if (expires != null) {
            final timeUntilExpiry = expires.difference(now);
            if (timeUntilExpiry.isNegative) {
              buffer.writeln(
                '🔴 Cache is EXPIRED (${timeUntilExpiry.abs().inMinutes} minutes ago)',
              );
            } else {
              buffer.writeln(
                '🟢 Cache is VALID (expires in ${timeUntilExpiry.inMinutes} minutes)',
              );
            }
          }

          final content = response.content;
          if (content != null) {
            buffer.writeln('📊 Content size: ${content.length} bytes');
          }
        }
      } else {
        buffer.writeln('❌ No cache entry found');
        buffer.writeln('🌐 Request will fetch from network');
      }
    } catch (e) {
      buffer.writeln('❌ Error checking cache: $e');
    }

    return buffer.toString();
  }
}
