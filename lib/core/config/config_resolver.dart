import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config_loader.dart';
import '../../config_models.dart';

part '../../config_resolver.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ConfigResolver
// Resolution hierarchy: user_preferences → task_config → global_config
// ─────────────────────────────────────────────────────────────────────────────

class ConfigResolver {
  ConfigResolver({required this.globalConfig, required this.userPreferences});

  final Map<String, dynamic> globalConfig;
  final Map<String, dynamic> userPreferences;

  /// Resolve a dot-notation key through the hierarchy.
  /// e.g. 'schedule.default_time' → checks user_prefs first, then global_config
  T? get<T>(String key) {
    // 1. User preferences
    final userVal = _getNestedValue(userPreferences, key);
    if (userVal is T) return userVal;

    // 2. Global config
    final globalVal = _getNestedValue(globalConfig, key);
    if (globalVal is T) return globalVal;

    return null;
  }

  /// Resolve with a fallback value if key not found in any layer
  T getOrDefault<T>(String key, T fallback) {
    return get<T>(key) ?? fallback;
  }

  /// Resolve a location override for a specific task.
  /// If task has override_keys — use those.
  /// Otherwise use the global default_locations_keys.
  /// Result is intersected with user's confirmed home locations.
  List<String> resolveLocationKeys({
    required LocationConfig? locationConfig,
    required List<String> userHomeLocationKeys,
    required List<String> customLocationKeys,
  }) {
    if (locationConfig == null || !locationConfig.enabled) return [];

    // Determine the candidate list
    final List<String> candidates =
        locationConfig.overrideKeys?.isNotEmpty == true
        ? locationConfig.overrideKeys!
        : _getGlobalLocationKeys();

    // Always include location.whole_home
    final allUserLocations = {
      ...userHomeLocationKeys,
      ...customLocationKeys,
      'location.whole_home',
    };

    // Intersect candidates with what the user confirmed they have
    return candidates.where((key) => allUserLocations.contains(key)).toList();
  }

  List<String> _getGlobalLocationKeys() {
    final locations = _getNestedValue(
      globalConfig,
      'location.default_locations_keys',
    );
    if (locations is List) return locations.cast<String>();
    return _hardcodedLocationKeys;
  }

  dynamic _getNestedValue(Map<String, dynamic> map, String dotKey) {
    final parts = dotKey.split('.');
    dynamic current = map;
    for (final part in parts) {
      if (current is Map<String, dynamic> && current.containsKey(part)) {
        current = current[part];
      } else {
        return null;
      }
    }
    return current;
  }

  /// Resolve the effective reminder options for a task.
  /// Order: user_preferred_reminders → task_config → global defaults
  List<int> resolveReminderOptions(ReminderConfig? taskReminders) {
    // User global preferred reminder options
    final userReminders = get<List>(
      'schedule.reminder_options.options_minutes',
    );
    if (userReminders != null) return userReminders.cast<int>();

    // Task-specific options
    if (taskReminders != null) return taskReminders.optionsMinutes;

    // Global fallback
    return get<List>(
          'schedule.reminder_options.default_options',
        )?.cast<int>() ??
        [10, 30, 60];
  }

  /// Resolve the effective default reminder selections for a task.
  List<int> resolveDefaultReminders(ReminderConfig? taskReminders) {
    if (taskReminders != null) return taskReminders.defaultSelectedMinutes;
    return get<List>(
          'schedule.reminder_options.default_selected',
        )?.cast<int>() ??
        [30];
  }
}

// Hardcoded fallback location keys (mirrors ui-global-config.json)
// Used if global config is unavailable
const List<String> _hardcodedLocationKeys = [
  'location.living_room',
  'location.bedroom',
  'location.second_bedroom',
  'location.third_bedroom',
  'location.bathroom',
  'location.ensuite',
  'location.kitchen',
  'location.dining_room',
  'location.hallway',
  'location.landing',
  'location.stairs',
  'location.home_office',
  'location.utility_room',
  'location.conservatory',
  'location.garage',
  'location.garden',
  'location.shed',
  'location.driveway',
  'location.loft',
  'location.cellar',
  'location.porch',
  'location.whole_home',
];

// ─────────────────────────────────────────────────────────────────────────────
// Riverpod provider
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
Future<ConfigResolver> configResolver(ConfigResolverRef ref) async {
  final loader = ref.watch(configLoaderProvider);

  // Load global configs in parallel
  final results = await Future.wait([
    loader.load('config/ui-global-config.json'),
    loader.load('config/schedule-global-config.json'),
  ]);

  // Merge global configs into one flat map
  final globalConfig = <String, dynamic>{...results[0], ...results[1]};

  // User preferences — empty map until user preferences Isar model is loaded
  // Will be replaced by a proper provider once PreferencesRepository is wired
  const userPreferences = <String, dynamic>{};

  return ConfigResolver(
    globalConfig: globalConfig,
    userPreferences: userPreferences,
  );
}
