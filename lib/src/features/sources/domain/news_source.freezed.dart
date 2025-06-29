// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsSource {

 String get id; String get name; String get description; String get url; String get category; String get language; String get country; String? get icon;
/// Create a copy of NewsSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSourceCopyWith<NewsSource> get copyWith => _$NewsSourceCopyWithImpl<NewsSource>(this as NewsSource, _$identity);

  /// Serializes this NewsSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSource&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.category, category) || other.category == category)&&(identical(other.language, language) || other.language == language)&&(identical(other.country, country) || other.country == country)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,url,category,language,country,icon);

@override
String toString() {
  return 'NewsSource(id: $id, name: $name, description: $description, url: $url, category: $category, language: $language, country: $country, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $NewsSourceCopyWith<$Res>  {
  factory $NewsSourceCopyWith(NewsSource value, $Res Function(NewsSource) _then) = _$NewsSourceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String url, String category, String language, String country, String? icon
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? url = null,Object? category = null,Object? language = null,Object? country = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NewsSource implements NewsSource {
  const _NewsSource({required this.id, required this.name, required this.description, required this.url, required this.category, required this.language, required this.country, this.icon});
  factory _NewsSource.fromJson(Map<String, dynamic> json) => _$NewsSourceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String url;
@override final  String category;
@override final  String language;
@override final  String country;
@override final  String? icon;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsSource&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.category, category) || other.category == category)&&(identical(other.language, language) || other.language == language)&&(identical(other.country, country) || other.country == country)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,url,category,language,country,icon);

@override
String toString() {
  return 'NewsSource(id: $id, name: $name, description: $description, url: $url, category: $category, language: $language, country: $country, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$NewsSourceCopyWith<$Res> implements $NewsSourceCopyWith<$Res> {
  factory _$NewsSourceCopyWith(_NewsSource value, $Res Function(_NewsSource) _then) = __$NewsSourceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String url, String category, String language, String country, String? icon
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? url = null,Object? category = null,Object? language = null,Object? country = null,Object? icon = freezed,}) {
  return _then(_NewsSource(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SourcesResponse {

 String get status; List<NewsSource> get sources;
/// Create a copy of SourcesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourcesResponseCopyWith<SourcesResponse> get copyWith => _$SourcesResponseCopyWithImpl<SourcesResponse>(this as SourcesResponse, _$identity);

  /// Serializes this SourcesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourcesResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.sources, sources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(sources));

@override
String toString() {
  return 'SourcesResponse(status: $status, sources: $sources)';
}


}

/// @nodoc
abstract mixin class $SourcesResponseCopyWith<$Res>  {
  factory $SourcesResponseCopyWith(SourcesResponse value, $Res Function(SourcesResponse) _then) = _$SourcesResponseCopyWithImpl;
@useResult
$Res call({
 String status, List<NewsSource> sources
});




}
/// @nodoc
class _$SourcesResponseCopyWithImpl<$Res>
    implements $SourcesResponseCopyWith<$Res> {
  _$SourcesResponseCopyWithImpl(this._self, this._then);

  final SourcesResponse _self;
  final $Res Function(SourcesResponse) _then;

/// Create a copy of SourcesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? sources = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<NewsSource>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SourcesResponse implements SourcesResponse {
  const _SourcesResponse({required this.status, required final  List<NewsSource> sources}): _sources = sources;
  factory _SourcesResponse.fromJson(Map<String, dynamic> json) => _$SourcesResponseFromJson(json);

@override final  String status;
 final  List<NewsSource> _sources;
@override List<NewsSource> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}


/// Create a copy of SourcesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourcesResponseCopyWith<_SourcesResponse> get copyWith => __$SourcesResponseCopyWithImpl<_SourcesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourcesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourcesResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._sources, _sources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_sources));

@override
String toString() {
  return 'SourcesResponse(status: $status, sources: $sources)';
}


}

/// @nodoc
abstract mixin class _$SourcesResponseCopyWith<$Res> implements $SourcesResponseCopyWith<$Res> {
  factory _$SourcesResponseCopyWith(_SourcesResponse value, $Res Function(_SourcesResponse) _then) = __$SourcesResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, List<NewsSource> sources
});




}
/// @nodoc
class __$SourcesResponseCopyWithImpl<$Res>
    implements _$SourcesResponseCopyWith<$Res> {
  __$SourcesResponseCopyWithImpl(this._self, this._then);

  final _SourcesResponse _self;
  final $Res Function(_SourcesResponse) _then;

/// Create a copy of SourcesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? sources = null,}) {
  return _then(_SourcesResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<NewsSource>,
  ));
}


}

// dart format on
