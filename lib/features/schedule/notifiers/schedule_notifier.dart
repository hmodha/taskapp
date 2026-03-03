import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/commands/command.dart';
import '../../../core/commands/commands/task_commands.dart';
import '../../../core/config/config_models.dart';
import '../../../core/data/models/saved_task.dart';

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

  final String?        taskNameOverride;
  final String?        customTitle;
  final RepeatOption   repeatOption;
  final List<String>   scheduledTimes;
  final List<int>      scheduledWeekdays;
  final DateTime?      scheduledYearlyDate;
  final List<DateTime> scheduledYearlyDates;
  final String?        monthlyMode;
  final int?           monthlySpecificDate;
  final String?        monthlyShortMonthFallback;
  final List<int>      reminderMinutes;
  final bool           channelApp;
  final bool           channelAlarm;
  final bool           channelEmail;
  final bool           channelWhatsApp;
  final String?        locationKey;
  final String?        customLocationName;
  final bool           isSaving;
  final String?        saveError;

  ScheduleFormState copyWith({
    String?        taskNameOverride,
    bool           clearTaskNameOverride = false,
    String?        customTitle,
    bool           clearCustomTitle = false,
    RepeatOption?  repeatOption,
    List<String>?  scheduledTimes,
    List<int>?     scheduledWeekdays,
    DateTime?      scheduledYearlyDate,
    bool           clearYearlyDate = false,
    List<DateTime>? scheduledYearlyDates,
    String?        monthlyMode,
    int?           monthlySpecificDate,
    String?        monthlyShortMonthFallback,
    List<int>?     reminderMinutes,
    bool?          channelApp,
    bool?          channelAlarm,
    bool?          channelEmail,
    bool?          channelWhatsApp,
    String?        locationKey,
    bool           clearLocationKey = false,
    String?        customLocationName,
    bool           clearCustomLocationName = false,
    bool?          isSaving,
    String?        saveError,
    bool           clearSaveError = false,
  }) {
    return ScheduleFormState(
      taskNameOverride:          clearTaskNameOverride  ? null : (taskNameOverride  ?? this.taskNameOverride),
      customTitle:               clearCustomTitle       ? null : (customTitle       ?? this.customTitle),
      repeatOption:              repeatOption           ?? this.repeatOption,
      scheduledTimes:            scheduledTimes         ?? this.scheduledTimes,
      scheduledWeekdays:         scheduledWeekdays      ?? this.scheduledWeekdays,
      scheduledYearlyDate:       clearYearlyDate        ? null : (scheduledYearlyDate ?? this.scheduledYearlyDate),
      scheduledYearlyDates:      scheduledYearlyDates   ?? this.scheduledYearlyDates,
      monthlyMode:               monthlyMode            ?? this.monthlyMode,
      monthlySpecificDate:       monthlySpecificDate    ?? this.monthlySpecificDate,
      monthlyShortMonthFallback: monthlyShortMonthFallback ?? this.monthlyShortMonthFallback,
      reminderMinutes:           reminderMinutes        ?? this.reminderMinutes,
      channelApp:                channelApp             ?? this.channelApp,
      channelAlarm:              channelAlarm           ?? this.channelAlarm,
      channelEmail:              channelEmail           ?? this.channelEmail,
      channelWhatsApp:           channelWhatsApp        ?? this.channelWhatsApp,
      locationKey:               clearLocationKey       ? null : (locationKey       ?? this.locationKey),
      customLocationName:        clearCustomLocationName ? null : (customLocationName ?? this.customLocationName),
      isSaving:                  isSaving               ?? this.isSaving,
      saveError:                 clearSaveError         ? null : (saveError         ?? this.saveError),
    );
  }

  static ScheduleFormState fromTaskConfig(TaskConfig config) {
    return ScheduleFormState(
      repeatOption:              config.defaultRepeat ?? RepeatOption.never,
      scheduledTimes:            config.multipleTimesPerDay?.defaultTimes ?? [config.defaultTime ?? '09:00'],
      scheduledWeekdays:         _defaultWeekdays(config.defaultDays),
      scheduledYearlyDates:      const [],
      monthlyMode:               'specific_date',
      monthlySpecificDate:       1,
      monthlyShortMonthFallback: 'use_last_day',
      reminderMinutes:           config.reminderOptions?.defaultSelectedMinutes ?? [30],
      channelApp:                config.notificationChannels?.app      ?? true,
      channelAlarm:              config.notificationChannels?.alarm    ?? false,
      channelEmail:              config.notificationChannels?.email    ?? false,
      channelWhatsApp:           config.notificationChannels?.whatsapp ?? false,
      isSaving:                  false,
    );
  }

  static ScheduleFormState fromSavedTask(SavedTask task) {
    return ScheduleFormState(
      taskNameOverride:          task.taskNameOverride,
      customTitle:               task.customTitle,
      repeatOption:              RepeatOption.fromString(task.repeatOption),
      scheduledTimes:            List.from(task.scheduledTimes),
      scheduledWeekdays:         List.from(task.scheduledWeekdays),
      scheduledYearlyDate:       task.yearlyDate,
      scheduledYearlyDates:      task.scheduledYearlyDatesMs
          .map((ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true))
          .toList(),
      monthlyMode:               task.monthlyMode ?? 'specific_date',
      monthlySpecificDate:       task.monthlySpecificDate ?? 1,
      monthlyShortMonthFallback: task.monthlyShortMonthFallback ?? 'use_last_day',
      reminderMinutes:           List.from(task.reminderMinutes),
      channelApp:                task.channelApp,
      channelAlarm:              task.channelAlarm,
      channelEmail:              task.channelEmail,
      channelWhatsApp:           task.channelWhatsApp,
      locationKey:               task.locationKey,
      customLocationName:        task.customLocationName,
      isSaving:                  false,
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
    state = state.copyWith(
      repeatOption:         option,
      clearYearlyDate:      option != RepeatOption.yearly,
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
    state = state.copyWith(scheduledTimes: [...state.scheduledTimes, time]);
  }

  void removeTime(int index) {
    final times = List<String>.from(state.scheduledTimes);
    if (times.length <= 1) return;
    times.removeAt(index);
    state = state.copyWith(scheduledTimes: times);
  }

  void toggleWeekday(int weekday) {
    final days = List<int>.from(state.scheduledWeekdays);
    if (days.contains(weekday)) {
      days.remove(weekday);
    } else {
      days
        ..add(weekday)
        ..sort();
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

  void setMonthlyMode(String mode)       => state = state.copyWith(monthlyMode: mode);
  void setMonthlySpecificDate(int day)   => state = state.copyWith(monthlySpecificDate: day);
  void setMonthlyShortFallback(String f) => state = state.copyWith(monthlyShortMonthFallback: f);

  void toggleReminder(int minutes) {
    final reminders = List<int>.from(state.reminderMinutes);
    if (reminders.contains(minutes)) {
      reminders.remove(minutes);
    } else {
      reminders.add(minutes);
    }
    state = state.copyWith(reminderMinutes: reminders);
  }

  void setChannelApp(bool v)      => state = state.copyWith(channelApp: v);
  void setChannelAlarm(bool v)    => state = state.copyWith(channelAlarm: v);
  void setChannelEmail(bool v)    => state = state.copyWith(channelEmail: v);
  void setChannelWhatsApp(bool v) => state = state.copyWith(channelWhatsApp: v);

  void setLocation(String? key) {
    if (key == null) {
      state = state.copyWith(clearLocationKey: true, clearCustomLocationName: true);
    } else {
      state = state.copyWith(locationKey: key, clearCustomLocationName: true);
    }
  }

  void setCustomLocation(String name) {
    state = state.copyWith(customLocationName: name, clearLocationKey: true);
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<bool> save({
    required String categoryId,
    required String homeTimezone,
    SavedTask?      existingTask,
  }) async {
    state = state.copyWith(isSaving: true, clearSaveError: true);

    final task    = _buildSavedTask(categoryId: categoryId, homeTimezone: homeTimezone, existingTask: existingTask);
    final command = existingTask != null ? EditTaskCommand(task) : CreateTaskCommand(task);
    final result  = await ref.read(commandDispatcherProvider).dispatch(command);

    if (result.isSuccess) {
      state = state.copyWith(isSaving: false);
      return true;
    } else {
      state = state.copyWith(isSaving: false, saveError: result.error.toString());
      return false;
    }
  }

  // ── Validation ────────────────────────────────────────────────────────────

  bool get isValid {
    if (state.scheduledTimes.isEmpty) return false;
    if ((state.repeatOption == RepeatOption.weekly || state.repeatOption == RepeatOption.biweekly) &&
        state.scheduledWeekdays.isEmpty) return false;
    if (state.repeatOption == RepeatOption.yearly && state.scheduledYearlyDates.isEmpty) return false;
    return true;
  }

  // ── Build SavedTask from form state ───────────────────────────────────────

  SavedTask _buildSavedTask({
    required String categoryId,
    required String homeTimezone,
    SavedTask?      existingTask,
  }) {
    final now     = DateTime.now();
    final groupId = existingTask?.groupId ?? (taskConfig.linkedTask != null ? const Uuid().v4() : null);

    return SavedTask(
      id:                        existingTask?.id,
      taskConfigId:              taskConfig.id,
      categoryId:                categoryId,
      source:                    existingTask?.source ?? taskConfig.source,
      taskNameKey:               taskConfig.nameKey,
      taskNameOverride:          state.taskNameOverride,
      customTitle:               state.customTitle,
      repeatOption:              state.repeatOption.name,
      scheduledTimes:            List.from(state.scheduledTimes),
      scheduledWeekdays:         List.from(state.scheduledWeekdays),
      scheduledYearlyDateMs:     state.scheduledYearlyDate?.millisecondsSinceEpoch,
      scheduledYearlyDatesMs:    state.scheduledYearlyDates.map((d) => d.millisecondsSinceEpoch).toList(),
      monthlyMode:               state.monthlyMode,
      monthlySpecificDate:       state.monthlySpecificDate,
      monthlyShortMonthFallback: state.monthlyShortMonthFallback,
      reminderMinutes:           List.from(state.reminderMinutes),
      channelApp:                state.channelApp,
      channelAlarm:              state.channelAlarm,
      channelEmail:              state.channelEmail,
      channelWhatsApp:           state.channelWhatsApp,
      locationKey:               state.locationKey,
      customLocationName:        state.customLocationName,
      linkedTaskConfigId:        taskConfig.linkedTask?.linkedTaskId,
      groupId:                   groupId,
      pointsPerCompletion:       1,
      homeTimezone:              homeTimezone,
      systemTimezoneAtCreation:  homeTimezone,
      createdAt:                 existingTask?.createdAt ?? now,
      updatedAt:                 now,
      isArchived:                false,
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
