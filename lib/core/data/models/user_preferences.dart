import 'dart:convert';

import '../app_database.dart';

// ─────────────────────────────────────────────────────────────────────────────
// UserPreferences — domain model wrapping UserPreferencesTableData
// ─────────────────────────────────────────────────────────────────────────────

class UserPreferences {
  UserPreferences({
    this.wakeTime = '07:00',
    this.sleepTime = '22:30',
    this.jobStartTime = '09:00',
    this.jobEndTime = '17:30',
    this.weekendWakeTime = '08:30',
    this.daysOff = const [6, 7],
    this.homeTimezone = 'Europe/London',
    this.homeLocationKeys = const [],
    this.customLocationNames = const [],
    this.householdAgeGroups = const [],
    this.vehiclesJson = '[]',
    this.petsJson = '[]',
    this.themeId = 'midnight_focus',
    this.languageCode = 'en',
    this.textScaleFactor = 1.0,
    this.notificationsEnabled = true,
    this.setupWizardCompleted = false,
    this.onboardingCompleted = false,
    this.postcode,
    this.locationLatitude,
    this.locationLongitude,
    this.whatsAppNumber,
    this.whatsAppEnabled = false,
    this.emailAddress,
    this.emailEnabled = false,
  });

  String wakeTime;
  String sleepTime;
  String jobStartTime;
  String jobEndTime;
  String weekendWakeTime;
  List<int> daysOff;
  String homeTimezone;
  List<String> homeLocationKeys;
  List<String> customLocationNames;
  List<String> householdAgeGroups;
  String vehiclesJson;
  String petsJson;
  String themeId;
  String languageCode;
  double textScaleFactor;
  bool notificationsEnabled;
  bool setupWizardCompleted;
  bool onboardingCompleted;
  String? postcode;
  double? locationLatitude;
  double? locationLongitude;
  String? whatsAppNumber;
  bool whatsAppEnabled;
  String? emailAddress;
  bool emailEnabled;

  // ── Computed helpers ──────────────────────────────────────────────────────

  bool get hasAnyHomeLocations => homeLocationKeys.isNotEmpty;

  List<String> get allLocationKeys => [
    ...homeLocationKeys,
    ...customLocationNames.map((n) => 'custom.$n'),
  ];

  // ── Conversion ────────────────────────────────────────────────────────────

  factory UserPreferences.fromRow(UserPreferencesTableData row) {
    return UserPreferences(
      wakeTime: row.wakeTime,
      sleepTime: row.sleepTime,
      jobStartTime: row.jobStartTime,
      jobEndTime: row.jobEndTime,
      weekendWakeTime: row.weekendWakeTime,
      daysOff: _decodeIntList(row.daysOffJson),
      homeTimezone: row.homeTimezone,
      homeLocationKeys: _decodeStringList(row.homeLocationKeysJson),
      customLocationNames: _decodeStringList(row.customLocationNamesJson),
      householdAgeGroups: _decodeStringList(row.householdAgeGroupsJson),
      vehiclesJson: row.vehiclesJson,
      petsJson: row.petsJson,
      themeId: row.themeId,
      languageCode: row.languageCode,
      textScaleFactor: row.textScaleFactor,
      notificationsEnabled: row.notificationsEnabled,
      setupWizardCompleted: row.setupWizardCompleted,
      onboardingCompleted: row.onboardingCompleted,
      postcode: row.postcode,
      locationLatitude: row.locationLatitude,
      locationLongitude: row.locationLongitude,
      whatsAppNumber: row.whatsAppNumber,
      whatsAppEnabled: row.whatsAppEnabled,
      emailAddress: row.emailAddress,
      emailEnabled: row.emailEnabled,
    );
  }

  UserPreferencesTableCompanion toCompanion() {
    final now = DateTime.now();
    return UserPreferencesTableCompanion(
      id: const Value(1),
      wakeTime: Value(wakeTime),
      sleepTime: Value(sleepTime),
      jobStartTime: Value(jobStartTime),
      jobEndTime: Value(jobEndTime),
      weekendWakeTime: Value(weekendWakeTime),
      daysOffJson: Value(json.encode(daysOff)),
      homeTimezone: Value(homeTimezone),
      homeLocationKeysJson: Value(json.encode(homeLocationKeys)),
      customLocationNamesJson: Value(json.encode(customLocationNames)),
      householdAgeGroupsJson: Value(json.encode(householdAgeGroups)),
      vehiclesJson: Value(vehiclesJson),
      petsJson: Value(petsJson),
      themeId: Value(themeId),
      languageCode: Value(languageCode),
      textScaleFactor: Value(textScaleFactor),
      notificationsEnabled: Value(notificationsEnabled),
      setupWizardCompleted: Value(setupWizardCompleted),
      onboardingCompleted: Value(onboardingCompleted),
      postcode: Value(postcode),
      locationLatitude: Value(locationLatitude),
      locationLongitude: Value(locationLongitude),
      whatsAppNumber: Value(whatsAppNumber),
      whatsAppEnabled: Value(whatsAppEnabled),
      emailAddress: Value(emailAddress),
      emailEnabled: Value(emailEnabled),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }

  static List<String> _decodeStringList(String raw) {
    try {
      return (jsonDecode(raw) as List).cast<String>();
    } catch (_) {
      return [];
    }
  }

  static List<int> _decodeIntList(String raw) {
    try {
      return (jsonDecode(raw) as List).cast<int>();
    } catch (_) {
      return [];
    }
  }
}
