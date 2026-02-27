import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part '../../app_database.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Table definitions
// ─────────────────────────────────────────────────────────────────────────────

/// Saved tasks — one row per scheduled task
class SavedTasksTable extends Table {
  @override
  String get tableName => 'saved_tasks';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskConfigId => text()(); // e.g. 'vehicle.car_mot'
  TextColumn get categoryId => text()(); // e.g. 'vehicle'
  TextColumn get source => text()(); // manual|dvla_api|bin_api etc.

  // Display fields
  TextColumn get taskNameKey => text().nullable()();
  TextColumn get taskNameOverride => text().nullable()();
  TextColumn get customTitle => text().nullable()();

  // Schedule
  TextColumn get repeatOption => text()(); // never|daily|weekly etc.
  TextColumn get scheduledTimesJson => text()(); // JSON: ["08:00","20:00"]
  TextColumn get scheduledWeekdaysJson => text()(); // JSON: [1,4]
  IntColumn get scheduledYearlyDateMs => integer().nullable()();
  TextColumn get scheduledYearlyDatesJson => text()(); // JSON: [ms, ms]
  TextColumn get monthlyMode =>
      text().nullable()(); // first_day|last_day|specific_date
  IntColumn get monthlySpecificDate => integer().nullable()();
  TextColumn get monthlyShortMonthFallback => text().nullable()();

  // Reminders
  TextColumn get reminderMinutesJson => text()(); // JSON: [30, 1440]

  // Notification channels
  BoolColumn get channelApp => boolean().withDefault(const Constant(true))();
  BoolColumn get channelAlarm => boolean().withDefault(const Constant(false))();
  BoolColumn get channelEmail => boolean().withDefault(const Constant(false))();
  BoolColumn get channelWhatsApp =>
      boolean().withDefault(const Constant(false))();

  // Location
  TextColumn get locationKey => text().nullable()();
  TextColumn get customLocationName => text().nullable()();

  // Linked tasks
  TextColumn get linkedTaskConfigId => text().nullable()();
  TextColumn get groupId => text().nullable()();

  // Points
  IntColumn get pointsPerCompletion =>
      integer().withDefault(const Constant(1))();

  // Timezone
  TextColumn get homeTimezone => text()();
  TextColumn get systemTimezoneAtCreation => text()();

  // Metadata
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  TextColumn get apiResponseJson => text().nullable()();
}

/// User preferences — singleton row (id always = 1)
class UserPreferencesTable extends Table {
  @override
  String get tableName => 'user_preferences';

  IntColumn get id => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};

  // Timings
  TextColumn get wakeTime => text().withDefault(const Constant('07:00'))();
  TextColumn get sleepTime => text().withDefault(const Constant('22:30'))();
  TextColumn get jobStartTime => text().withDefault(const Constant('09:00'))();
  TextColumn get jobEndTime => text().withDefault(const Constant('17:30'))();
  TextColumn get weekendWakeTime =>
      text().withDefault(const Constant('08:30'))();
  TextColumn get daysOffJson => text().withDefault(const Constant('[6,7]'))();

  // Timezone
  TextColumn get homeTimezone =>
      text().withDefault(const Constant('Europe/London'))();

  // Locations
  TextColumn get homeLocationKeysJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get customLocationNamesJson =>
      text().withDefault(const Constant('[]'))();

  // Household
  TextColumn get householdAgeGroupsJson =>
      text().withDefault(const Constant('[]'))();

  // Vehicles + Pets (JSON blobs)
  TextColumn get vehiclesJson => text().withDefault(const Constant('[]'))();
  TextColumn get petsJson => text().withDefault(const Constant('[]'))();

  // Appearance
  TextColumn get themeId =>
      text().withDefault(const Constant('midnight_focus'))();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  RealColumn get textScaleFactor => real().withDefault(const Constant(1.0))();

  // Notifications
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();

  // Onboarding
  BoolColumn get setupWizardCompleted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();

  // Location
  TextColumn get postcode => text().nullable()();
  RealColumn get locationLatitude => real().nullable()();
  RealColumn get locationLongitude => real().nullable()();

  // WhatsApp + Email
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

  AppDatabase.connect(super.connection) : super.connect();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Future migrations go here
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Database initialisation
// ─────────────────────────────────────────────────────────────────────────────

Future<AppDatabase> initDatabase() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'taskapp.sqlite'));
  return AppDatabase(NativeDatabase.createInBackground(file));
}

// ─────────────────────────────────────────────────────────────────────────────
// Riverpod provider
// ─────────────────────────────────────────────────────────────────────────────

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'databaseProvider must be overridden in ProviderScope. '
    'Call initDatabase() in main() and pass the result as an override.',
  );
});
