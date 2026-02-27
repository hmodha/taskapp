import 'dart:convert';

import '../app_database.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SavedTask — domain model used throughout the app (not a DB row directly).
// Wraps SavedTasksTableData and adds computed helpers + JSON decoding.
// ─────────────────────────────────────────────────────────────────────────────

class SavedTask {
  SavedTask({
    this.id,
    required this.taskConfigId,
    required this.categoryId,
    required this.source,
    this.taskNameKey,
    this.taskNameOverride,
    this.customTitle,
    required this.repeatOption,
    required this.scheduledTimes,
    required this.scheduledWeekdays,
    this.scheduledYearlyDateMs,
    required this.scheduledYearlyDatesMs,
    this.monthlyMode,
    this.monthlySpecificDate,
    this.monthlyShortMonthFallback,
    required this.reminderMinutes,
    required this.channelApp,
    required this.channelAlarm,
    required this.channelEmail,
    required this.channelWhatsApp,
    this.locationKey,
    this.customLocationName,
    this.linkedTaskConfigId,
    this.groupId,
    required this.pointsPerCompletion,
    required this.homeTimezone,
    required this.systemTimezoneAtCreation,
    required this.createdAt,
    required this.updatedAt,
    required this.isArchived,
    this.apiResponseJson,
  });

  final int? id;
  String taskConfigId;
  String categoryId;
  String source;
  String? taskNameKey;
  String? taskNameOverride;
  String? customTitle;
  String repeatOption;
  List<String> scheduledTimes;
  List<int> scheduledWeekdays;
  int? scheduledYearlyDateMs;
  List<int> scheduledYearlyDatesMs;
  String? monthlyMode;
  int? monthlySpecificDate;
  String? monthlyShortMonthFallback;
  List<int> reminderMinutes;
  bool channelApp;
  bool channelAlarm;
  bool channelEmail;
  bool channelWhatsApp;
  String? locationKey;
  String? customLocationName;
  String? linkedTaskConfigId;
  String? groupId;
  int pointsPerCompletion;
  String homeTimezone;
  String systemTimezoneAtCreation;
  DateTime createdAt;
  DateTime updatedAt;
  bool isArchived;
  String? apiResponseJson;

  // ── Computed helpers ──────────────────────────────────────────────────────

  String get displayName => customTitle ?? taskNameOverride ?? taskConfigId;
  bool get isCustomTask => categoryId == 'custom';
  bool get hasLocation => locationKey != null || customLocationName != null;
  bool get hasMultipleTimes => scheduledTimes.length > 1;

  DateTime? get yearlyDate => scheduledYearlyDateMs != null
      ? DateTime.fromMillisecondsSinceEpoch(scheduledYearlyDateMs!, isUtc: true)
      : null;

  // ── Conversion to/from DB row ─────────────────────────────────────────────

  factory SavedTask.fromRow(SavedTasksTableData row) {
    return SavedTask(
      id: row.id,
      taskConfigId: row.taskConfigId,
      categoryId: row.categoryId,
      source: row.source,
      taskNameKey: row.taskNameKey,
      taskNameOverride: row.taskNameOverride,
      customTitle: row.customTitle,
      repeatOption: row.repeatOption,
      scheduledTimes: _decodeStringList(row.scheduledTimesJson),
      scheduledWeekdays: _decodeIntList(row.scheduledWeekdaysJson),
      scheduledYearlyDateMs: row.scheduledYearlyDateMs,
      scheduledYearlyDatesMs: _decodeIntList(row.scheduledYearlyDatesJson),
      monthlyMode: row.monthlyMode,
      monthlySpecificDate: row.monthlySpecificDate,
      monthlyShortMonthFallback: row.monthlyShortMonthFallback,
      reminderMinutes: _decodeIntList(row.reminderMinutesJson),
      channelApp: row.channelApp,
      channelAlarm: row.channelAlarm,
      channelEmail: row.channelEmail,
      channelWhatsApp: row.channelWhatsApp,
      locationKey: row.locationKey,
      customLocationName: row.customLocationName,
      linkedTaskConfigId: row.linkedTaskConfigId,
      groupId: row.groupId,
      pointsPerCompletion: row.pointsPerCompletion,
      homeTimezone: row.homeTimezone,
      systemTimezoneAtCreation: row.systemTimezoneAtCreation,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isArchived: row.isArchived,
      apiResponseJson: row.apiResponseJson,
    );
  }

