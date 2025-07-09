// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cacheStoreHash() => r'aa9297737ba2778d0849b436d5dadd1d45fafd16';

/// Official dio_cache_interceptor approach based on the examples
/// https://github.com/llfbandit/dart_http_cache/blob/master/dio_cache_interceptor/example/lib/main.dart
/// https://github.com/llfbandit/dart_http_cache/blob/master/dio_cache_interceptor/example/lib/caller.dart
///
/// Copied from [cacheStore].
@ProviderFor(cacheStore)
final cacheStoreProvider = FutureProvider<CacheStore>.internal(
  cacheStore,
  name: r'cacheStoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cacheStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheStoreRef = FutureProviderRef<CacheStore>;
String _$cacheOptionsHash() => r'e8d646a0fecdfb196a25dfb7bd3ebbeb75853338';

/// See also [cacheOptions].
@ProviderFor(cacheOptions)
final cacheOptionsProvider = FutureProvider<CacheOptions>.internal(
  cacheOptions,
  name: r'cacheOptionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cacheOptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheOptionsRef = FutureProviderRef<CacheOptions>;
String _$cacheInterceptorHash() => r'072cee341ddd3741aef83dc5ce0d4eec847cdd70';

/// See also [cacheInterceptor].
@ProviderFor(cacheInterceptor)
final cacheInterceptorProvider = FutureProvider<DioCacheInterceptor>.internal(
  cacheInterceptor,
  name: r'cacheInterceptorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cacheInterceptorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheInterceptorRef = FutureProviderRef<DioCacheInterceptor>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
