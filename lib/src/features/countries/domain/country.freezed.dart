// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Country {

 String get code; String get name; String get flag;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,flag);

@override
String toString() {
  return 'Country(code: $code, name: $name, flag: $flag)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 String code, String name, String flag
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? flag = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Country implements Country {
  const _Country({required this.code, required this.name, required this.flag});
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override final  String code;
@override final  String name;
@override final  String flag;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,flag);

@override
String toString() {
  return 'Country(code: $code, name: $name, flag: $flag)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String flag
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? flag = null,}) {
  return _then(_Country(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CountriesResponse {

 List<Country> get countries;
/// Create a copy of CountriesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountriesResponseCopyWith<CountriesResponse> get copyWith => _$CountriesResponseCopyWithImpl<CountriesResponse>(this as CountriesResponse, _$identity);

  /// Serializes this CountriesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountriesResponse&&const DeepCollectionEquality().equals(other.countries, countries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(countries));

@override
String toString() {
  return 'CountriesResponse(countries: $countries)';
}


}

/// @nodoc
abstract mixin class $CountriesResponseCopyWith<$Res>  {
  factory $CountriesResponseCopyWith(CountriesResponse value, $Res Function(CountriesResponse) _then) = _$CountriesResponseCopyWithImpl;
@useResult
$Res call({
 List<Country> countries
});




}
/// @nodoc
class _$CountriesResponseCopyWithImpl<$Res>
    implements $CountriesResponseCopyWith<$Res> {
  _$CountriesResponseCopyWithImpl(this._self, this._then);

  final CountriesResponse _self;
  final $Res Function(CountriesResponse) _then;

/// Create a copy of CountriesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? countries = null,}) {
  return _then(_self.copyWith(
countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CountriesResponse implements CountriesResponse {
  const _CountriesResponse({required final  List<Country> countries}): _countries = countries;
  factory _CountriesResponse.fromJson(Map<String, dynamic> json) => _$CountriesResponseFromJson(json);

 final  List<Country> _countries;
@override List<Country> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}


/// Create a copy of CountriesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountriesResponseCopyWith<_CountriesResponse> get copyWith => __$CountriesResponseCopyWithImpl<_CountriesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountriesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountriesResponse&&const DeepCollectionEquality().equals(other._countries, _countries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_countries));

@override
String toString() {
  return 'CountriesResponse(countries: $countries)';
}


}

/// @nodoc
abstract mixin class _$CountriesResponseCopyWith<$Res> implements $CountriesResponseCopyWith<$Res> {
  factory _$CountriesResponseCopyWith(_CountriesResponse value, $Res Function(_CountriesResponse) _then) = __$CountriesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Country> countries
});




}
/// @nodoc
class __$CountriesResponseCopyWithImpl<$Res>
    implements _$CountriesResponseCopyWith<$Res> {
  __$CountriesResponseCopyWithImpl(this._self, this._then);

  final _CountriesResponse _self;
  final $Res Function(_CountriesResponse) _then;

/// Create a copy of CountriesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? countries = null,}) {
  return _then(_CountriesResponse(
countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,
  ));
}


}

// dart format on
