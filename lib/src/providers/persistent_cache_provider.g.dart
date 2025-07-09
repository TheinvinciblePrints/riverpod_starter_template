// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$persistentCacheStoreHash() =>
    r'4d1c645321d2a5b5f7a1b8c9e0f3a7d6e5c8b2a1';

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
    r'5e2d756432e3b6c6g8b2c9d0f4b8e7f6d9c3b2';

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
    r'6f3e867543f4c7d7h9c3d0e1f5c9f8g7e0d4c3';

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
