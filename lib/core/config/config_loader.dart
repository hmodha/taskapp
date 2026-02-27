import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'config_models.dart';

part 'config_loader.g.dart';

/// Remote override base URL.
/// Set to null to disable remote override (assets only).
/// In production: point to your CDN e.g. 'https://config.taskapp.com/v1'
const String? _remoteConfigBaseUrl = null;

// ─────────────────────────────────────────────────────────────────────────────
// ConfigLoader — loads and caches individual config files
// ─────────────────────────────────────────────────────────────────────────────

class ConfigLoader {
  ConfigLoader(this._cacheManager);

  final BaseCacheManager _cacheManager;

  // In-memory cache for this session — avoids repeated asset reads
  final Map<String, Map<String, dynamic>> _sessionCache = {};

  /// Load a config JSON file.
  /// Resolution order:
  ///   1. Session memory cache (fastest)
  ///   2. Remote URL if [_remoteConfigBaseUrl] is set and file is available
  ///   3. Bundled asset fallback (always available)
  Future<Map<String, dynamic>> load(String assetPath) async {
    if (_sessionCache.containsKey(assetPath)) {
      return _sessionCache[assetPath]!;
    }

    Map<String, dynamic>? result;

    // Attempt remote override
    if (_remoteConfigBaseUrl != null) {
      result = await _loadRemote(assetPath);
    }

    // Fall back to bundled asset
    result ??= await _loadAsset(assetPath);

    _sessionCache[assetPath] = result;
    return result;
  }

  Future<Map<String, dynamic>> _loadAsset(String assetPath) async {
    try {
      final raw = await rootBundle.loadString('assets/$assetPath');
      return json.decode(raw) as Map<String, dynamic>;
    } catch (e) {
      throw ConfigLoadException(
        'Failed to load asset config: assets/$assetPath\n$e',
      );
    }
  }

  Future<Map<String, dynamic>?> _loadRemote(String assetPath) async {
    try {
      final url = '$_remoteConfigBaseUrl/$assetPath';
      final file = await _cacheManager.getSingleFile(url);
      final raw  = await file.readAsString();
      return json.decode(raw) as Map<String, dynamic>;
    } catch (_) {
      // Remote unavailable — caller falls back to asset
      return null;
    }
  }

  /// Clear the session cache (e.g. after a user preference change)
  void clearCache() => _sessionCache.clear();

  /// Clear cache for a specific file
  void clearCacheFor(String assetPath) => _sessionCache.remove(assetPath);
}

class ConfigLoadException implements Exception {
  ConfigLoadException(this.message);
  final String message;
  @override
  String toString() => 'ConfigLoadException: $message';
}

// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
ConfigLoader configLoader(ConfigLoaderRef ref) {
  return ConfigLoader(DefaultCacheManager());
}

@riverpod
Future<List<CategoryRegistryEntry>> categoryRegistry(
  CategoryRegistryRef ref,
) async {
  final loader = ref.watch(configLoaderProvider);
  final json   = await loader.load('config/category-registry.json');

  final entries = (json['categories'] as List)
      .map((e) => CategoryRegistryEntry.fromJson(e as Map<String, dynamic>))
      .where((e) => e.enabled)
      .toList()
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  return entries;
}

@riverpod
Future<CategoryConfig> categoryConfig(
  CategoryConfigRef ref,
  String categoryId,
) async {
  final loader   = ref.watch(configLoaderProvider);
  final registry = await ref.watch(categoryRegistryProvider.future);

  final entry = registry.firstWhere(
    (e) => e.categoryId == categoryId,
    orElse: () => throw ConfigLoadException('Category not found: $categoryId'),
  );

  final json = await loader.load('config/${entry.file}');
  return CategoryConfig.fromJson(json);
}
