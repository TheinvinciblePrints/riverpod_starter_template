import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_provider.g.dart';

/// Official dio_cache_interceptor approach based on the examples
/// https://github.com/llfbandit/dart_http_cache/blob/master/dio_cache_interceptor/example/lib/main.dart
/// https://github.com/llfbandit/dart_http_cache/blob/master/dio_cache_interceptor/example/lib/caller.dart

@Riverpod(keepAlive: true)
Future<CacheStore> cacheStore(Ref ref) async {
  debugPrint('🔧 [CACHE] Initializing cache store...');

  try {
    // Use a larger memory cache with longer retention
    // This will help with caching during the app session
    final store = MemCacheStore(
      maxSize: 50 * 1024 * 1024, // 50MB instead of 10MB
      maxEntrySize: 10 * 1024 * 1024, // 10MB per entry instead of 1MB
    );

    debugPrint('✅ [CACHE] MemCacheStore initialized successfully');
    debugPrint('🔧 [CACHE] Cache size: 50MB, Max entry: 10MB');
    debugPrint('⚠️ [CACHE] Cache will NOT persist across app restarts');
    debugPrint('💡 [CACHE] But will work well during app session');

    return store;
  } catch (e, stackTrace) {
    debugPrint('❌ [CACHE] Error initializing MemCacheStore: $e');
    debugPrint('❌ [CACHE] Stack trace: $stackTrace');
    rethrow;
  }
}

@Riverpod(keepAlive: true)
Future<CacheOptions> cacheOptions(Ref ref) async {
  final store = await ref.watch(cacheStoreProvider.future);

  return CacheOptions(
    store: store,
    policy:
        CachePolicy
            .request, // Default policy - respect server headers but use cache
    // hitCacheOnErrorExcept: [401, 403], // Don't cache auth errors
    maxStale: const Duration(days: 7), // Cache is valid for 7 days when stale
    priority: CachePriority.normal,
    cipher: null,
    allowPostMethod: false,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Custom cache settings for better news app performance
  );
}

@Riverpod(keepAlive: true)
Future<DioCacheInterceptor> cacheInterceptor(Ref ref) async {
  final options = await ref.watch(cacheOptionsProvider.future);
  return DioCacheInterceptor(options: options);
}

/// Helper methods for different cache policies
/// Based on the official example patterns from caller.dart
class CacheHelper {
  /// No cache - skip cache entirely (equivalent to noCacheCall)
  static CacheOptions noCache(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.noCache);
  }

  /// Request policy - default behavior, respect server headers (equivalent to requestCall)
  static CacheOptions request(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.request);
  }

  /// Refresh cache - always hit network but update cache (equivalent to refreshCall)
  static CacheOptions refresh(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.refresh);
  }

  /// Force cache - use cache even if stale (equivalent to forceCacheCall)
  static CacheOptions forceCache(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.forceCache);
  }

  /// Refresh force cache - refresh if possible, otherwise use cache (equivalent to refreshForceCacheCall)
  static CacheOptions refreshForceCache(CacheOptions baseOptions) {
    return baseOptions.copyWith(policy: CachePolicy.refreshForceCache);
  }

  /// Clear cache for a specific URL (equivalent to deleteEntry)
  static Future<void> clearCacheForUrl(CacheStore store, String url) async {
    final key = CacheOptions.defaultCacheKeyBuilder(url: Uri.parse(url));
    await store.delete(key);
    debugPrint('🗑️ [CACHE] Cleared cache for: $url');
  }

  /// Clear all cache (equivalent to cleanStore)
  static Future<void> clearAllCache(CacheStore store) async {
    await store.clean();
    debugPrint('🗑️ [CACHE] Cleared all cache');
  }
}

/// Cache debugging helper similar to the official examples
class CacheDebugger {
  /// Get cache information from response (equivalent to _getResponseContent)
  static String getCacheInfo(Response response) {
    final buffer = StringBuffer();

    buffer.writeln('🔍 [CACHE DEBUG] Response Info:');
    buffer.writeln('Status: ${response.statusCode}');

    // Check if it came from cache (304 = Not Modified, typically from cache)
    final fromCache = response.statusCode == 304;
    buffer.writeln(fromCache ? '✅ From Cache' : '🌐 From Network');

    final headers = response.headers;
    final date = headers[HttpHeaders.dateHeader]?.first;
    final etag = headers[HttpHeaders.etagHeader]?.first;
    final expires = headers[HttpHeaders.expiresHeader]?.first;
    final lastModified = headers[HttpHeaders.lastModifiedHeader]?.first;
    final cacheControl = headers[HttpHeaders.cacheControlHeader]?.first;

    buffer.writeln('');
    buffer.writeln('Request headers:');
    buffer.writeln(response.requestOptions.headers.toString());

    buffer.writeln('');
    buffer.writeln('Response headers (cache related):');
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

    return buffer.toString();
  }
}
