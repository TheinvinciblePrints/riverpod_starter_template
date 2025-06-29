import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/config/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network.dart';
import '../domain/news_source.dart';
import '../utils/source_icon_mapper.dart';

part 'sources_repository.g.dart';

class SourcesRepository with NetworkErrorHandler {
  final ApiClient _apiClient;
  // Cache for sources to avoid repeated API calls
  final Map<String, NewsSource> _sourcesCache = {};
  bool _sourcesLoaded = false;

  SourcesRepository(this._apiClient);

  /// Get the cached sources
  Map<String, NewsSource> get sourcesCache => _sourcesCache;

  /// Check if a specific source is in the cache
  bool hasSource(String sourceId) => _sourcesCache.containsKey(sourceId);

  /// Get a specific source from the cache
  NewsSource? getSource(String sourceId) => _sourcesCache[sourceId];

  /// Fetch all news sources from the API
  Future<ApiResult<List<NewsSource>>> getSources() async {
    try {
      // If sources are already loaded, return from cache
      if (_sourcesLoaded && _sourcesCache.isNotEmpty) {
        return ApiResult.success(data: _sourcesCache.values.toList());
      }

      // Otherwise fetch from API
      final response = await _apiClient.get(
        '${Env.newsApiUrl}/top-headlines/sources',
        queryParameters: {'apiKey': Env.newsApiKey},
      );

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
SourcesRepository sourcesRepository(Ref ref) {
  return SourcesRepository(ref.watch(apiClientProvider));
}

/// Provider that gives access to all sources
@riverpod
Future<List<NewsSource>> newsSources(Ref ref) async {
  final repository = ref.watch(sourcesRepositoryProvider);
  final result = await repository.getSources();
  return switch (result) {
    Success(data: final data) => data,
    Error() => [], // Return empty list on error
  };
}
