// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'48e60558ea6530114ea20ea03e69b9fb339ab129';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = FutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = FutureProviderRef<SharedPreferences>;
String _$secureStorageHash() => r'a4f75721472cf77465bf47f759c90de5ca30856e';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageRef = ProviderRef<FlutterSecureStorage>;
String _$preferenceStorageServiceHash() =>
    r'a1b62a2a563b92d18a8285829dea528b3ed7be22';

/// See also [preferenceStorageService].
@ProviderFor(preferenceStorageService)
final preferenceStorageServiceProvider =
    FutureProvider<IPreferenceStorage>.internal(
      preferenceStorageService,
      name: r'preferenceStorageServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$preferenceStorageServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreferenceStorageServiceRef = FutureProviderRef<IPreferenceStorage>;
String _$secureStorageServiceHash() =>
    r'afee7e5482e2adb62e60a329bf0fde275f3e456c';

/// See also [secureStorageService].
@ProviderFor(secureStorageService)
final secureStorageServiceProvider = Provider<ISecureStorage>.internal(
  secureStorageService,
  name: r'secureStorageServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$secureStorageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageServiceRef = ProviderRef<ISecureStorage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
