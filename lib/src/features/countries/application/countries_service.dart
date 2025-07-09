import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/countries_repository.dart';
import '../domain/country.dart';

part 'countries_service.g.dart';

class CountriesService {
  final CountriesRepository _repository;

  CountriesService(this._repository);

  /// Fetch all available countries using persistent cache
  Future<List<Country>> getCountries() async {
    // Use default persistent caching policy (prefer cache for static data)
    final result = await _repository.getCountries();
    if (result.isSuccess) {
      return result.dataOrNull ?? [];
    } else {
      return []; // Return empty list on error
    }
  }

  /// Force refresh countries from network
  Future<List<Country>> getCountriesFresh() async {
    final result = await _repository.getCountriesFresh();
    if (result.isSuccess) {
      return result.dataOrNull ?? [];
    } else {
      return [];
    }
  }

  /// Clear the persistent cache for countries
  Future<void> clearCache() => _repository.clearCache();

  /// Get a specific country by code
  Future<Country?> getCountryByCode(String code) async {
    final countries = await getCountries();
    try {
      return countries.firstWhere(
        (country) => country.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (e) {
      return null; // Country not found
    }
  }

  /// Search countries by name
  Future<List<Country>> searchCountries(String query) async {
    final countries = await getCountries();
    if (query.isEmpty) return countries;

    return countries
        .where(
          (country) => country.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}

@riverpod
Future<CountriesService> countriesService(Ref ref) async {
  final repository = await ref.watch(countriesRepositoryProvider.future);
  return CountriesService(repository);
}
