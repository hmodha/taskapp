import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/config/config_loader.dart';
import '../../core/config/config_resolver.dart';
import '../../core/data/models/saved_task.dart';
import '../../core/data/models/user_preferences.dart';
import '../../core/commands/command.dart';
import '../../core/commands/commands/task_commands.dart';
import '../../core/data/repositories/task_repository.dart';
import '../../core/data/repositories/preferences_repository.dart';
import '../schedule/models/task_config_model.dart';
import '../schedule/notifiers/schedule_notifier.dart';

// ── Isar ──────────────────────────────────────────────────────────────────────

/// Provides the Isar instance. Initialised once at app startup.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar must be initialised before use — see main.dart');
});

// ── Repositories ──────────────────────────────────────────────────────────────

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(isarProvider));
});

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepository(ref.watch(isarProvider));
});

// ── Command infrastructure ─────────────────────────────────────────────────────

final commandDispatcherProvider = Provider<CommandDispatcher>((ref) {
  // enableLogging driven by app-global-config command_architecture.enable_command_logging
  // Hardcoded false for Phase 1; Phase 2 reads from ConfigResolver
  return const CommandDispatcher(enableLogging: false);
});

// ── Config ────────────────────────────────────────────────────────────────────

final configLoaderProvider = Provider<ConfigLoader>((ref) => ConfigLoader());

/// Provides the full config registry map (config-registry.json).
final configRegistryProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final loader = ref.watch(configLoaderProvider);
  return loader.load('assets/config/config-registry.json');
});

/// Provides the fully initialised ConfigResolver with all global configs loaded.
final configResolverProvider = FutureProvider<ConfigResolver>((ref) async {
  final loader = ref.watch(configLoaderProvider);
  final registry = await ref.watch(configRegistryProvider.future);

  final resolver = ConfigResolver(loader: loader, registry: registry);

  // Pre-load and cache all global config files
  const globalFiles = [
    ('assets/config/app-global-config.json',          'app-global-config.json'),
    ('assets/config/dashboard-global-config.json',    'dashboard-global-config.json'),
    ('assets/config/schedule-global-config.json',     'schedule-global-config.json'),
    ('assets/config/notification-global-config.json', 'notification-global-config.json'),
    ('assets/config/alarm-global-config.json',        'alarm-global-config.json'),
    ('assets/config/api-global-config.json',          'api-global-config.json'),
    ('assets/config/points-global-config.json',       'points-global-config.json'),
    ('assets/config/ui-global-config.json',           'ui-global-config.json'),
    ('assets/config/schedule-global-config.json',     'schedule-global-config.json'),
  ];

  await Future.wait(
    globalFiles.map((pair) async {
      final config = await loader.load(pair.$1);
      resolver.cacheGlobalConfig(pair.$2, config);
    }),
  );

  return resolver;
});

/// Provides the current UserPreferences as a reactive stream.
final userPreferencesProvider = StreamProvider<UserPreferences>((ref) {
  final repo = ref.watch(preferencesRepositoryProvider);
  return repo.watch().map((p) => p ?? UserPreferences());
});

// ── Category registry ─────────────────────────────────────────────────────────

/// Provides all category registry entries from category-registry.json.
/// Sorted by sort_order, filtered to enabled entries visible to the user.
final categoryRegistryProvider = FutureProvider<List<CategoryRegistryEntry>>((ref) async {
  final loader = ref.watch(configLoaderProvider);
  final json = await loader.load('assets/config/category-registry.json');

  final entries = (json['categories'] as List<dynamic>)
      .map((e) => CategoryRegistryEntry.fromJson(e as Map<String, dynamic>))
      .where((e) => e.enabled)
      .toList()
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  return entries;
});

/// Loads a specific category config file on demand.
/// Use this when user taps a category to see its task list.
final categoryConfigProvider =
    FutureProvider.family<CategoryConfig, String>((ref, categoryId) async {
  final loader = ref.watch(configLoaderProvider);
  final json = await loader.loadCategory(categoryId);
  return CategoryConfig.fromJson(json);
});

// ── Schedule form ─────────────────────────────────────────────────────────────

/// Provides the ScheduleFormNotifier for the schedule screen.
/// Family parameter: (categoryId, taskConfigId, existingTaskId?)
final scheduleFormProvider = StateNotifierProvider.family<
    ScheduleFormNotifier,
    ScheduleFormState,
    ScheduleFormArgs>((ref, args) {
  return ScheduleFormNotifier(
    args: args,
    taskRepo: ref.watch(taskRepositoryProvider),
    prefsRepo: ref.watch(preferencesRepositoryProvider),
    dispatcher: ref.watch(commandDispatcherProvider),
    configLoader: ref.watch(configLoaderProvider),
  );
});

/// Arguments for the schedule form provider.
class ScheduleFormArgs {
  final String categoryId;
  final String taskConfigId;
  final int? existingTaskId; // null = create, non-null = edit

  const ScheduleFormArgs({
    required this.categoryId,
    required this.taskConfigId,
    this.existingTaskId,
  });

  @override
  bool operator ==(Object other) =>
      other is ScheduleFormArgs &&
      other.categoryId == categoryId &&
      other.taskConfigId == taskConfigId &&
      other.existingTaskId == existingTaskId;

  @override
  int get hashCode => Object.hash(categoryId, taskConfigId, existingTaskId);
}

// ── Location ──────────────────────────────────────────────────────────────────

/// Provides the full resolved location list for a given task.
///
/// Resolution:
///   1. task override_keys (if present) filtered by user home locations
///   2. full central list filtered by user home locations
///   3. + user custom locations appended
final resolvedLocationsProvider =
    FutureProvider.family<List<String>, String>((ref, taskConfigId) async {
  final prefsAsync = ref.watch(userPreferencesProvider);
  final prefs = prefsAsync.valueOrNull ?? UserPreferences();

  final loader = ref.watch(configLoaderProvider);
  final uiConfig = await loader.load('assets/config/ui-global-config.json');

  // Full central location list
  final allLocations = (uiConfig['location']?['default_locations_keys'] as List<dynamic>?)
          ?.cast<String>() ??
      [];

  // User's selected home locations (from setup wizard Q3)
  final userLocations = prefs.homeLocations;
  final userCustom = prefs.customLocations;

  // Filter central list to user home locations
  // If user has no home locations set, show all (setup not yet completed)
  List<String> filtered;
  if (userLocations.isEmpty) {
    filtered = allLocations;
  } else {
    filtered = allLocations
        .where((loc) => userLocations.contains(loc))
        .toList();
  }

  // Append user custom locations
  return [...filtered, ...userCustom];
});
