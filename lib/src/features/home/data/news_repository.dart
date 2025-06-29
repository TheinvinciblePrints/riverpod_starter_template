import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/config/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network.dart';
import '../domain/news_article.dart';
import '../utils/source_icon_mapper.dart';

part 'news_repository.g.dart';

class NewsRepository with NetworkErrorHandler {
  final ApiClient _apiClient;
  // Cache for sources to avoid repeated API calls
  final Map<String, String> _sourceIconCache = {};
  bool _sourcesLoaded = false;

  NewsRepository(this._apiClient);

  Future<ApiResult<List<NewsArticle>>> getTopHeadlines({
    int page = 1,
    int pageSize = 1,
  }) async {
    try {
      // First make sure we have the sources loaded
      await _fetchSources();

      final response = await _apiClient.get(
        '${Env.newsApiUrl}/everything',
        queryParameters: {
          'q': 'trending',
          'page': page,
          'pageSize': pageSize,
          'apiKey': Env.newsApiKey,
        },
      );

      // Extract articles from the response
      if (response.data != null) {
        final articlesJson = response.data!['articles'] as List;
        final articles =
            articlesJson
                .map((json) {
                  try {
                    Map<String, dynamic> articleJson =
                        json as Map<String, dynamic>;

                    // Enhance the source with icon if available
                    if (articleJson.containsKey('source') &&
                        articleJson['source'] is Map<String, dynamic>) {
                      final Map<String, dynamic> sourceJson =
                          articleJson['source'] as Map<String, dynamic>;

                      if (sourceJson.containsKey('id') &&
                          sourceJson['id'] != null &&
                          _sourceIconCache.containsKey(sourceJson['id'])) {
                        // We have this source in our cache
                        String sourceId = sourceJson['id'] as String;
                        String? iconPath =
                            _sourceIconCache[sourceId] ??
                            SourceIconMapper.getDefaultIcon();

                        // Add the icon path to the source object
                        sourceJson['icon'] = iconPath;
                      }
                    }

                    return NewsArticle.fromJson(articleJson);
                  } catch (e) {
                    print('Error parsing article: $e');
                    return null;
                  }
                })
                .whereType<NewsArticle>() // Filter out null values
                .toList();
        return ApiResult.success(data: articles);
      } else {
        // If no data is returned, return an empty list
        return ApiResult.success(data: []);
      }
    } catch (error, stackTrace) {
      final failure = handleException(error, stackTrace);
      return ApiResult.error(error: failure);
    }
  }

  Future<ApiResult<List<NewsArticle>>> getLatestNews({
    String country = 'us',
  }) async {
    try {
      // Make sure we have sources loaded
      await _fetchSources();

      final response = await _apiClient.get(
        '${Env.newsApiUrl}/top-headlines',
        queryParameters: {'country': country, 'apiKey': Env.newsApiKey},
      );

      // Extract articles from the response
      final articlesJson = response.data!['articles'] as List;
      final articles =
          articlesJson
              .map((json) {
                try {
                  Map<String, dynamic> articleJson =
                      json as Map<String, dynamic>;

                  // Enhance the source with icon if available
                  if (articleJson.containsKey('source') &&
                      articleJson['source'] is Map<String, dynamic>) {
                    final Map<String, dynamic> sourceJson =
                        articleJson['source'] as Map<String, dynamic>;

                    if (sourceJson.containsKey('id') &&
                        sourceJson['id'] != null &&
                        _sourceIconCache.containsKey(sourceJson['id'])) {
                      // We have this source in our cache
                      String sourceId = sourceJson['id'] as String;
                      String? iconPath =
                          _sourceIconCache[sourceId] ??
                          SourceIconMapper.getDefaultIcon();

                      // Add the icon path to the source object
                      sourceJson['icon'] = iconPath;
                    }
                  }

                  return NewsArticle.fromJson(articleJson);
                } catch (e) {
                  print('Error parsing article: $e');
                  return null;
                }
              })
              .whereType<NewsArticle>() // Filter out null values
              .toList();
      return ApiResult.success(data: articles);
    } catch (error, stackTrace) {
      final failure = handleException(error, stackTrace);
      return ApiResult.error(error: failure);
    }
  }

  /// Fetches all sources and caches their icons
  Future<void> _fetchSources() async {
    if (_sourcesLoaded) return; // Skip if already loaded

    try {
      final response = await _apiClient.get(
        '${Env.newsApiUrl}/top-headlines/sources',
        queryParameters: {'apiKey': Env.newsApiKey},
      );

      if (response.data != null && response.data['status'] == 'ok') {
        final sourcesList = response.data['sources'] as List;

        for (final sourceData in sourcesList) {
          final sourceId = sourceData['id'] as String;
          final String? iconPath = SourceIconMapper.mapSourceIdToIcon(sourceId);

          if (iconPath != null) {
            _sourceIconCache[sourceId] = iconPath;
          }
        }

        _sourcesLoaded = true;
      }
    } catch (e) {
      print('Error loading sources: $e');
      // Continue even if sources loading fails
    }
  }
}

@riverpod
NewsRepository newsRepository(Ref ref) {
  return NewsRepository(ref.watch(apiClientProvider));
}
