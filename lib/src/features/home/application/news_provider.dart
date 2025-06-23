import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result.dart';

import '../data/news_api_repository.dart';
import '../domain/article_model.dart';
import '../presentation/news_state.dart';

// News notifier to handle state changes
class NewsNotifier extends StateNotifier<NewsState> {
  final NewsApiRepository _newsApiService;

  NewsNotifier(this._newsApiService) : super(const NewsState.initial()) {
    getTopHeadlines();
  }

  Future<void> getTopHeadlines({String country = 'us'}) async {
    // Get current articles regardless of state
    final currentArticles = state.articles;

    state = NewsState.loading(articles: currentArticles);

    final result = await _newsApiService.getTopHeadlines(country: country);

    switch (result) {
      case Success(data: final newsArticles):
        final viewModels =
            newsArticles
                .map((article) => ArticleModel.fromNewsArticle(article))
                .toList();
        state = NewsState.success(articles: viewModels);

      case Error(error: final failure):
        state = NewsState.error(
          errorMessage: failure.message,
          articles: currentArticles,
        );
    }
  }
}

// Provider for the news state
final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  final newsApiService = ref.watch(newsApiServiceProvider);
  return NewsNotifier(newsApiService);
});
