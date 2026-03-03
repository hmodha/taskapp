import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Platform-conditional import — compiler picks the right one automatically
import 'db_connection.dart'
    if (dart.library.io) 'db_connection_native.dart'
    if (dart.library.html) 'db_connection_web.dart';

part 'app_database.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Table definitions
// ─────────────────────────────────────────────────────────────────────────────

class SavedTasksTable extends Table {
  @override
  String get tableName => 'saved_tasks';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskConfigId => text()();
  TextColumn get categoryId => text()();
  TextColumn get source => text()();
  TextColumn get taskNameKey => text().nullable()();
  TextColumn get taskNameOverride => text().nullable()();
  TextColumn get customTitle => text().nullable()();
  TextColumn get repeatOption => text()();
  TextColumn get scheduledTimesJson => text()();
  TextColumn get scheduledWeekdaysJson => text()();
  IntColumn get scheduledYearlyDateMs => integer().nullable()();
  TextColumn get scheduledYearlyDatesJson => text()();
  TextColumn get monthlyMode => text().nullable()();
  IntColumn get monthlySpecificDate => integer().nullable()();
  TextColumn get monthlyShortMonthFallback => text().nullable()();
  TextColumn get reminderMinutesJson => text()();
  BoolColumn get channelApp => boolean().withDefault(const Constant(true))();
  BoolColumn get channelAlarm => boolean().withDefault(const Constant(false))();
  BoolColumn get channelEmail => boolean().withDefault(const Constant(false))();
  BoolColumn get channelWhatsApp =>
      boolean().withDefault(const Constant(false))();
  TextColumn get locationKey => text().nullable()();
  TextColumn get customLocationName => text().nullable()();
  TextColumn get linkedTaskConfigId => text().nullable()();
  TextColumn get groupId => text().nullable()();
  IntColumn get pointsPerCompletion =>
      integer().withDefault(const Constant(1))();
  TextColumn get homeTimezone => text()();
  TextColumn get systemTimezoneAtCreation => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  TextColumn get apiResponseJson => text().nullable()();
}

class UserPreferencesTable extends Table {
  @override
  String get tableName => 'user_preferences';

  IntColumn get id => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get wakeTime => text().withDefault(const Constant('07:00'))();
  TextColumn get sleepTime => text().withDefault(const Constant('22:30'))();
  TextColumn get jobStartTime => text().withDefault(const Constant('09:00'))();
  TextColumn get jobEndTime => text().withDefault(const Constant('17:30'))();
  TextColumn get weekendWakeTime =>
      text().withDefault(const Constant('08:30'))();
  TextColumn get daysOffJson => text().withDefault(const Constant('[6,7]'))();
  TextColumn get homeTimezone =>
      text().withDefault(const Constant('Europe/London'))();
  TextColumn get homeLocationKeysJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get customLocationNamesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get householdAgeGroupsJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get vehiclesJson => text().withDefault(const Constant('[]'))();
  TextColumn get petsJson => text().withDefault(const Constant('[]'))();
  TextColumn get themeId =>
      text().withDefault(const Constant('midnight_focus'))();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  RealColumn get textScaleFactor => real().withDefault(const Constant(1.0))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get setupWizardCompleted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get postcode => text().nullable()();
  RealColumn get locationLatitude => real().nullable()();
  RealColumn get locationLongitude => real().nullable()();
  TextColumn get whatsAppNumber => text().nullable()();
  BoolColumn get whatsAppEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get emailAddress => text().nullable()();
  BoolColumn get emailEnabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ─────────────────────────────────────────────────────────────────────────────
// AppDatabase
// ─────────────────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [SavedTasksTable, UserPreferencesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {},
  );
}

Future<AppDatabase> initDatabase() async {
  final executor = await openDatabaseConnection();
  return AppDatabase(executor);
}

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'databaseProvider must be overridden in ProviderScope.',
  );
});
