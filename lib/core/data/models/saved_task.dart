import 'package:isar/isar.dart';

part 'saved_task.g.dart';

/// Isar model for a user-configured task.
///
/// Fields mirror the task config structure from master-tasks-config.json,
/// plus runtime fields (source, completion state, reserved social fields).
@collection
class SavedTask {
  Id id = Isar.autoIncrement;

  // ── Identity ───────────────────────────────────────────────────────────────

  /// Category ID from category-registry.json e.g. 'vehicle', 'health'.
  /// 'custom' for user-created tasks not in any category file.
  @Index()
  late String categoryId;

  /// Task config ID e.g. 'vehicle.car_mot', 'health.medication'.
  /// For custom tasks: a user-provided UUID.
  @Index()
  late String taskConfigId;

  /// The resolved display name at save time (i18n key resolved to string).
  late String taskName;

  /// User-defined custom title. Shown as a sub-label in the UI.
  /// e.g. user names their medication 'Vitamin D'.
  String? customTitle;

  // ── Schedule ───────────────────────────────────────────────────────────────

  /// Repeat frequency. One of: never, daily, weekly, biweekly,
  /// monthly, quarterly, yearly.
  late String repeatFrequency;

  /// Scheduled times as HH:mm strings.
  /// Single-time tasks have one entry. Multi-time tasks (e.g. medication) have multiple.
  late List<String> scheduledTimes;

  /// Days of week for weekly/biweekly repeat.
  /// Values: monday, tuesday, wednesday, thursday, friday, saturday, sunday.
  late List<String> scheduledDays;

  /// Scheduled date(s) for monthly/quarterly/yearly repeat.
  /// Stored as ISO 8601 date strings (yyyy-MM-dd).
  late List<String> scheduledDates;

  /// For monthly repeat: 'first_day', 'last_day', or 'specific_date'.
  String? monthlyOption;

  /// For monthly short-month fallback: 'use_last_day' or 'skip_month'.
  String? shortMonthFallback;

  // ── Location ───────────────────────────────────────────────────────────────

  /// Selected location i18n key or custom location string.
  /// null = no location (whole home).
  String? locationKey;

  // ── Reminders ─────────────────────────────────────────────────────────────

  /// Selected reminder offsets in minutes before task time.
  /// e.g. [30, 1440] = 30 min and 1 day before.
  late List<int> reminderMinutes;

  // ── Notification channels ──────────────────────────────────────────────────

  bool notifyViaApp       = true;
  bool notifyViaAlarm     = false;
  bool notifyViaEmail     = false;
  bool notifyViaWhatsapp  = false;

  // ── Source ────────────────────────────────────────────────────────────────

  /// How this task was created.
  /// One of: manual, dvla_api, bin_api, gp_api, push_server, setup_wizard.
  @Index()
  late String source;

  // ── Timezone ──────────────────────────────────────────────────────────────

  /// User's home timezone at time of saving e.g. 'Europe/London'.
  /// Notifications fire at this timezone regardless of device timezone.
  late String homeTimezone;

  /// Device timezone at time of saving — used for drift detection.
  late String systemTimezone;

  // ── Paired tasks ──────────────────────────────────────────────────────────

  /// ID of a paired task (e.g. Bin Out ↔ Bin In).
  /// null = no paired task.
  int? pairedTaskId;

  // ── API metadata ──────────────────────────────────────────────────────────

  /// API type that created this task. null for manual tasks.
  /// One of: dvla, bin_collection, gp, push_server.
  String? apiType;

  /// Raw API response data stored at creation time (JSON string).
  /// Used for debugging and future re-processing.
  String? apiResponseSnapshot;

  // ── Reserved — future social features ────────────────────────────────────

  /// Future: ID of user this task is assigned to.
  String? assignedTo;

  /// Future: household group ID.
  String? groupId;

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  late DateTime createdAt;

  late DateTime updatedAt;

  /// Whether this task is active. false = soft-deleted.
  bool isActive = true;

  // ── Custom task flag ──────────────────────────────────────────────────────

  /// true if this task was created by the user, not from a config file.
  bool isCustom = false;
}
