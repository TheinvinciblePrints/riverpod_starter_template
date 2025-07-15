import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
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

      // Check cache status before making the request
      final cacheStore = await _ref.read(persistentCacheStoreProvider.future);
      final cacheStatus =
          await PersistentCacheDebugger.getCacheStatusBeforeRequest(
            cacheStore,
            'https://restcountries.com/v3.1/all',
          );
      debugPrint(cacheStatus);

      // Get the dedicated Dio instance for countries with persistent cache and error handling
      // This Dio instance has a cache error interceptor that will handle FormatException
      final dio = await _ref.read(countriesDioProvider.future);

      // Track request timing
      final requestStartTime = DateTime.now();
      debugPrint(
        '🚀 [COUNTRIES] Starting request at: ${requestStartTime.toIso8601String()}',
      );

      // Make API call with persistent cache options
      // Using REST Countries API which provides free country data
      final response = await dio.get(
        'https://restcountries.com/v3.1/all',
        queryParameters: {
          'fields': 'name,cca2,flag', // Only get needed fields
        },
        options: finalCacheOptions.toOptions(),
      );

      // Calculate response time
      final requestEndTime = DateTime.now();
      final responseTime = requestEndTime.difference(requestStartTime);
      debugPrint(
        '⏱️ [COUNTRIES] Request completed in: ${responseTime.inMilliseconds}ms',
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

      // Validate response data before processing
      if (response.data == null) {
        debugPrint('❌ [COUNTRIES] Response data is null');
        return ApiResult.error(
          error: CustomNetworkFailure(
            message: 'Empty response from countries API',
          ),
        );
      }

      if (response.data is! List) {
        debugPrint(
          '❌ [COUNTRIES] Response data is not a list: ${response.data.runtimeType}',
        );
        return ApiResult.error(
          error: CustomNetworkFailure(
            message: 'Invalid response format from countries API',
          ),
        );
      }

      final countriesData = response.data as List;

      // Validate that we have reasonable data
      if (countriesData.isEmpty) {
        debugPrint('⚠️ [COUNTRIES] Empty countries list received');
        return ApiResult.error(
          error: CustomNetworkFailure(message: 'No countries data available'),
        );
      }

      // Additional validation for large lists (countries API typically returns 200+ countries)
      if (countriesData.length < 50) {
        debugPrint(
          '⚠️ [COUNTRIES] Suspiciously small countries list: ${countriesData.length} items',
        );
        debugPrint(
          '🔄 [COUNTRIES] This might indicate corrupted cache, will proceed but consider force refresh',
        );
      }

      final countries = <Country>[];

      // Process countries with error handling for each item
      for (int i = 0; i < countriesData.length; i++) {
        try {
          final countryData = countriesData[i];

          // Validate individual country data structure
          if (countryData == null || countryData is! Map) {
            debugPrint(
              '⚠️ [COUNTRIES] Invalid country data at index $i: ${countryData.runtimeType}',
            );
            continue;
          }

          // Safely extract country fields with null checks
          final nameData = countryData['name'];
          if (nameData == null || nameData is! Map) {
            debugPrint(
              '⚠️ [COUNTRIES] Missing or invalid name data at index $i',
            );
            continue;
          }

          final name = nameData['common'];
          final code = countryData['cca2'];
          final flag = countryData['flag'];

          // Validate required fields
          if (name == null || name is! String || name.isEmpty) {
            debugPrint(
              '⚠️ [COUNTRIES] Missing or invalid country name at index $i',
            );
            continue;
          }

          if (code == null || code is! String || code.isEmpty) {
            debugPrint(
              '⚠️ [COUNTRIES] Missing or invalid country code at index $i',
            );
            continue;
          }

          countries.add(
            Country(
              code: code,
              name: name,
              flag: flag is String && flag.isNotEmpty ? flag : '🏳️',
            ),
          );
        } catch (itemError) {
          debugPrint(
            '⚠️ [COUNTRIES] Error processing country at index $i: $itemError',
          );
          // Continue processing other countries
          continue;
        }
      }

      // Final validation of processed countries
      if (countries.isEmpty) {
        debugPrint(
          '❌ [COUNTRIES] No valid countries could be processed from response',
        );
        return ApiResult.error(
          error: CustomNetworkFailure(
            message: 'Failed to process countries data',
          ),
        );
      }

      // Sort countries by name for consistent UI
      countries.sort((a, b) => a.name.compareTo(b.name));

      debugPrint(
        '🌍 [COUNTRIES] Successfully loaded ${countries.length} countries (processed from ${countriesData.length} raw items)',
      );
      return ApiResult.success(data: countries);
    } catch (error, stackTrace) {
      debugPrint('❌ [COUNTRIES] Unexpected error: $error');
      debugPrint('📍 [COUNTRIES] Stack trace: $stackTrace');

      // The cache error interceptor should have handled FormatException already
      // If we still get a FormatException here, it means our fallback handling
      if (error is FormatException) {
        debugPrint(
          '🚨 [COUNTRIES] FormatException still occurred despite interceptor - this indicates a deeper issue',
        );
        return ApiResult.error(
          error: CustomNetworkFailure(
            message: 'Data format error - please try again',
          ),
        );
      }

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
