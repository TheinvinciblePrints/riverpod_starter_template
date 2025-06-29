import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_source.freezed.dart';
part 'news_source.g.dart';

@freezed
abstract class NewsSource with _$NewsSource {
  const factory NewsSource({
    required String id,
    required String name,
    required String description,
    required String url,
    required String category,
    required String language,
    required String country,
    String? icon,
  }) = _NewsSource;

  factory NewsSource.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceFromJson(json);
}

@freezed
abstract class SourcesResponse with _$SourcesResponse {
  const factory SourcesResponse({
    required String status,
    required List<NewsSource> sources,
  }) = _SourcesResponse;

  factory SourcesResponse.fromJson(Map<String, dynamic> json) =>
      _$SourcesResponseFromJson(json);
}
