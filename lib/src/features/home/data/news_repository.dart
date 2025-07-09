import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/config/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/sources/application/sources_service.dart';
import '../../../network/network.dart';
import '../domain/news_article.dart';

part 'news_repository.g.dart';

class NewsRepository with NetworkErrorHandler {
  final Ref _ref;

  NewsRepository(this._ref);

  Future<ApiResult<List<NewsArticle>>> getTopHeadlines({
    int page = 1,
    int pageSize = 1,
  }) async {
    try {
      // Ensure sources are loaded first for proper mapping

      final sourcesService = await _ref.read(sourcesServiceProvider.future);
      final apiClient = await _ref.read(apiClientProvider.future);

      await sourcesService.getSources();

      final response = await apiClient.get(
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
                          sourceJson['id'] != null) {
                        // Get source info from our sources service
                        String sourceId = sourceJson['id'] as String;
                        String? iconPath = sourcesService.getSourceIcon(
                          sourceId,
                        );

                        // Get source details if available
                        final sourceDetails = sourcesService.getSource(
                          sourceId,
                        );

                        // Add country information if available
                        if (sourceDetails != null) {
                          sourceJson['country'] = sourceDetails.country;
                        }

                        // Only add icon if available
                        if (iconPath != null) {
                          sourceJson['icon'] = iconPath;
                        }
                      }
                    }

                    return NewsArticle.fromJson(articleJson);
                  } catch (e) {
                    debugPrint('Error parsing article: $e');
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
      final sourcesService = await _ref.read(sourcesServiceProvider.future);
      final apiClient = await _ref.read(apiClientProvider.future);
      // Ensure sources are loaded first for proper mapping

      await sourcesService.getSources();
      debugPrint('📰 [NEWS] Sources loaded for mapping');

      final response = await apiClient.get(
        '${Env.newsApiUrl}/top-headlines',
        queryParameters: {'country': country, 'apiKey': Env.newsApiKey},
      );

      // Debug cache info
      debugPrint('📰 [NEWS] Fetched top headlines for country: $country');

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
                        sourceJson['id'] != null) {
                      // Get the source icon from the sources service
                      String sourceId = sourceJson['id'] as String;
                      String? iconPath = sourcesService.getSourceIcon(sourceId);

                      // Get source details if available
                      final sourceDetails = sourcesService.getSource(sourceId);

                      // Add country information if available
                      if (sourceDetails != null) {
                        sourceJson['country'] = sourceDetails.country;
                      }

                      // Only add icon if available
                      sourceJson['icon'] = iconPath;
                    }
                  }

                  return NewsArticle.fromJson(articleJson);
                } catch (e) {
                  debugPrint('Error parsing article: $e');
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
}

@riverpod
Future<NewsRepository> newsRepository(Ref ref) async {
  // final apiClient = await ref.watch(apiClientProvider.future);
  // final sourcesService = ref.watch(sourcesServiceProvider).valueOrNull;

  return NewsRepository(ref);
}
