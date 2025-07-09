import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/config/env/env.dart';
import 'package:flutter_riverpod_starter_template/src/providers/cache_provider.dart';
import 'package:flutter_riverpod_starter_template/src/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network.dart';
import '../domain/news_source.dart';
import '../utils/source_icon_mapper.dart';

part 'sources_repository.g.dart';

class SourcesRepository with NetworkErrorHandler {
  final Ref _ref;
  // Cache for sources to avoid repeated API calls
  final Map<String, NewsSource> _sourcesCache = {};
  bool _sourcesLoaded = false;

  SourcesRepository(this._ref);

  /// Get the cached sources
  Map<String, NewsSource> get sourcesCache => _sourcesCache;

  /// Check if a specific source is in the cache
  bool hasSource(String sourceId) => _sourcesCache.containsKey(sourceId);

  /// Get a specific source from the cache
  NewsSource? getSource(String sourceId) => _sourcesCache[sourceId];

  /// Fetch all news sources from the API
  Future<ApiResult<List<NewsSource>>> getSources({
    bool forceCache = false,
    bool refreshCache = false,
  }) async {
    try {
      // If sources are already loaded and not forcing refresh, return from cache
      if (_sourcesLoaded && _sourcesCache.isNotEmpty && !refreshCache) {
        debugPrint('📰 [SOURCES] Returning from memory cache');
        return ApiResult.success(data: _sourcesCache.values.toList());
      }

      // Get cache options and apply policy
      final cacheOptions = await _ref.read(cacheOptionsProvider.future);

      // Choose cache policy based on parameters
      final finalCacheOptions = switch ((forceCache, refreshCache)) {
        (true, _) => CacheHelper.forceCache(cacheOptions),
        (_, true) => CacheHelper.refresh(cacheOptions),
        _ => cacheOptions, // Default: respect server headers
      };

      debugPrint(
        '📰 [SOURCES] Fetching sources with cache policy: ${finalCacheOptions.policy}',
      );

      // Get the Dio instance to use cache options directly
      final dio = await _ref.read(dioProvider.future);

      // Make API call with cache options using Dio directly
      final response = await dio.get(
        '${Env.newsApiUrl}/top-headlines/sources',
        queryParameters: {'apiKey': Env.newsApiKey},
        options: finalCacheOptions.toOptions(),
      );

      // Add cache debugging
      final cacheInfo = CacheDebugger.getCacheInfo(response);
      debugPrint(cacheInfo);

      // Debug cache info
      debugPrint('📰 [SOURCES] API response status: ${response.statusCode}');
      if (response.statusCode == 304) {
        debugPrint('✅ [SOURCES] Data served from HTTP cache');
      } else {
        debugPrint('🌐 [SOURCES] Fresh data from network');
      }

      if (response.data != null && response.data['status'] == 'ok') {
        final sourcesResponse = SourcesResponse.fromJson(response.data);
        final sources =
            sourcesResponse.sources.map((source) {
              // Add icon to source if available
              final icon = SourceIconMapper.mapSourceIdToIcon(source.id);
              final enhancedSource = source.copyWith(icon: icon);

              // Add to cache
              _sourcesCache[source.id] = enhancedSource;
              return enhancedSource;
            }).toList();

        _sourcesLoaded = true;
        return ApiResult.success(data: sources);
      } else {
        return ApiResult.error(
          error: CustomNetworkFailure(message: 'Failed to load sources'),
        );
      }
    } catch (error, stackTrace) {
      final failure = handleException(error, stackTrace);
      return ApiResult.error(error: failure);
    }
  }

  /// Convenience method: Get sources with default caching (respect server headers)
  Future<ApiResult<List<NewsSource>>> getSourcesDefault() async {
    return getSources();
  }

  /// Convenience method: Get sources from cache if available, otherwise network
  Future<ApiResult<List<NewsSource>>> getSourcesPreferCache() async {
    return getSources(forceCache: true);
  }

  /// Convenience method: Always fetch fresh sources from network
  Future<ApiResult<List<NewsSource>>> getSourcesFresh() async {
    return getSources(refreshCache: true);
  }

  /// Clear the in-memory cache
  void clearMemoryCache() {
    _sourcesCache.clear();
    _sourcesLoaded = false;
    debugPrint('🗑️ [SOURCES] Memory cache cleared');
  }

  /// Clear HTTP cache for sources endpoint
  Future<void> clearHttpCache() async {
    final cacheStore = await _ref.read(cacheStoreProvider.future);
    await CacheHelper.clearCacheForUrl(
      cacheStore,
      '${Env.newsApiUrl}/top-headlines/sources',
    );
    debugPrint('🗑️ [SOURCES] HTTP cache cleared for sources endpoint');
  }

  /// Gets the source icon for a given source ID
  /// Returns null if no source is found
  String? getSourceIcon(String sourceId) {
    if (_sourcesCache.containsKey(sourceId)) {
      return _sourcesCache[sourceId]!.icon;
    }
    return SourceIconMapper.mapSourceIdToIcon(sourceId);
  }

  /// Gets the source initials for a given source name
  /// e.g. "Business Insider" -> "BI"
  String getSourceInitials(String sourceName) {
    return SourceIconMapper.getSourceInitials(sourceName);
  }
}

@riverpod
Future<SourcesRepository> sourcesRepository(Ref ref) async {
  return SourcesRepository(ref);
}

/// Provider that gives access to all sources with caching
@Riverpod(keepAlive: true)
Future<List<NewsSource>> newsSources(Ref ref) async {
  final repository = await ref.watch(sourcesRepositoryProvider.future);
  final result = await repository.getSources();

  // Schedule cache invalidation after 1 hour
  Timer(const Duration(hours: 1), () => ref.invalidateSelf());

  return switch (result) {
    Success(data: final data) => data,
    Error() => [], // Return empty list on error
  };
}
