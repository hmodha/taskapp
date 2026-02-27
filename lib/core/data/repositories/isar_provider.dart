// This file is intentionally minimal.
// The database provider has moved to lib/core/data/app_database.dart.
// Import databaseProvider from there.
//
// This file is kept so that any existing imports of isar_provider.dart
// don't cause missing-file errors during migration.
export '../app_database.dart' show AppDatabase, databaseProvider, initDatabase;
