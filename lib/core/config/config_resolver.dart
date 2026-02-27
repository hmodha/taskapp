import 'config_loader.dart';

/// Resolves config values through the three-level hierarchy:
///   1. user_preferences  (highest priority)
///   2. task_config       (per-task overrides)
///   3. global_config     (fallback — the global *-config.json files)
///
/// Usage:
///   final resolver = ConfigResolver(loader: loader, userPrefs: prefsMap);
///   final value = resolver.getValue('schedule.reminder_options.options_minutes');
///
/// The registry (config-registry.json) tells the resolver which global config
/// file owns which namespace, so it knows which file to look in for fallbacks.
class ConfigResolver {
  final ConfigLoader _loader;
  final Map<String, dynamic> _registry;

  // Loaded global config cache — keyed by filename
  final Map<String, Map<String, dynamic>> _globalConfigs = {};

  // User preferences overlay — set by PreferencesRepository on load/update
  Map<String, dynamic> _userPrefs = {};

  // Per-task config overlay — set when schedule screen opens for a specific task
  Map<String, dynamic> _taskConfig = {};

  ConfigResolver({
    required ConfigLoader loader,
    required Map<String, dynamic> registry,
  })  : _loader = loader,
        _registry = registry;

  // ── Overlay setters ────────────────────────────────────────────────────────

  void setUserPreferences(Map<String, dynamic> prefs) {
    _userPrefs = prefs;
  }

  void setTaskConfig(Map<String, dynamic> taskConfig) {
    _taskConfig = taskConfig;
  }

  void clearTaskConfig() {
    _taskConfig = {};
  }

  // ── Core resolution ────────────────────────────────────────────────────────

  /// Returns the resolved value for [key], traversing the hierarchy.
  ///
  /// [key] uses dot notation: 'schedule.reminder_options.options_minutes'
  ///
  /// Returns null if the key is not found at any level.
  dynamic getValue(String key) {
    // 1. User preferences
    final userVal = _getNestedValue(_userPrefs, key);
    if (_isValidValue(userVal)) return userVal;

    // 2. Task config
    final taskVal = _getNestedValue(_taskConfig, key);
    if (_isValidValue(taskVal)) return taskVal;

    // 3. Global config
    return _getGlobalValue(key);
  }

  /// Convenience: returns value as String, or [fallback] if not found/wrong type.
  String getString(String key, {String fallback = ''}) {
    final val = getValue(key);
    if (val is String) return val;
    return fallback;
  }

  /// Convenience: returns value as bool, or [fallback] if not found/wrong type.
  bool getBool(String key, {bool fallback = false}) {
    final val = getValue(key);
    if (val is bool) return val;
    return fallback;
  }

  /// Convenience: returns value as int, or [fallback] if not found/wrong type.
  int getInt(String key, {int fallback = 0}) {
    final val = getValue(key);
    if (val is int) return val;
    if (val is double) return val.toInt();
    return fallback;
  }

  /// Convenience: returns value as double, or [fallback] if not found/wrong type.
  double getDouble(String key, {double fallback = 0.0}) {
    final val = getValue(key);
    if (val is double) return val;
    if (val is int) return val.toDouble();
    return fallback;
  }

  /// Convenience: returns value as List, or empty list if not found/wrong type.
  List<T> getList<T>(String key) {
    final val = getValue(key);
    if (val is List) return val.cast<T>();
    return [];
  }

  /// Convenience: returns value as Map, or empty map if not found/wrong type.
  Map<String, dynamic> getMap(String key) {
    final val = getValue(key);
    if (val is Map<String, dynamic>) return val;
    return {};
  }

  // ── Global config resolution ───────────────────────────────────────────────

  dynamic _getGlobalValue(String key) {
    final fileName = _resolveConfigFile(key);
    if (fileName == null) return null;

    final config = _globalConfigs[fileName];
    if (config == null) return null;

    return _getNestedValue(config, key);
  }

  /// Pre-loads a global config file into the resolver's cache.
  /// Called by ConfigResolverProvider after each file is loaded.
  void cacheGlobalConfig(String fileName, Map<String, dynamic> config) {
    _globalConfigs[fileName] = config;
  }

  // ── Registry lookup ────────────────────────────────────────────────────────

  /// Finds which config file owns the given key using the registry.
  ///
  /// More specific prefixes take priority:
  ///   'notification.alarm.*' beats 'notification.*'
  String? _resolveConfigFile(String key) {
    final registryEntries = _registry['registry'] as Map<String, dynamic>?;
    if (registryEntries == null) return null;

    String? bestMatch;
    int bestMatchLength = 0;

    for (final entry in registryEntries.entries) {
      final pattern = entry.key; // e.g. 'notification.*'
      final prefix = pattern.endsWith('.*')
          ? pattern.substring(0, pattern.length - 2)
          : pattern;

      if (key.startsWith(prefix) && prefix.length > bestMatchLength) {
        bestMatch = (entry.value as Map<String, dynamic>)['file'] as String?;
        bestMatchLength = prefix.length;
      }
    }

    return bestMatch;
  }

  // ── Nested value accessor ──────────────────────────────────────────────────

  /// Traverses a nested map using dot-separated [key].
  ///
  /// e.g. 'schedule.reminder_options.options_minutes' navigates:
  ///   map['schedule']['reminder_options']['options_minutes']
  dynamic _getNestedValue(Map<String, dynamic> map, String key) {
    final parts = key.split('.');
    dynamic current = map;

    for (final part in parts) {
      if (current is! Map<String, dynamic>) return null;
      current = current[part];
      if (current == null) return null;
    }

    return current;
  }

  /// Returns true if value is non-null and non-empty-string.
  bool _isValidValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    return true;
  }
}
