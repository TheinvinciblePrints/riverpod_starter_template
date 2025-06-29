// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sourcesRepositoryHash() => r'6bf674b06b4ac53947afc92787d7a1a479c57f10';

/// See also [sourcesRepository].
@ProviderFor(sourcesRepository)
final sourcesRepositoryProvider =
    AutoDisposeProvider<SourcesRepository>.internal(
      sourcesRepository,
      name: r'sourcesRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$sourcesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SourcesRepositoryRef = AutoDisposeProviderRef<SourcesRepository>;
String _$newsSourcesHash() => r'be75dde32c4688f6aa2d9f283f3a5b1e7845c52d';

/// Provider that gives access to all sources
///
/// Copied from [newsSources].
@ProviderFor(newsSources)
final newsSourcesProvider =
    AutoDisposeFutureProvider<List<NewsSource>>.internal(
      newsSources,
      name: r'newsSourcesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$newsSourcesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewsSourcesRef = AutoDisposeFutureProviderRef<List<NewsSource>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
