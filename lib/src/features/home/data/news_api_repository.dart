import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/config/env/env.dart';

import '../../../network/network.dart';
import '../domain/news_article.dart';

class NewsApiRepository with NetworkErrorHandler {
  final ApiClient _apiClient;

  NewsApiRepository(this._apiClient);

  Future<ApiResult<List<NewsArticle>>> getTopHeadlines({
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

final newsApiServiceProvider = Provider<NewsApiRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NewsApiRepository(apiClient);
});
