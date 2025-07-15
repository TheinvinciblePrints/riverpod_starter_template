// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$persistentCacheStoreHash() =>
    r'13b61693e230dd60eedd5a0752055b78db093d07';

/// Custom Hive-based CacheStore implementation for persistent caching
/// This is used for static data like countries API that should persist across app restarts
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
    r'2f005bad418440a04a0da79dd1b3239538688e32';

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
String _$cacheTrackingInterceptorHash() =>
    r'e71abe6f9f06361a26b629ce360071528dc0e583';

/// Provider for cache tracking interceptor
///
/// Copied from [cacheTrackingInterceptor].
@ProviderFor(cacheTrackingInterceptor)
final cacheTrackingInterceptorProvider =
    FutureProvider<CacheTrackingInterceptor>.internal(
      cacheTrackingInterceptor,
      name: r'cacheTrackingInterceptorProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$cacheTrackingInterceptorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheTrackingInterceptorRef =
    FutureProviderRef<CacheTrackingInterceptor>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
