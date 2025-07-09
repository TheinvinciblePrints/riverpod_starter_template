// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  code: json['code'] as String,
  name: json['name'] as String,
  flag: json['flag'] as String,
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'flag': instance.flag,
};

_CountriesResponse _$CountriesResponseFromJson(Map<String, dynamic> json) =>
    _CountriesResponse(
      countries:
          (json['countries'] as List<dynamic>)
              .map((e) => Country.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CountriesResponseToJson(_CountriesResponse instance) =>
    <String, dynamic>{'countries': instance.countries};
