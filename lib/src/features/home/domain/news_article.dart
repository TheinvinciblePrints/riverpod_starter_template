import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_article.freezed.dart';
part 'news_article.g.dart';

@freezed
abstract class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required String title,
    @Default('') String description,
    @Default('') String url,
    @JsonKey(name: 'urlToImage') String? imageUrl,
    @JsonKey(name: 'publishedAt') required String publishedAt,
    NewsSource? source,
    String? author,
    String? content,
  }) = _NewsArticle;

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);
}

@freezed
abstract class NewsSource with _$NewsSource {
  const factory NewsSource({String? id, required String name, String? icon}) =
      _NewsSource;

  factory NewsSource.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceFromJson(json);
}
