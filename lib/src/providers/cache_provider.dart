import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_provider.g.dart';

@Riverpod(keepAlive: true)
Future<CacheStore> cacheStore(Ref ref) async {
  debugPrint('🔧 [CACHE] Initializing cache store with HiveCacheStore...');

  try {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String cachePath = '${appDocDir.path}/dio_cache';
    debugPrint('🔧 [CACHE] Cache path: $cachePath');

    // Use the dio_cache_interceptor_hive_store which is compatible
    final store = HiveCacheStore(cachePath);
    debugPrint('✅ [CACHE] HiveCacheStore initialized successfully');
    debugPrint(
      '🔧 [CACHE] Using dio_cache_interceptor_hive_store (compatible with dio_cache_interceptor)',
    );

    return store;
  } catch (e, stackTrace) {
    debugPrint('❌ [CACHE] Error initializing HiveCacheStore: $e');
    debugPrint('❌ [CACHE] Stack trace: $stackTrace');

    // Fallback to memory cache if HiveCacheStore fails
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

/// Determines if a request should be cached based on the URL
bool _shouldCacheRequest(RequestOptions request) {
  final path = request.path.toLowerCase();

  // Cache news sources and headlines
  if (path.contains('/sources') ||
      path.contains('/top-headlines') ||
      path.contains('/everything')) {
    return true;
  }

  // Don't cache authentication, user actions, or real-time data
  if (path.contains('/auth') ||
      path.contains('/login') ||
      path.contains('/logout') ||
      path.contains('/profile') ||
      request.method.toUpperCase() != 'GET') {
    return false;
  }

  return false; // Default to not caching
}

@Riverpod(keepAlive: true)
Future<DioCacheInterceptor> cacheInterceptor(Ref ref) async {
  final options = await ref.watch(cacheOptionsProvider.future);
  return SelectiveCacheInterceptor(options: options);
}

/// Custom cache interceptor that only caches specific endpoints
class SelectiveCacheInterceptor extends DioCacheInterceptor {
  SelectiveCacheInterceptor({required super.options});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final shouldCache = _shouldCacheRequest(options);
    final url = options.uri.toString();

    if (shouldCache) {
      debugPrint('🟢 [CACHE] Caching enabled for: ${options.method} $url');
      super.onRequest(options, handler);
    } else {
      debugPrint('🔴 [CACHE] Caching disabled for: ${options.method} $url');
      // Skip caching for this request
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final shouldCache = _shouldCacheRequest(response.requestOptions);
    final url = response.requestOptions.uri.toString();

    if (shouldCache) {
      // Check cache status using the correct keys from the logs
      final extraKeys = response.extra.keys.toList();
      final cacheKey = response.extra['@cache_key@'];
      final fromNetwork = response.extra['@fromNetwork@'];
      final fromCache = fromNetwork == false;

      debugPrint('🔍 [CACHE DEBUG] Response extra keys: $extraKeys');
      debugPrint('🔍 [CACHE DEBUG] fromNetwork: $fromNetwork');
      debugPrint('🔍 [CACHE DEBUG] cacheKey: $cacheKey');

      if (fromCache) {
        debugPrint('💾 [CACHE HIT] ✅ Served from cache: $url');
        debugPrint('    Cache Key: $cacheKey');
      } else if (fromNetwork == true) {
        debugPrint('🌐 [CACHE MISS] ❌ Fetched from network and cached: $url');
        debugPrint('    Cache Key: $cacheKey');
      } else {
        debugPrint('❓ [CACHE UNKNOWN] Status unclear for: $url');
        debugPrint('    fromNetwork: $fromNetwork, extraKeys: $extraKeys');
      }

      super.onResponse(response, handler);
    } else {
      debugPrint('⚪ [NO CACHE] Non-cached response: $url');
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final shouldCache = _shouldCacheRequest(err.requestOptions);
    final url = err.requestOptions.uri.toString();

    if (shouldCache) {
      debugPrint('❌ [CACHE ERROR] Error for cached endpoint: $url');
      super.onError(err, handler);
    } else {
      handler.next(err);
    }
  }
}

/// Cache debugging utilities
class CacheDebugger {
  static void logCacheInfo(Response response) {
    final fromNetwork = response.extra['@fromNetwork@'];
    final cacheKey = response.extra['@cache_key@'];
    final fromCache = fromNetwork == false;

    debugPrint('📊 [CACHE DEBUG] Response Info:');
    debugPrint('    URL: ${response.requestOptions.uri}');
    debugPrint('    From Network: $fromNetwork');
    debugPrint('    From Cache: $fromCache');
    debugPrint('    Cache Key: $cacheKey');
    debugPrint('    Status Code: ${response.statusCode}');
    debugPrint(
      '    Response Size: ${response.data?.toString().length ?? 0} chars',
    );
    debugPrint('    All Extra Keys: ${response.extra.keys.toList()}');
    debugPrint('    Headers: ${response.headers.map.keys.toList()}');

    // Also log the cache status prominently
    if (fromCache) {
      debugPrint('✅ [CACHE STATUS] This response was served from CACHE 💾');
    } else if (fromNetwork == true) {
      debugPrint('🌐 [CACHE STATUS] This response was fetched from NETWORK 📡');
    } else {
      debugPrint('❓ [CACHE STATUS] Cache status is UNCLEAR');
    }
  }

  static Future<void> logCacheStats(CacheStore store) async {
    try {
      debugPrint('🗄️ [CACHE STATS] Cache store info:');
      debugPrint('    Store Type: ${store.runtimeType}');
      debugPrint('    Cache location: Application Documents/dio_cache');
      debugPrint(
        '    ✅ Using dio_cache_interceptor_hive_store (persistent cache storage)',
      );
    } catch (e) {
      debugPrint('❌ [CACHE STATS] Could not get cache stats: $e');
    }
  }
}
