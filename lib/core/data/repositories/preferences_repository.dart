import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_database.dart';
import '../../../../models/user_preferences.dart';

part '../../../preferences_repository.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PreferencesRepository — singleton UserPreferences row in drift
// ─────────────────────────────────────────────────────────────────────────────

class PreferencesRepository {
  PreferencesRepository(this._db);

  final AppDatabase _db;

  Future<UserPreferences> get() async {
    final row = await (_db.select(
      _db.userPreferencesTable,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    return row != null ? UserPreferences.fromRow(row) : UserPreferences();
  }

  Future<UserPreferences> save(UserPreferences prefs) async {
    final companion = prefs.toCompanion();
    await _db.into(_db.userPreferencesTable).insertOnConflictUpdate(companion);
    return prefs;
  }

  Stream<UserPreferences> watch() {
    return (_db.select(
      _db.userPreferencesTable,
    )..where((t) => t.id.equals(1))).watchSingleOrNull().map(
      (row) => row != null ? UserPreferences.fromRow(row) : UserPreferences(),
    );
  }

  Future<void> addCustomLocation(String locationName) async {
    final prefs = await get();
    if (!prefs.customLocationNames.contains(locationName)) {
      prefs.customLocationNames = [...prefs.customLocationNames, locationName];
      await save(prefs);
    }
  }

  Future<void> removeCustomLocation(String locationName) async {
    final prefs = await get();
    prefs.customLocationNames = prefs.customLocationNames
        .where((l) => l != locationName)
        .toList();
    await save(prefs);
  }
}

@riverpod
PreferencesRepository preferencesRepository(PreferencesRepositoryRef ref) {
  return PreferencesRepository(ref.watch(databaseProvider));
}

@riverpod
Future<UserPreferences> userPreferences(UserPreferencesRef ref) async {
  return ref.watch(preferencesRepositoryProvider).get();
}
