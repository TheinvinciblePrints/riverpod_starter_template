// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsArticle _$NewsArticleFromJson(Map<String, dynamic> json) => _NewsArticle(
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  url: json['url'] as String? ?? '',
  imageUrl: json['urlToImage'] as String?,
  publishedAt: json['publishedAt'] as String,
  source:
      json['source'] == null
          ? null
          : NewsSource.fromJson(json['source'] as Map<String, dynamic>),
  author: json['author'] as String?,
  content: json['content'] as String?,
);

Map<String, dynamic> _$NewsArticleToJson(_NewsArticle instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.imageUrl,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'author': instance.author,
      'content': instance.content,
    };

_NewsSource _$NewsSourceFromJson(Map<String, dynamic> json) =>
    _NewsSource(id: json['id'] as String?, name: json['name'] as String);

Map<String, dynamic> _$NewsSourceToJson(_NewsSource instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
