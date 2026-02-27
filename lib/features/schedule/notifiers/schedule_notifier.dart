import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../core/commands/command.dart';
import '../../core/commands/commands/task_commands.dart';
import '../../core/config/config_models.dart';
import '../../core/data/models/saved_task.dart';

part 'schedule_notifier.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ScheduleFormState — immutable snapshot of all schedule screen fields
// ─────────────────────────────────────────────────────────────────────────────

class ScheduleFormState {
  const ScheduleFormState({
    this.taskNameOverride,
    this.customTitle,
    required this.repeatOption,
    required this.scheduledTimes,
    required this.scheduledWeekdays,
    this.scheduledYearlyDate,
    required this.scheduledYearlyDates,
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
    required this.isSaving,
    this.saveError,
  });

  final String? taskNameOverride;
  final String? customTitle;
  final RepeatOption repeatOption;
  final List<String> scheduledTimes;
  final List<int> scheduledWeekdays;
  final DateTime? scheduledYearlyDate;
  final List<DateTime> scheduledYearlyDates;
  final String? monthlyMode;
  final int? monthlySpecificDate;
  final String? monthlyShortMonthFallback;
  final List<int> reminderMinutes;
  final bool channelApp;
  final bool channelAlarm;
  final bool channelEmail;
  final bool channelWhatsApp;
  final String? locationKey;
  final String? customLocationName;
  final bool isSaving;
  final String? saveError;

  ScheduleFormState copyWith({
    String? taskNameOverride,
    bool clearTaskNameOverride = false,
    String? customTitle,
    bool clearCustomTitle = false,
    RepeatOption? repeatOption,
    List<String>? scheduledTimes,
    List<int>? scheduledWeekdays,
    DateTime? scheduledYearlyDate,
    bool clearYearlyDate = false,
    List<DateTime>? scheduledYearlyDates,
    String? monthlyMode,
    int? monthlySpecificDate,
    String? monthlyShortMonthFallback,
    List<int>? reminderMinutes,
    bool? channelApp,
    bool? channelAlarm,
    bool? channelEmail,
    bool? channelWhatsApp,
    String? locationKey,
    bool clearLocationKey = false,
    String? customLocationName,
    bool clearCustomLocationName = false,
    bool? isSaving,
    String? saveError,
    bool clearSaveError = false,
  }) {
    return ScheduleFormState(
      taskNameOverride:          clearTaskNameOverride ? null : (taskNameOverride ?? this.taskNameOverride),
      customTitle:               clearCustomTitle ? null : (customTitle ?? this.customTitle),
      repeatOption:              repeatOption ?? this.repeatOption,
      scheduledTimes:            scheduledTimes ?? this.scheduledTimes,
      scheduledWeekdays:         scheduledWeekdays ?? this.scheduledWeekdays,
      scheduledYearlyDate:       clearYearlyDate ? null : (scheduledYearlyDate ?? this.scheduledYearlyDate),
      scheduledYearlyDates:      scheduledYearlyDates ?? this.scheduledYearlyDates,
      monthlyMode:               monthlyMode ?? this.monthlyMode,
      monthlySpecificDate:       monthlySpecificDate ?? this.monthlySpecificDate,
      monthlyShortMonthFallback: monthlyShortMonthFallback ?? this.monthlyShortMonthFallback,
      reminderMinutes:           reminderMinutes ?? this.reminderMinutes,
      channelApp:                channelApp ?? this.channelApp,
      channelAlarm:              channelAlarm ?? this.channelAlarm,
      channelEmail:              channelEmail ?? this.channelEmail,
      channelWhatsApp:           channelWhatsApp ?? this.channelWhatsApp,
      locationKey:               clearLocationKey ? null : (locationKey ?? this.locationKey),
      customLocationName:        clearCustomLocationName ? null : (customLocationName ?? this.customLocationName),
      isSaving:                  isSaving ?? this.isSaving,
      saveError:                 clearSaveError ? null : (saveError ?? this.saveError),
    );
  }

  /// Build initial state from a TaskConfig's defaults
  static ScheduleFormState fromTaskConfig(TaskConfig config) {
    return ScheduleFormState(
      repeatOption:      config.defaultRepeat ?? RepeatOption.never,
      scheduledTimes:    config.multipleTimesPerDay?.defaultTimes ??
                         [config.defaultTime ?? '09:00'],
      scheduledWeekdays: _defaultWeekdays(config.defaultDays),
      scheduledYearlyDates: [],
      monthlyMode:       'specific_date',
      monthlySpecificDate: 1,
      monthlyShortMonthFallback: 'use_last_day',
      reminderMinutes:   config.reminderOptions?.defaultSelectedMinutes ?? [30],
      channelApp:        config.notificationChannels?.app    ?? true,
      channelAlarm:      config.notificationChannels?.alarm  ?? false,
      channelEmail:      config.notificationChannels?.email  ?? false,
      channelWhatsApp:   config.notificationChannels?.whatsapp ?? false,
      isSaving:          false,
    );
  }

