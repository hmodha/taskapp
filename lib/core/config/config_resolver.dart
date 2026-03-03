import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'config_loader.dart';
import 'config_models.dart';

part 'config_resolver.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ConfigResolver
// ─────────────────────────────────────────────────────────────────────────────

class ConfigResolver {
  ConfigResolver({required this.globalConfig, required this.userPreferences});

  final Map<String, dynamic> globalConfig;
  final Map<String, dynamic> userPreferences;

  T? get<T>(String key) {
    final userVal = _getNestedValue(userPreferences, key);
    if (userVal is T) return userVal;
    final globalVal = _getNestedValue(globalConfig, key);
    if (globalVal is T) return globalVal;
    return null;
  }

  T getOrDefault<T>(String key, T fallback) => get<T>(key) ?? fallback;

  List<String> resolveLocationKeys({
    required LocationConfig? locationConfig,
    required List<String> userHomeLocationKeys,
    required List<String> customLocationKeys,
  }) {
    if (locationConfig == null || !locationConfig.enabled) return [];
    final List<String> candidates =
        locationConfig.overrideKeys?.isNotEmpty == true
            ? locationConfig.overrideKeys!
            : _getGlobalLocationKeys();
    final allUserLocations = {
      ...userHomeLocationKeys,
      ...customLocationKeys,
      'location.whole_home',
    };
    return candidates.where((key) => allUserLocations.contains(key)).toList();
  }

  List<String> _getGlobalLocationKeys() {
    final locations = _getNestedValue(globalConfig, 'location.default_locations_keys');
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

  List<int> resolveReminderOptions(ReminderConfig? taskReminders) {
    final userReminders = get<List>('schedule.reminder_options.options_minutes');
    if (userReminders != null) return userReminders.cast<int>();
    if (taskReminders != null) return taskReminders.optionsMinutes;
    return get<List>('schedule.reminder_options.default_options')?.cast<int>() ?? [10, 30, 60];
  }

  List<int> resolveDefaultReminders(ReminderConfig? taskReminders) {
    if (taskReminders != null) return taskReminders.defaultSelectedMinutes;
    return get<List>('schedule.reminder_options.default_selected')?.cast<int>() ?? [30];
  }
}

const List<String> _hardcodedLocationKeys = [
  'location.living_room', 'location.bedroom', 'location.second_bedroom',
  'location.third_bedroom', 'location.bathroom', 'location.ensuite',
  'location.kitchen', 'location.dining_room', 'location.hallway',
  'location.landing', 'location.stairs', 'location.home_office',
  'location.utility_room', 'location.conservatory', 'location.garage',
  'location.garden', 'location.shed', 'location.driveway',
  'location.loft', 'location.cellar', 'location.porch', 'location.whole_home',
];

// ─────────────────────────────────────────────────────────────────────────────
// Riverpod provider
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
Future<ConfigResolver> configResolver(Ref ref) async {
  final loader = ref.watch(configLoaderProvider);
  final results = await Future.wait([
    loader.load('config/ui-global-config.json'),
    loader.load('config/schedule-global-config.json'),
  ]);
  final globalConfig = <String, dynamic>{...results[0], ...results[1]};
  const userPreferences = <String, dynamic>{};
  return ConfigResolver(globalConfig: globalConfig, userPreferences: userPreferences);
}
