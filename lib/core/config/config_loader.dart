import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Loads config JSON files from assets (bundled) or remote URL (override).
///
/// Strategy — assets-first with remote override:
/// 1. Always load from assets/ as the baseline.
/// 2. On app start, check SharedPreferences for a remote override URL.
/// 3. If a remote config is available and fresher, use it and cache locally.
/// 4. Falls back to assets if remote is unreachable.
class ConfigLoader {
  static const String _remoteUrlPrefKey = 'config_remote_base_url';
  static const String _remoteCachePrefKey = 'config_remote_cache_';
  static const Duration _remoteCacheTtl = Duration(hours: 24);

  final Map<String, Map<String, dynamic>> _cache = {};

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Loads a config file by its asset path (e.g. 'assets/config/ui-global-config.json').
  /// Returns the parsed JSON map.
  Future<Map<String, dynamic>> load(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      return _cache[assetPath]!;
    }

    // Try remote override first, fall back to asset bundle
    final remoteResult = await _tryLoadRemote(assetPath);
    if (remoteResult != null) {
      _cache[assetPath] = remoteResult;
      return remoteResult;
    }

    final assetResult = await _loadFromAsset(assetPath);
    _cache[assetPath] = assetResult;
    return assetResult;
  }

  /// Pre-loads all required-on-startup configs into memory.
  Future<void> preloadStartupConfigs() async {
    const startupConfigs = [
      'assets/config/config-registry.json',
      'assets/config/app-global-config.json',
      'assets/config/language-config.json',
      'assets/config/theme-config.json',
      'assets/config/ui-global-config.json',
      'assets/config/schedule-global-config.json',
      'assets/config/category-registry.json',
    ];

    await Future.wait(startupConfigs.map(load));
  }

  /// Loads a category config file on demand.
  Future<Map<String, dynamic>> loadCategory(String categoryId) async {
    final path = 'assets/config/categories/$categoryId.json';
    return load(path);
  }

  /// Invalidates the in-memory cache for a specific config file.
  void invalidate(String assetPath) => _cache.remove(assetPath);

  /// Clears the entire in-memory cache (e.g. on app version update).
  void invalidateAll() => _cache.clear();

  /// Sets the remote base URL for config overrides.
  /// Call this from your backend integration when remote configs are ready.
  Future<void> setRemoteBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_remoteUrlPrefKey, url);
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> _loadFromAsset(String assetPath) async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final parsed = jsonDecode(raw) as Map<String, dynamic>;
      // Strip all comment keys (prefixed with '_comment') before returning
      return _stripComments(parsed);
    } catch (e) {
      throw ConfigLoadException(
        'Failed to load config from asset: $assetPath\nError: $e',
      );
    }
  }

  Future<Map<String, dynamic>?> _tryLoadRemote(String assetPath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final baseUrl = prefs.getString(_remoteUrlPrefKey);
      if (baseUrl == null) return null;

      // Convert asset path to remote path:
      // 'assets/config/ui-global-config.json' → '/ui-global-config.json'
      final fileName = assetPath.replaceFirst('assets/config/', '');
      final remoteUrl = '$baseUrl/$fileName';

      // Check cache freshness
      final cacheKey = '$_remoteCachePrefKey$fileName';
      final cachedJson = prefs.getString(cacheKey);
      final cachedAt = prefs.getInt('${cacheKey}_at') ?? 0;
      final cacheAge = DateTime.now().millisecondsSinceEpoch - cachedAt;

      if (cachedJson != null && cacheAge < _remoteCacheTtl.inMilliseconds) {
        return _stripComments(jsonDecode(cachedJson) as Map<String, dynamic>);
      }

      // Fetch from remote
      final response = await http.get(Uri.parse(remoteUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Update cache
        await prefs.setString(cacheKey, response.body);
        await prefs.setInt(
          '${cacheKey}_at',
          DateTime.now().millisecondsSinceEpoch,
        );
        return _stripComments(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
    } catch (_) {
      // Remote unreachable — fall through to asset
      return null;
    }
    return null;
  }

  /// Recursively removes all keys starting with '_comment' from a JSON map.
  /// This keeps the config files self-documenting without polluting runtime data.
  Map<String, dynamic> _stripComments(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    for (final entry in json.entries) {
      if (entry.key.startsWith('_comment')) continue;
      if (entry.value is Map<String, dynamic>) {
        result[entry.key] = _stripComments(entry.value as Map<String, dynamic>);
      } else if (entry.value is List) {
        result[entry.key] = _stripListComments(entry.value as List);
      } else {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  List<dynamic> _stripListComments(List<dynamic> list) {
    return list.map((item) {
      if (item is Map<String, dynamic>) return _stripComments(item);
      return item;
    }).toList();
  }
}

class ConfigLoadException implements Exception {
  final String message;
  const ConfigLoadException(this.message);

  @override
  String toString() => 'ConfigLoadException: $message';
}