  /// Build initial state from an existing SavedTask (for editing)
  static ScheduleFormState fromSavedTask(SavedTask task) {
    return ScheduleFormState(
      taskNameOverride:   task.taskNameOverride,
      customTitle:        task.customTitle,
      repeatOption:       RepeatOption.fromString(task.repeatOption),
      scheduledTimes:     List.from(task.scheduledTimes),
      scheduledWeekdays:  List.from(task.scheduledWeekdays),
      scheduledYearlyDate: task.yearlyDate,
      scheduledYearlyDates: task.scheduledYearlyDatesMs
          .map((ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true))
          .toList(),
      monthlyMode:        task.monthlyMode ?? 'specific_date',
      monthlySpecificDate: task.monthlySpecificDate ?? 1,
      monthlyShortMonthFallback: task.monthlyShortMonthFallback ?? 'use_last_day',
      reminderMinutes:    List.from(task.reminderMinutes),
      channelApp:         task.channelApp,
      channelAlarm:       task.channelAlarm,
      channelEmail:       task.channelEmail,
      channelWhatsApp:    task.channelWhatsApp,
      locationKey:        task.locationKey,
      customLocationName: task.customLocationName,
      isSaving:           false,
    );
  }

  static List<int> _defaultWeekdays(List<String>? dayNames) {
    if (dayNames == null || dayNames.isEmpty) return [];
    const map = {
      'monday': 1, 'tuesday': 2, 'wednesday': 3,
      'thursday': 4, 'friday': 5, 'saturday': 6, 'sunday': 7,
    };
    return dayNames.map((d) => map[d.toLowerCase()] ?? 1).toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ScheduleFormNotifier
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class ScheduleFormNotifier extends _$ScheduleFormNotifier {
  @override
  ScheduleFormState build(TaskConfig taskConfig, {SavedTask? existingTask}) {
    return existingTask != null
        ? ScheduleFormState.fromSavedTask(existingTask)
        : ScheduleFormState.fromTaskConfig(taskConfig);
  }

  // ── Field updates ─────────────────────────────────────────────────────────

  void setTaskName(String name) =>
      state = state.copyWith(taskNameOverride: name.isEmpty ? null : name);

  void setCustomTitle(String title) =>
      state = state.copyWith(customTitle: title.isEmpty ? null : title);

  void setRepeat(RepeatOption option) {
    // Reset time-related fields when switching repeat to avoid stale data
    state = state.copyWith(
      repeatOption:        option,
      clearYearlyDate:     option != RepeatOption.yearly,
      scheduledYearlyDates: option != RepeatOption.yearly ? [] : state.scheduledYearlyDates,
    );
  }

  void setTime(String time, {int index = 0}) {
    final times = List<String>.from(state.scheduledTimes);
    if (index < times.length) {
      times[index] = time;
    } else {
      times.add(time);
    }
    state = state.copyWith(scheduledTimes: times);
  }

  void addTime(String time) {
    final maxTimes = taskConfig.multipleTimesPerDay?.maxTimes ?? 6;
    if (state.scheduledTimes.length >= maxTimes) return;
    state = state.copyWith(
      scheduledTimes: [...state.scheduledTimes, time],
    );
  }

  void removeTime(int index) {
    final times = List<String>.from(state.scheduledTimes);
    if (times.length <= 1) return; // Must have at least one time
    times.removeAt(index);
    state = state.copyWith(scheduledTimes: times);
  }

  void toggleWeekday(int weekday) {
    final days = List<int>.from(state.scheduledWeekdays);
    if (days.contains(weekday)) {
      days.remove(weekday);
    } else {
      days.add(weekday);
      days.sort();
    }
    state = state.copyWith(scheduledWeekdays: days);
  }

  void setYearlyDate(DateTime date) {
    final yearlyConfig = taskConfig.yearlyConfig ?? YearlyConfig.defaults;
    if (yearlyConfig.singleDatePicker || yearlyConfig.maxDateSelections <= 1) {
      state = state.copyWith(
        scheduledYearlyDate:  date,
        scheduledYearlyDates: [date],
      );
    } else {
      // Multi-date — toggle
      final dates = List<DateTime>.from(state.scheduledYearlyDates);
      final idx   = dates.indexWhere((d) => _sameDay(d, date));
      if (idx >= 0) {
        dates.removeAt(idx);
      } else if (dates.length < yearlyConfig.maxDateSelections) {
        dates.add(date);
      }
      state = state.copyWith(scheduledYearlyDates: dates);
    }
  }

  void setMonthlyMode(String mode) =>
      state = state.copyWith(monthlyMode: mode);

  void setMonthlySpecificDate(int day) =>
      state = state.copyWith(monthlySpecificDate: day);

  void setMonthlyShortFallback(String fallback) =>
      state = state.copyWith(monthlyShortMonthFallback: fallback);

  void toggleReminder(int minutes) {
    final reminders = List<int>.from(state.reminderMinutes);
    if (reminders.contains(minutes)) {
      reminders.remove(minutes);
    } else {
      reminders.add(minutes);
    }
    state = state.copyWith(reminderMinutes: reminders);
  }

  void setChannelApp(bool value)      => state = state.copyWith(channelApp: value);
  void setChannelAlarm(bool value)    => state = state.copyWith(channelAlarm: value);
  void setChannelEmail(bool value)    => state = state.copyWith(channelEmail: value);
  void setChannelWhatsApp(bool value) => state = state.copyWith(channelWhatsApp: value);

  void setLocation(String? locationKey) {
    if (locationKey == null) {
      state = state.copyWith(clearLocationKey: true, clearCustomLocationName: true);
    } else {
      state = state.copyWith(locationKey: locationKey, clearCustomLocationName: true);
    }
  }

  void setCustomLocation(String name) {
    state = state.copyWith(
      customLocationName: name,
      clearLocationKey:   true,
    );
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<bool> save({
    required Ref ref,
    required String categoryId,
    required String homeTimezone,
    SavedTask? existingTask,
  }) async {
    state = state.copyWith(isSaving: true, clearSaveError: true);

    final task = _buildSavedTask(
      categoryId:    categoryId,
      homeTimezone:  homeTimezone,
      existingTask:  existingTask,
    );

    final command  = existingTask != null
        ? EditTaskCommand(task)
        : CreateTaskCommand(task);
    final dispatcher = ref.read(commandDispatcherProvider);
    final result     = await dispatcher.dispatch(command);

    if (result.isSuccess) {
      state = state.copyWith(isSaving: false);
      return true;
    } else {
      state = state.copyWith(
        isSaving:  false,
        saveError: result.error.toString(),
      );
      return false;
    }
  }

  // ── Validation ────────────────────────────────────────────────────────────

  bool get isValid {
    // Must have at least one scheduled time
    if (state.scheduledTimes.isEmpty) return false;

    // Weekly/biweekly must have at least one day selected
    if (state.repeatOption == RepeatOption.weekly ||
        state.repeatOption == RepeatOption.biweekly) {
      if (state.scheduledWeekdays.isEmpty) return false;
    }

    // Yearly must have a date selected
    if (state.repeatOption == RepeatOption.yearly) {
      if (state.scheduledYearlyDates.isEmpty) return false;
    }

    return true;
  }

  // ── Private builders ──────────────────────────────────────────────────────

  SavedTask _buildSavedTask({
    required String categoryId,
    required String homeTimezone,
    SavedTask? existingTask,
  }) {
    final task = existingTask ?? SavedTask();

    task
      ..taskConfigId            = taskConfig.id
      ..categoryId              = categoryId
      ..source                  = existingTask?.source ?? taskConfig.source
      ..taskNameKey             = taskConfig.nameKey
      ..taskNameOverride        = state.taskNameOverride
      ..customTitle             = state.customTitle
      ..repeatOption            = state.repeatOption.name
      ..scheduledTimes          = List.from(state.scheduledTimes)
      ..scheduledWeekdays       = List.from(state.scheduledWeekdays)
      ..scheduledYearlyDateMs   = state.scheduledYearlyDate?.millisecondsSinceEpoch
      ..scheduledYearlyDatesMs  = state.scheduledYearlyDates
          .map((d) => d.millisecondsSinceEpoch)
          .toList()
      ..monthlyMode             = state.monthlyMode
      ..monthlySpecificDate     = state.monthlySpecificDate
      ..monthlyShortMonthFallback = state.monthlyShortMonthFallback
      ..reminderMinutes         = List.from(state.reminderMinutes)
      ..channelApp              = state.channelApp
      ..channelAlarm            = state.channelAlarm
      ..channelEmail            = state.channelEmail
      ..channelWhatsApp         = state.channelWhatsApp
      ..locationKey             = state.locationKey
      ..customLocationName      = state.customLocationName
      ..linkedTaskConfigId      = taskConfig.linkedTask?.linkedTaskId
      ..groupId                 = existingTask?.groupId
      ..pointsPerCompletion     = 1
      ..homeTimezone            = homeTimezone
      ..systemTimezoneAtCreation = homeTimezone
      ..updatedAt               = DateTime.now();

    if (existingTask == null) {
      task.createdAt = DateTime.now();
      if (taskConfig.linkedTask != null) {
        task.groupId = const Uuid().v4();
      }
    }

    return task;
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
