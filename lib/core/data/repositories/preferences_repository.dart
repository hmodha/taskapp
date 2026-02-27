import 'package:isar/isar.dart';
import '../models/user_preferences.dart';

/// Repository for UserPreferences — always a singleton (id = 1).
class PreferencesRepository {
  final Isar _isar;

  PreferencesRepository(this._isar);

  // ── Read ───────────────────────────────────────────────────────────────────

  /// Returns the singleton UserPreferences, creating defaults if not yet saved.
  Future<UserPreferences> get() async {
    final existing = await _isar.userPreferences.get(1);
    if (existing != null) return existing;
    // First launch — create and persist defaults
    final defaults = UserPreferences();
    await _isar.writeTxn(() => _isar.userPreferences.put(defaults));
    return defaults;
  }

  /// Reactive stream — rebuilds whenever preferences change.
  Stream<UserPreferences?> watch() =>
      _isar.userPreferences.watchObject(1, fireImmediately: true);

  // ── Write ──────────────────────────────────────────────────────────────────

  Future<void> save(UserPreferences prefs) async {
    await _isar.writeTxn(() => _isar.userPreferences.put(prefs));
  }

  /// Partial update helper — load, mutate, save.
  Future<void> update(void Function(UserPreferences p) mutate) async {
    final prefs = await get();
    mutate(prefs);
    await save(prefs);
  }

  // ── Convenience setters ────────────────────────────────────────────────────

  Future<void> setSetupCompleted(bool value) =>
      update((p) => p.setupCompleted = value);

  Future<void> setActiveTheme(String themeId) =>
      update((p) => p.activeTheme = themeId);

  Future<void> setActiveLanguage(String locale) =>
      update((p) => p.activeLanguage = locale);

  Future<void> setTextSize(String size) =>
      update((p) => p.textSize = size);

  Future<void> setHomeTimezone(String tz) =>
      update((p) => p.homeTimezone = tz);

  Future<void> setSystemTimezone(String tz) =>
      update((p) => p.systemTimezone = tz);

  Future<void> setHomeLocations(List<String> locations) =>
      update((p) => p.homeLocations = locations);

  Future<void> addCustomLocation(String location) =>
      update((p) {
        if (!p.customLocations.contains(location)) {
          p.customLocations = [...p.customLocations, location];
        }
      });

  Future<void> setVisibleCategoryIds(List<String> ids) =>
      update((p) => p.visibleCategoryIds = ids);

  Future<void> setSubscription({
    required String tier,
    DateTime? expiry,
  }) => update((p) {
    p.subscriptionTier = tier;
    p.subscriptionExpiry = expiry;
  });
}
