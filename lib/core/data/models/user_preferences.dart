import 'package:isar/isar.dart';

part 'user_preferences.g.dart';
part 'task_log.g.dart';

// ── UserPreferences ───────────────────────────────────────────────────────────

/// Stores all user preferences — the top level of the config resolution hierarchy.
///
/// This is a singleton collection (id = 1 always).
/// Fields map to user_preferences.* keys in the config registry.
@collection
class UserPreferences {
  Id id = 1; // Singleton

  // ── Daily timings ──────────────────────────────────────────────────────────
  String wakeUpTime           = '07:00';
  String sleepTime            = '22:30';
  String jobStartTime         = '09:00';
  String jobEndTime           = '17:30';
  String weekendWakeUpTime    = '08:30';
  String weekendSleepTime     = '23:30';
  List<String> daysOff        = ['saturday', 'sunday'];

  // ── Timezone ───────────────────────────────────────────────────────────────
  String homeTimezone         = 'Europe/London';
  String systemTimezone       = 'Europe/London';

  // ── Locations ─────────────────────────────────────────────────────────────
  /// Location i18n keys confirmed in setup wizard Q3.
  List<String> homeLocations  = [];

  /// User-created custom location strings.
  List<String> customLocations = [];

  // ── Reminders ─────────────────────────────────────────────────────────────
  /// User's preferred reminder offsets in minutes.
  List<int> preferredReminderMinutes = [30];

  // ── Notification preferences ───────────────────────────────────────────────
  bool notifyMorningSummary    = true;
  bool notifyEveningSummary    = true;
  bool notifyWeatherSummary    = true;
  bool notifyMissedTasks       = true;
  bool notifyPointMilestone    = true;

  // ── Notification channels ──────────────────────────────────────────────────
  bool defaultNotifyViaApp      = true;
  bool defaultNotifyViaAlarm    = false;
  bool defaultNotifyViaEmail    = false;
  bool defaultNotifyViaWhatsapp = false;
  String? whatsappNumber;

  // ── Vehicles ───────────────────────────────────────────────────────────────
  /// JSON-encoded list of vehicle objects.
  /// [{type, count, regPlates: [], dvlaFetched: bool}]
  String vehiclesJson = '[]';

  // ── Pets ───────────────────────────────────────────────────────────────────
  /// JSON-encoded list of pet objects.
  /// [{typeId, names: [], categoryIdsUnlocked: []}]
  String petsJson = '[]';

  // ── Household ─────────────────────────────────────────────────────────────
  List<String> householdAgeGroups = [];

  // ── Location & postcode ────────────────────────────────────────────────────
  bool locationPermissionGranted = false;
  double? locationLat;
  double? locationLng;
  String? postcode;

  // ── UI preferences ────────────────────────────────────────────────────────
  String activeTheme    = 'midnight_focus';
  String activeLanguage = 'en';
  String textSize       = 'medium'; // small | medium | large
  bool   darkMode       = true;

  // ── Points ────────────────────────────────────────────────────────────────
  String milestoneWeekday = 'sunday';

  // ── Setup wizard ──────────────────────────────────────────────────────────
  bool setupCompleted = false;

  // ── Subscription ──────────────────────────────────────────────────────────
  String subscriptionTier = 'guest'; // guest | free | premium
  DateTime? subscriptionExpiry;

  // ── Auth ──────────────────────────────────────────────────────────────────
  String? email;
  String? authProvider; // magic_link | google | apple

  // ── Cached visible category IDs ───────────────────────────────────────────
  /// Computed by CategoryVisibilityService from pet + age group selections.
  List<String> visibleCategoryIds = [];
}

// ── TaskLog ───────────────────────────────────────────────────────────────────

/// Records every task completion, miss, skip, and snooze event.
///
/// Append-only — never update existing records.
/// Used for: dashboard display, task history screen, points calculation,
/// morning/evening summary notifications.
@collection
class TaskLog {
  Id id = Isar.autoIncrement;

  @Index()
  late int savedTaskId;

  /// The task name at the time of the event (snapshot — task may be renamed).
  late String taskName;

  /// Category ID at time of event.
  late String categoryId;

  /// Event type: completed | missed | skipped | snoozed | rescheduled | unticked
  @Index()
  late String eventType;

  /// The originally scheduled time for this task occurrence (ISO 8601).
  late DateTime scheduledAt;

  /// The time the event was recorded (e.g. when user tapped Complete).
  @Index()
  late DateTime eventAt;

  /// Points awarded for this event. 0 for miss/skip/snooze.
  int pointsAwarded = 0;

  /// For snooze events: the new scheduled time.
  DateTime? snoozedUntil;

  /// For reschedule events: the new scheduled time.
  DateTime? rescheduledTo;

  /// Original scheduled time saved before a reschedule.
  DateTime? originalScheduledAt;

  /// Which time slot this log entry is for (index into scheduledTimes array).
  /// Relevant for multi-time tasks like medication.
  /// -1 = not applicable (single-time task).
  int timeSlotIndex = -1;
}

// ── PointsTransaction ─────────────────────────────────────────────────────────

part 'points_transaction.g.dart';

/// Immutable audit log for the points system.
///
/// Balance = SUM(points) across all records for this user.
/// NEVER update existing records — only append.
@collection
class PointsTransaction {
  Id id = Isar.autoIncrement;

  @Index()
  late int savedTaskId;

  late String taskName;

  /// Points value — positive for earn, negative for deduct.
  late int points;

  /// 'earn' or 'deduct'.
  late String action;

  @Index()
  late DateTime timestamp;

  /// Optional notes e.g. 'untick_within_window'.
  String? notes;
}
