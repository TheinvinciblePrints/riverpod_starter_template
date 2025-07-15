// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'87df224f9bd119d822c6b77396c883bb32031e76';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = FutureProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = FutureProviderRef<Dio>;
String _$countriesDioHash() => r'b4fee3b5eaa1c58d1440b39dffc1ecf0e6a88296';

/// Dedicated Dio instance for countries API with persistent cache and error handling
/// This prevents cache corruption issues from affecting other API calls
///
/// Copied from [countriesDio].
@ProviderFor(countriesDio)
final countriesDioProvider = FutureProvider<Dio>.internal(
  countriesDio,
  name: r'countriesDioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countriesDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CountriesDioRef = FutureProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
