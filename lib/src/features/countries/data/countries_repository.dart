import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network.dart';
import '../../../providers/dio_provider.dart';
import '../../../providers/persistent_cache_provider.dart';
import '../domain/country.dart';

part 'countries_repository.g.dart';

class CountriesRepository with NetworkErrorHandler {
  final Ref _ref;

  CountriesRepository(this._ref);

  /// Fetch all countries from REST Countries API with persistent caching
  Future<ApiResult<List<Country>>> getCountries({
    bool forceRefresh = false,
  }) async {
    try {
      // Get persistent cache options
      final cacheOptions = await _ref.read(
        persistentCacheOptionsProvider.future,
      );

      // Choose cache policy based on parameters
      final finalCacheOptions =
          forceRefresh
              ? PersistentCacheHelper.forceRefresh(cacheOptions)
              : cacheOptions; // Default: prefer cache for static data

      debugPrint(
        '🌍 [COUNTRIES] Fetching countries with cache policy: ${finalCacheOptions.policy}',
      );

      // Get the Dio instance to use cache options directly
      final dio = await _ref.read(dioProvider.future);

      // Make API call with persistent cache options
      // Using REST Countries API which provides free country data
      final response = await dio.get(
        'https://restcountries.com/v3.1/all',
        queryParameters: {
          'fields': 'name,cca2,flag', // Only get needed fields
        },
        options: finalCacheOptions.toOptions(),
      );

      // Add cache debugging
      final cacheInfo = PersistentCacheDebugger.getCacheInfo(response);
      debugPrint(cacheInfo);

      debugPrint('🌍 [COUNTRIES] API response status: ${response.statusCode}');
      if (response.statusCode == 304) {
        debugPrint('💾 [COUNTRIES] Data served from persistent cache');
      } else {
        debugPrint('🌐 [COUNTRIES] Fresh data from network');
      }

      if (response.data != null && response.data is List) {
        final countriesData = response.data as List;
        final countries =
            countriesData.map((countryData) {
              // Map REST Countries API response to our Country model
              final name = countryData['name']['common'] as String;
              final code = countryData['cca2'] as String;
              final flag = countryData['flag'] as String? ?? '🏳️';

              return Country(code: code, name: name, flag: flag);
            }).toList();

        // Sort countries by name for consistent UI
        countries.sort((a, b) => a.name.compareTo(b.name));

        debugPrint(
          '🌍 [COUNTRIES] Successfully loaded ${countries.length} countries',
        );
        return ApiResult.success(data: countries);
      } else {
        return ApiResult.error(
          error: CustomNetworkFailure(message: 'Failed to load countries'),
        );
      }
    } catch (error, stackTrace) {
      final failure = handleException(error, stackTrace);
      return ApiResult.error(error: failure);
    }
  }

  /// Convenience method: Get countries with default persistent caching
  Future<ApiResult<List<Country>>> getCountriesDefault() async {
    return getCountries();
  }

  /// Convenience method: Force refresh countries from network
  Future<ApiResult<List<Country>>> getCountriesFresh() async {
    return getCountries(forceRefresh: true);
  }

  /// Clear the persistent cache for countries
  Future<void> clearCache() async {
    final cacheStore = await _ref.read(persistentCacheStoreProvider.future);
    await PersistentCacheHelper.clearCacheForUrl(
      cacheStore,
      'https://restcountries.com/v3.1/all',
    );
    debugPrint(
      '🗑️ [COUNTRIES] Persistent cache cleared for countries endpoint',
    );
  }
}

@riverpod
Future<CountriesRepository> countriesRepository(Ref ref) async {
  return CountriesRepository(ref);
}
