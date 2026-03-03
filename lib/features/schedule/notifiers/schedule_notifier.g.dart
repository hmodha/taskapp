// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scheduleFormNotifierHash() =>
    r'b7b5c41f81d44866e80a76f2990a8b5de92f40f5';

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

abstract class _$ScheduleFormNotifier
    extends BuildlessAutoDisposeNotifier<ScheduleFormState> {
  late final TaskConfig taskConfig;
  late final SavedTask? existingTask;

  ScheduleFormState build(
    TaskConfig taskConfig, {
    SavedTask? existingTask,
  });
}

/// See also [ScheduleFormNotifier].
@ProviderFor(ScheduleFormNotifier)
const scheduleFormNotifierProvider = ScheduleFormNotifierFamily();

/// See also [ScheduleFormNotifier].
class ScheduleFormNotifierFamily extends Family<ScheduleFormState> {
  /// See also [ScheduleFormNotifier].
  const ScheduleFormNotifierFamily();

  /// See also [ScheduleFormNotifier].
  ScheduleFormNotifierProvider call(
    TaskConfig taskConfig, {
    SavedTask? existingTask,
  }) {
    return ScheduleFormNotifierProvider(
      taskConfig,
      existingTask: existingTask,
    );
  }

  @override
  ScheduleFormNotifierProvider getProviderOverride(
    covariant ScheduleFormNotifierProvider provider,
  ) {
    return call(
      provider.taskConfig,
      existingTask: provider.existingTask,
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
  String? get name => r'scheduleFormNotifierProvider';
}

/// See also [ScheduleFormNotifier].
class ScheduleFormNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ScheduleFormNotifier, ScheduleFormState> {
  /// See also [ScheduleFormNotifier].
  ScheduleFormNotifierProvider(
    TaskConfig taskConfig, {
    SavedTask? existingTask,
  }) : this._internal(
          () => ScheduleFormNotifier()
            ..taskConfig = taskConfig
            ..existingTask = existingTask,
          from: scheduleFormNotifierProvider,
          name: r'scheduleFormNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scheduleFormNotifierHash,
          dependencies: ScheduleFormNotifierFamily._dependencies,
          allTransitiveDependencies:
              ScheduleFormNotifierFamily._allTransitiveDependencies,
          taskConfig: taskConfig,
          existingTask: existingTask,
        );

  ScheduleFormNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskConfig,
    required this.existingTask,
  }) : super.internal();

  final TaskConfig taskConfig;
  final SavedTask? existingTask;

  @override
  ScheduleFormState runNotifierBuild(
    covariant ScheduleFormNotifier notifier,
  ) {
    return notifier.build(
      taskConfig,
      existingTask: existingTask,
    );
  }

  @override
  Override overrideWith(ScheduleFormNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScheduleFormNotifierProvider._internal(
        () => create()
          ..taskConfig = taskConfig
          ..existingTask = existingTask,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskConfig: taskConfig,
        existingTask: existingTask,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ScheduleFormNotifier, ScheduleFormState>
      createElement() {
    return _ScheduleFormNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScheduleFormNotifierProvider &&
        other.taskConfig == taskConfig &&
        other.existingTask == existingTask;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskConfig.hashCode);
    hash = _SystemHash.combine(hash, existingTask.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScheduleFormNotifierRef
    on AutoDisposeNotifierProviderRef<ScheduleFormState> {
  /// The parameter `taskConfig` of this provider.
  TaskConfig get taskConfig;

  /// The parameter `existingTask` of this provider.
  SavedTask? get existingTask;
}

class _ScheduleFormNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ScheduleFormNotifier,
        ScheduleFormState> with ScheduleFormNotifierRef {
  _ScheduleFormNotifierProviderElement(super.provider);

  @override
  TaskConfig get taskConfig =>
      (origin as ScheduleFormNotifierProvider).taskConfig;
  @override
  SavedTask? get existingTask =>
      (origin as ScheduleFormNotifierProvider).existingTask;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
