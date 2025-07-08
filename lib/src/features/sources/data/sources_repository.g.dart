// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sourcesRepositoryHash() => r'b7e3c8cfcf8f4186871d70ba11bc34a76a70c17b';

/// See also [sourcesRepository].
@ProviderFor(sourcesRepository)
final sourcesRepositoryProvider =
    AutoDisposeFutureProvider<SourcesRepository>.internal(
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
typedef SourcesRepositoryRef = AutoDisposeFutureProviderRef<SourcesRepository>;
String _$newsSourcesHash() => r'fe333b415630c4dc579928f3904ea8dd6f44d386';

/// Provider that gives access to all sources with caching
///
/// Copied from [newsSources].
@ProviderFor(newsSources)
final newsSourcesProvider = FutureProvider<List<NewsSource>>.internal(
  newsSources,
  name: r'newsSourcesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$newsSourcesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewsSourcesRef = FutureProviderRef<List<NewsSource>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
