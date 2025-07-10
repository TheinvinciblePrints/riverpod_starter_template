// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$persistentCacheStoreHash() =>
    r'3681edf92d8bdf75ee8c932b6ae87e4070a60ca8';

/// Persistent cache provider specifically for static data like countries API
/// Uses custom HiveCacheStore for data that should persist across app restarts
/// Ideal for relatively static data that doesn't change frequently
///
/// Copied from [persistentCacheStore].
@ProviderFor(persistentCacheStore)
final persistentCacheStoreProvider = FutureProvider<CacheStore>.internal(
  persistentCacheStore,
  name: r'persistentCacheStoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$persistentCacheStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersistentCacheStoreRef = FutureProviderRef<CacheStore>;
String _$persistentCacheOptionsHash() =>
    r'43b8c622e93fb71a970de4cf0d8b024c1abd450d';

/// See also [persistentCacheOptions].
@ProviderFor(persistentCacheOptions)
final persistentCacheOptionsProvider = FutureProvider<CacheOptions>.internal(
  persistentCacheOptions,
  name: r'persistentCacheOptionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$persistentCacheOptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersistentCacheOptionsRef = FutureProviderRef<CacheOptions>;
String _$persistentCacheInterceptorHash() =>
    r'c10104ffc9abdcd5ab37a7f07effa6bcc64d6238';

/// See also [persistentCacheInterceptor].
@ProviderFor(persistentCacheInterceptor)
final persistentCacheInterceptorProvider =
    FutureProvider<DioCacheInterceptor>.internal(
      persistentCacheInterceptor,
      name: r'persistentCacheInterceptorProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$persistentCacheInterceptorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PersistentCacheInterceptorRef = FutureProviderRef<DioCacheInterceptor>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
