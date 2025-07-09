import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
abstract class Country with _$Country {
  const factory Country({
    required String code,
    required String name,
    required String flag,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
abstract class CountriesResponse with _$CountriesResponse {
  const factory CountriesResponse({required List<Country> countries}) =
      _CountriesResponse;

  factory CountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CountriesResponseFromJson(json);
}