  SavedTasksTableCompanion toCompanion() {
    return SavedTasksTableCompanion.insert(
      taskConfigId: taskConfigId,
      categoryId: categoryId,
      source: source,
      taskNameKey: Value(taskNameKey),
      taskNameOverride: Value(taskNameOverride),
      customTitle: Value(customTitle),
      repeatOption: repeatOption,
      scheduledTimesJson: json.encode(scheduledTimes),
      scheduledWeekdaysJson: json.encode(scheduledWeekdays),
      scheduledYearlyDateMs: Value(scheduledYearlyDateMs),
      scheduledYearlyDatesJson: json.encode(scheduledYearlyDatesMs),
      monthlyMode: Value(monthlyMode),
      monthlySpecificDate: Value(monthlySpecificDate),
      monthlyShortMonthFallback: Value(monthlyShortMonthFallback),
      reminderMinutesJson: json.encode(reminderMinutes),
      channelApp: Value(channelApp),
      channelAlarm: Value(channelAlarm),
      channelEmail: Value(channelEmail),
      channelWhatsApp: Value(channelWhatsApp),
      locationKey: Value(locationKey),
      customLocationName: Value(customLocationName),
      linkedTaskConfigId: Value(linkedTaskConfigId),
      groupId: Value(groupId),
      pointsPerCompletion: Value(pointsPerCompletion),
      homeTimezone: homeTimezone,
      systemTimezoneAtCreation: systemTimezoneAtCreation,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isArchived: Value(isArchived),
      apiResponseJson: Value(apiResponseJson),
    );
  }

  SavedTasksTableCompanion toUpdateCompanion() {
    assert(id != null, 'Cannot update a task without an id');
    return SavedTasksTableCompanion(
      id: Value(id!),
      taskConfigId: Value(taskConfigId),
      categoryId: Value(categoryId),
      source: Value(source),
      taskNameKey: Value(taskNameKey),
      taskNameOverride: Value(taskNameOverride),
      customTitle: Value(customTitle),
      repeatOption: Value(repeatOption),
      scheduledTimesJson: Value(json.encode(scheduledTimes)),
      scheduledWeekdaysJson: Value(json.encode(scheduledWeekdays)),
      scheduledYearlyDateMs: Value(scheduledYearlyDateMs),
      scheduledYearlyDatesJson: Value(json.encode(scheduledYearlyDatesMs)),
      monthlyMode: Value(monthlyMode),
      monthlySpecificDate: Value(monthlySpecificDate),
      monthlyShortMonthFallback: Value(monthlyShortMonthFallback),
      reminderMinutesJson: Value(json.encode(reminderMinutes)),
      channelApp: Value(channelApp),
      channelAlarm: Value(channelAlarm),
      channelEmail: Value(channelEmail),
      channelWhatsApp: Value(channelWhatsApp),
      locationKey: Value(locationKey),
      customLocationName: Value(customLocationName),
      linkedTaskConfigId: Value(linkedTaskConfigId),
      groupId: Value(groupId),
      pointsPerCompletion: Value(pointsPerCompletion),
      homeTimezone: Value(homeTimezone),
      systemTimezoneAtCreation: Value(systemTimezoneAtCreation),
      updatedAt: Value(updatedAt),
      isArchived: Value(isArchived),
      apiResponseJson: Value(apiResponseJson),
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
