// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsSource _$NewsSourceFromJson(Map<String, dynamic> json) => _NewsSource(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  url: json['url'] as String,
  category: json['category'] as String,
  language: json['language'] as String,
  country: json['country'] as String,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$NewsSourceToJson(_NewsSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'category': instance.category,
      'language': instance.language,
      'country': instance.country,
      'icon': instance.icon,
    };

_SourcesResponse _$SourcesResponseFromJson(Map<String, dynamic> json) =>
    _SourcesResponse(
      status: json['status'] as String,
      sources:
          (json['sources'] as List<dynamic>)
              .map((e) => NewsSource.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SourcesResponseToJson(_SourcesResponse instance) =>
    <String, dynamic>{'status': instance.status, 'sources': instance.sources};
