// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sourceIconHash() => r'1fbb2f36789a81b8141b4d6364cb6410ea5735f8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// A simpler provider to just get a specific source icon
///
/// Copied from [sourceIcon].
@ProviderFor(sourceIcon)
const sourceIconProvider = SourceIconFamily();

/// A simpler provider to just get a specific source icon
///
/// Copied from [sourceIcon].
class SourceIconFamily extends Family<String?> {
  /// A simpler provider to just get a specific source icon
  ///
  /// Copied from [sourceIcon].
  const SourceIconFamily();

  /// A simpler provider to just get a specific source icon
  ///
  /// Copied from [sourceIcon].
  SourceIconProvider call(String sourceId) {
    return SourceIconProvider(sourceId);
  }

  @override
  SourceIconProvider getProviderOverride(
    covariant SourceIconProvider provider,
  ) {
    return call(provider.sourceId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sourceIconProvider';
}

/// A simpler provider to just get a specific source icon
///
/// Copied from [sourceIcon].
class SourceIconProvider extends AutoDisposeProvider<String?> {
  /// A simpler provider to just get a specific source icon
  ///
  /// Copied from [sourceIcon].
  SourceIconProvider(String sourceId)
    : this._internal(
        (ref) => sourceIcon(ref as SourceIconRef, sourceId),
        from: sourceIconProvider,
        name: r'sourceIconProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$sourceIconHash,
        dependencies: SourceIconFamily._dependencies,
        allTransitiveDependencies: SourceIconFamily._allTransitiveDependencies,
        sourceId: sourceId,
      );

  SourceIconProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sourceId,
  }) : super.internal();

  final String sourceId;

  @override
  Override overrideWith(String? Function(SourceIconRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: SourceIconProvider._internal(
        (ref) => create(ref as SourceIconRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sourceId: sourceId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String?> createElement() {
    return _SourceIconProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SourceIconProvider && other.sourceId == sourceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sourceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SourceIconRef on AutoDisposeProviderRef<String?> {
  /// The parameter `sourceId` of this provider.
  String get sourceId;
}

class _SourceIconProviderElement extends AutoDisposeProviderElement<String?>
    with SourceIconRef {
  _SourceIconProviderElement(super.provider);

  @override
  String get sourceId => (origin as SourceIconProvider).sourceId;
}

String _$sourceInitialsHash() => r'0dd6c65dcca907ff4138b5cd9d345056c369df4b';

/// A provider to get source initials
///
/// Copied from [sourceInitials].
@ProviderFor(sourceInitials)
const sourceInitialsProvider = SourceInitialsFamily();

/// A provider to get source initials
///
/// Copied from [sourceInitials].
class SourceInitialsFamily extends Family<String> {
  /// A provider to get source initials
  ///
  /// Copied from [sourceInitials].
  const SourceInitialsFamily();

  /// A provider to get source initials
  ///
  /// Copied from [sourceInitials].
  SourceInitialsProvider call(String sourceName) {
    return SourceInitialsProvider(sourceName);
  }

  @override
  SourceInitialsProvider getProviderOverride(
    covariant SourceInitialsProvider provider,
  ) {
    return call(provider.sourceName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sourceInitialsProvider';
}

/// A provider to get source initials
///
/// Copied from [sourceInitials].
class SourceInitialsProvider extends AutoDisposeProvider<String> {
  /// A provider to get source initials
  ///
  /// Copied from [sourceInitials].
  SourceInitialsProvider(String sourceName)
    : this._internal(
        (ref) => sourceInitials(ref as SourceInitialsRef, sourceName),
        from: sourceInitialsProvider,
        name: r'sourceInitialsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$sourceInitialsHash,
        dependencies: SourceInitialsFamily._dependencies,
        allTransitiveDependencies:
            SourceInitialsFamily._allTransitiveDependencies,
        sourceName: sourceName,
      );

  SourceInitialsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sourceName,
  }) : super.internal();

  final String sourceName;

  @override
  Override overrideWith(String Function(SourceInitialsRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: SourceInitialsProvider._internal(
        (ref) => create(ref as SourceInitialsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sourceName: sourceName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _SourceInitialsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SourceInitialsProvider && other.sourceName == sourceName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sourceName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SourceInitialsRef on AutoDisposeProviderRef<String> {
  /// The parameter `sourceName` of this provider.
  String get sourceName;
}

class _SourceInitialsProviderElement extends AutoDisposeProviderElement<String>
    with SourceInitialsRef {
  _SourceInitialsProviderElement(super.provider);

  @override
  String get sourceName => (origin as SourceInitialsProvider).sourceName;
}

String _$sourcesControllerHash() => r'c22e924dff109de88ff0f25b95d9a3eae9c2bc9c';

/// See also [SourcesController].
@ProviderFor(SourcesController)
final sourcesControllerProvider =
    AutoDisposeNotifierProvider<SourcesController, SourcesState>.internal(
      SourcesController.new,
      name: r'sourcesControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$sourcesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SourcesController = AutoDisposeNotifier<SourcesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
