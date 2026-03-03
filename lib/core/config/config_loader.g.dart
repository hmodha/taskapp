// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_loader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configLoaderHash() => r'd45a9c43141889331ca22474170181d41d21ae8d';

/// See also [configLoader].
@ProviderFor(configLoader)
final configLoaderProvider = AutoDisposeProvider<ConfigLoader>.internal(
  configLoader,
  name: r'configLoaderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$configLoaderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfigLoaderRef = AutoDisposeProviderRef<ConfigLoader>;
String _$categoryRegistryHash() => r'6ca60a991f2ef1f6edacfe8bda0393d86ee460ed';

/// See also [categoryRegistry].
@ProviderFor(categoryRegistry)
final categoryRegistryProvider =
    AutoDisposeFutureProvider<List<CategoryRegistryEntry>>.internal(
  categoryRegistry,
  name: r'categoryRegistryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryRegistryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRegistryRef
    = AutoDisposeFutureProviderRef<List<CategoryRegistryEntry>>;
String _$categoryConfigHash() => r'ebdd782422bf1a0bc821712d996be8a33ba37dca';

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

/// See also [categoryConfig].
@ProviderFor(categoryConfig)
const categoryConfigProvider = CategoryConfigFamily();

/// See also [categoryConfig].
class CategoryConfigFamily extends Family<AsyncValue<CategoryConfig>> {
  /// See also [categoryConfig].
  const CategoryConfigFamily();

  /// See also [categoryConfig].
  CategoryConfigProvider call(
    String categoryId,
  ) {
    return CategoryConfigProvider(
      categoryId,
    );
  }

  @override
  CategoryConfigProvider getProviderOverride(
    covariant CategoryConfigProvider provider,
  ) {
    return call(
      provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'categoryConfigProvider';
}

/// See also [categoryConfig].
class CategoryConfigProvider extends AutoDisposeFutureProvider<CategoryConfig> {
  /// See also [categoryConfig].
  CategoryConfigProvider(
    String categoryId,
  ) : this._internal(
          (ref) => categoryConfig(
            ref as CategoryConfigRef,
            categoryId,
          ),
          from: categoryConfigProvider,
          name: r'categoryConfigProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryConfigHash,
          dependencies: CategoryConfigFamily._dependencies,
          allTransitiveDependencies:
              CategoryConfigFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  CategoryConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String categoryId;

  @override
  Override overrideWith(
    FutureOr<CategoryConfig> Function(CategoryConfigRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryConfigProvider._internal(
        (ref) => create(ref as CategoryConfigRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CategoryConfig> createElement() {
    return _CategoryConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryConfigProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CategoryConfigRef on AutoDisposeFutureProviderRef<CategoryConfig> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _CategoryConfigProviderElement
    extends AutoDisposeFutureProviderElement<CategoryConfig>
    with CategoryConfigRef {
  _CategoryConfigProviderElement(super.provider);

  @override
  String get categoryId => (origin as CategoryConfigProvider).categoryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
