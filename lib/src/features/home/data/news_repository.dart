import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/config/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network.dart';
import '../domain/news_article.dart';

part 'news_repository.g.dart';

class NewsRepository with NetworkErrorHandler {
  final ApiClient _apiClient;

  NewsRepository(this._apiClient);

  Future<ApiResult<List<NewsArticle>>> getTopHeadlines({
    int page = 1,
    int pageSize = 1,
  }) async {
    try {
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
                    return NewsArticle.fromJson(json as Map<String, dynamic>);
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
                  return NewsArticle.fromJson(json as Map<String, dynamic>);
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
}

@riverpod
NewsRepository newsRepository(Ref ref) {
  return NewsRepository(ref.watch(apiClientProvider));
}
