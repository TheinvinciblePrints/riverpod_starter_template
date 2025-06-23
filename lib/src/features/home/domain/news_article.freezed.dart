// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsArticle {

 String get title; String get description; String get url;@JsonKey(name: 'urlToImage') String? get imageUrl;@JsonKey(name: 'publishedAt') String get publishedAt; NewsSource? get source; String? get author; String? get content;
/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsArticleCopyWith<NewsArticle> get copyWith => _$NewsArticleCopyWithImpl<NewsArticle>(this as NewsArticle, _$identity);

  /// Serializes this NewsArticle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsArticle&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.author, author) || other.author == author)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,url,imageUrl,publishedAt,source,author,content);

@override
String toString() {
  return 'NewsArticle(title: $title, description: $description, url: $url, imageUrl: $imageUrl, publishedAt: $publishedAt, source: $source, author: $author, content: $content)';
}


}

/// @nodoc
abstract mixin class $NewsArticleCopyWith<$Res>  {
  factory $NewsArticleCopyWith(NewsArticle value, $Res Function(NewsArticle) _then) = _$NewsArticleCopyWithImpl;
@useResult
$Res call({
 String title, String description, String url,@JsonKey(name: 'urlToImage') String? imageUrl,@JsonKey(name: 'publishedAt') String publishedAt, NewsSource? source, String? author, String? content
});


$NewsSourceCopyWith<$Res>? get source;

}
/// @nodoc
class _$NewsArticleCopyWithImpl<$Res>
    implements $NewsArticleCopyWith<$Res> {
  _$NewsArticleCopyWithImpl(this._self, this._then);

  final NewsArticle _self;
  final $Res Function(NewsArticle) _then;

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? url = null,Object? imageUrl = freezed,Object? publishedAt = null,Object? source = freezed,Object? author = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NewsSource?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $NewsSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _NewsArticle implements NewsArticle {
  const _NewsArticle({required this.title, this.description = '', this.url = '', @JsonKey(name: 'urlToImage') this.imageUrl, @JsonKey(name: 'publishedAt') required this.publishedAt, this.source, this.author, this.content});
  factory _NewsArticle.fromJson(Map<String, dynamic> json) => _$NewsArticleFromJson(json);

@override final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String url;
@override@JsonKey(name: 'urlToImage') final  String? imageUrl;
@override@JsonKey(name: 'publishedAt') final  String publishedAt;
@override final  NewsSource? source;
@override final  String? author;
@override final  String? content;

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsArticleCopyWith<_NewsArticle> get copyWith => __$NewsArticleCopyWithImpl<_NewsArticle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsArticle&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.author, author) || other.author == author)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,url,imageUrl,publishedAt,source,author,content);

@override
String toString() {
  return 'NewsArticle(title: $title, description: $description, url: $url, imageUrl: $imageUrl, publishedAt: $publishedAt, source: $source, author: $author, content: $content)';
}


}

/// @nodoc
abstract mixin class _$NewsArticleCopyWith<$Res> implements $NewsArticleCopyWith<$Res> {
  factory _$NewsArticleCopyWith(_NewsArticle value, $Res Function(_NewsArticle) _then) = __$NewsArticleCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String url,@JsonKey(name: 'urlToImage') String? imageUrl,@JsonKey(name: 'publishedAt') String publishedAt, NewsSource? source, String? author, String? content
});


@override $NewsSourceCopyWith<$Res>? get source;

}
/// @nodoc
class __$NewsArticleCopyWithImpl<$Res>
    implements _$NewsArticleCopyWith<$Res> {
  __$NewsArticleCopyWithImpl(this._self, this._then);

  final _NewsArticle _self;
  final $Res Function(_NewsArticle) _then;

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? url = null,Object? imageUrl = freezed,Object? publishedAt = null,Object? source = freezed,Object? author = freezed,Object? content = freezed,}) {
  return _then(_NewsArticle(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NewsSource?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NewsArticle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $NewsSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
mixin _$NewsSource {

 String? get id; String get name;
/// Create a copy of NewsSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSourceCopyWith<NewsSource> get copyWith => _$NewsSourceCopyWithImpl<NewsSource>(this as NewsSource, _$identity);

  /// Serializes this NewsSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSource&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'NewsSource(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $NewsSourceCopyWith<$Res>  {
  factory $NewsSourceCopyWith(NewsSource value, $Res Function(NewsSource) _then) = _$NewsSourceCopyWithImpl;
@useResult
$Res call({
 String? id, String name
});




}
/// @nodoc
class _$NewsSourceCopyWithImpl<$Res>
    implements $NewsSourceCopyWith<$Res> {
  _$NewsSourceCopyWithImpl(this._self, this._then);

  final NewsSource _self;
  final $Res Function(NewsSource) _then;

/// Create a copy of NewsSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NewsSource implements NewsSource {
  const _NewsSource({this.id, required this.name});
  factory _NewsSource.fromJson(Map<String, dynamic> json) => _$NewsSourceFromJson(json);

@override final  String? id;
@override final  String name;

/// Create a copy of NewsSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsSourceCopyWith<_NewsSource> get copyWith => __$NewsSourceCopyWithImpl<_NewsSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsSource&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'NewsSource(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$NewsSourceCopyWith<$Res> implements $NewsSourceCopyWith<$Res> {
  factory _$NewsSourceCopyWith(_NewsSource value, $Res Function(_NewsSource) _then) = __$NewsSourceCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name
});




}
/// @nodoc
class __$NewsSourceCopyWithImpl<$Res>
    implements _$NewsSourceCopyWith<$Res> {
  __$NewsSourceCopyWithImpl(this._self, this._then);

  final _NewsSource _self;
  final $Res Function(_NewsSource) _then;

/// Create a copy of NewsSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,}) {
  return _then(_NewsSource(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
