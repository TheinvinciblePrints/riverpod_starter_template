import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api_result.dart';
import '../data/news_repository.dart';
import '../domain/article_model.dart';
import '../domain/news_article.dart';

part 'trending_news_controller.g.dart';

@riverpod
class TrendingNews extends _$TrendingNews {
  @override
  FutureOr<List<ArticleModel>> build() async {
    return await fetchTrendingNews();
  }

  /// Fetches trending news articles from the API.
  ///
  /// Sets the state to [AsyncLoading] while the data is being fetched.
  /// If the data is successfully fetched, sets the state to [AsyncData] with
  /// a list of [ArticleModel]s. If an error occurs, sets the state to
  /// [AsyncError] and returns an empty list.
  Future<List<ArticleModel>> fetchTrendingNews() async {
    state = const AsyncValue.loading();

    try {
      final result = await ref.read(newsRepositoryProvider).getTopHeadlines();

      return switch (result) {
        Success(:final data) => _mapToArticleModels(data),
        Error(:final error) => throw error,
      };
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return [];
    }
  }

  /// Maps a list of [NewsArticle]s to a list of [ArticleModel]s.
  List<ArticleModel> _mapToArticleModels(List<NewsArticle> articles) {
    return articles
        .map((article) => ArticleModel.fromNewsArticle(article))
        .toList();
  }

  /// Refreshes the trending news articles by fetching the latest data.
  ///
  /// Sets the state to loading before attempting to fetch the news. Ensures
  /// that any errors during the fetch process are captured and reflected in
  /// the state.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fetchTrendingNews());
  }
}
