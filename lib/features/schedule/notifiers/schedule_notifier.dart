import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/commands/command.dart';
import '../../../core/commands/commands/task_commands.dart';
import '../../../core/config/config_loader.dart';
import '../../../core/data/repositories/preferences_repository.dart';
import '../../../core/data/repositories/task_repository.dart';
import '../models/schedule_form_state.dart';
import '../models/task_config_model.dart';

/// Manages all state for the schedule screen form.
///
/// Initialised with task config defaults when created.
/// All mutations go through named methods — never mutate state directly.
class ScheduleFormNotifier extends StateNotifier<ScheduleFormState> {
  final ScheduleFormArgs _args;
  final TaskRepository _taskRepo;
  final PreferencesRepository _prefsRepo;
  final CommandDispatcher _dispatcher;
  final ConfigLoader _configLoader;

  TaskConfig? _taskConfig;

  ScheduleFormNotifier({
    required ScheduleFormArgs args,
    required TaskRepository taskRepo,
    required PreferencesRepository prefsRepo,
    required CommandDispatcher dispatcher,
    required ConfigLoader configLoader,
  })  : _args = args,
        _taskRepo = taskRepo,
        _prefsRepo = prefsRepo,
        _dispatcher = dispatcher,
        _configLoader = configLoader,
        super(ScheduleFormState(
          categoryId:   args.categoryId,
          taskConfigId: args.taskConfigId,
          taskName:     '',
        )) {
    _init();
  }

  // ── Initialisation ─────────────────────────────────────────────────────────

  Future<void> _init() async {
    if (_args.existingTaskId != null) {
      await _loadExistingTask(_args.existingTaskId!);
    } else {
      await _loadTaskConfigDefaults();
    }
  }

  /// For edit mode — pre-fill form from saved Isar task.
  Future<void> _loadExistingTask(int taskId) async {
    final task = await _taskRepo.getById(taskId);
    if (task == null) return;

    state = state.copyWith(
      taskName:        task.taskName,
      customTitle:     task.customTitle,
      repeatFrequency: RepeatFrequency.values
          .firstWhere((r) => r.configKey == task.repeatFrequency,
              orElse: () => RepeatFrequency.weekly),
      scheduledTimes:  List.from(task.scheduledTimes),
      selectedDays:    List.from(task.scheduledDays),
      selectedDates:   List.from(task.scheduledDates),
      monthlyOption:   MonthlyOption.values
          .firstWhere((m) => m.name == task.monthlyOption,
              orElse: () => MonthlyOption.specificDate),
      shortMonthFallback: ShortMonthFallback.values
          .firstWhere((s) => s.name == task.shortMonthFallback,
              orElse: () => ShortMonthFallback.useLastDay),
      locationKey:     task.locationKey,
      reminderMinutes: List.from(task.reminderMinutes),
      notifyViaApp:    task.notifyViaApp,
      notifyViaAlarm:  task.notifyViaAlarm,
      notifyViaEmail:  task.notifyViaEmail,
      notifyViaWhatsapp: task.notifyViaWhatsapp,
    );
  }

  /// For create mode — apply task config defaults.
  Future<void> _loadTaskConfigDefaults() async {
    try {
      final json = await _configLoader.loadCategory(_args.categoryId);
      final category = CategoryConfig.fromJson(json);
      _taskConfig = category.tasks
          .firstWhere((t) => t.id == _args.taskConfigId);

      final tc = _taskConfig!;
      final prefs = await _prefsRepo.get();

      // Resolve default repeat
      final defaultRepeat = tc.defaultRepeat != null
          ? RepeatFrequency.values
              .firstWhere((r) => r.configKey == tc.defaultRepeat,
                  orElse: () => RepeatFrequency.weekly)
          : RepeatFrequency.weekly;

      // Resolve default times
      final defaultTimes = tc.multipleTimesPerDay?.defaultTimes ??
          [tc.defaultTime ?? prefs.jobStartTime];

      // Resolve default reminders
      // Order: user preferred → task config → global default [30]
      final defaultReminders = prefs.preferredReminderMinutes.isNotEmpty
          ? prefs.preferredReminderMinutes
          : (tc.reminderOptions?.defaultSelectedMinutes ?? [30]);

      // Resolve default notification channels
      // Order: task config → user prefs → global defaults
      final notifConfig = tc.notification;

      state = state.copyWith(
        taskName:        tc.nameKey, // resolved to string by UI via l10n
        repeatFrequency: defaultRepeat,
        scheduledTimes:  defaultTimes,
        selectedDays:    tc.defaultDays.isNotEmpty ? tc.defaultDays : ['monday'],
        reminderMinutes: defaultReminders,
        notifyViaApp:    notifConfig?.notifyViaApp    ?? prefs.defaultNotifyViaApp,
        notifyViaAlarm:  notifConfig?.notifyViaAlarm  ?? (tc.alarmEnabledByDefault),
        notifyViaEmail:  notifConfig?.notifyViaEmail  ?? prefs.defaultNotifyViaEmail,
        notifyViaWhatsapp: notifConfig?.notifyViaWhatsapp ?? prefs.defaultNotifyViaWhatsapp,
      );
    } catch (_) {
      // Custom task — no config file. State stays with bare defaults.
    }
  }

  // ── Repeat ────────────────────────────────────────────────────────────────

  void setRepeatFrequency(RepeatFrequency freq) {
    state = state.copyWith(repeatFrequency: freq, saveError: null);
  }

  // ── Times ─────────────────────────────────────────────────────────────────

  void setTime(int index, String time) {
    final times = List<String>.from(state.scheduledTimes);
    if (index < times.length) {
      times[index] = time;
      state = state.copyWith(scheduledTimes: times);
    }
  }

  void addTime(String time) {
    final maxTimes = _taskConfig?.multipleTimesPerDay?.maxTimes ?? 6;
    if (state.scheduledTimes.length >= maxTimes) return;
    state = state.copyWith(
      scheduledTimes: [...state.scheduledTimes, time],
    );
  }

  void removeTime(int index) {
    final minTimes = _taskConfig?.multipleTimesPerDay?.minTimes ?? 1;
    if (state.scheduledTimes.length <= minTimes) return;
    final times = List<String>.from(state.scheduledTimes)..removeAt(index);
    state = state.copyWith(scheduledTimes: times);
  }

  // ── Days ──────────────────────────────────────────────────────────────────

  void toggleDay(String day) {
    final days = List<String>.from(state.selectedDays);
    if (days.contains(day)) {
      if (days.length > 1) days.remove(day); // must have at least 1 day
    } else {
      days.add(day);
    }
    state = state.copyWith(selectedDays: days);
  }

  void setSameTimeAllDays(bool value) =>
      state = state.copyWith(sameTimeAllDays: value);

  // ── Monthly ───────────────────────────────────────────────────────────────

  void setMonthlyOption(MonthlyOption option) =>
      state = state.copyWith(monthlyOption: option);

  void setShortMonthFallback(ShortMonthFallback fallback) =>
      state = state.copyWith(shortMonthFallback: fallback);

  // ── Yearly ────────────────────────────────────────────────────────────────

  void setSelectedDate(String date) {
    final maxSelections = _taskConfig?.yearlyConfig?.maxDateSelections ?? 2;
    final dates = List<String>.from(state.selectedDates);

    if (dates.contains(date)) {
      dates.remove(date);
    } else if (dates.length < maxSelections) {
      dates.add(date);
    }
    state = state.copyWith(selectedDates: dates);
  }

  // ── Location ──────────────────────────────────────────────────────────────

  void setLocation(String? locationKey) =>
      state = state.copyWith(locationKey: locationKey);

  // ── Reminders ─────────────────────────────────────────────────────────────

  void toggleReminder(int minutes) {
    final reminders = List<int>.from(state.reminderMinutes);
    const maxReminders = 3; // from schedule-global-config
    if (reminders.contains(minutes)) {
      reminders.remove(minutes);
    } else if (reminders.length < maxReminders) {
      reminders.add(minutes);
    }
    state = state.copyWith(reminderMinutes: reminders);
  }

  // ── Channels ──────────────────────────────────────────────────────────────

  void setNotifyViaApp(bool value)      => state = state.copyWith(notifyViaApp: value);
  void setNotifyViaAlarm(bool value)    => state = state.copyWith(notifyViaAlarm: value);
  void setNotifyViaEmail(bool value)    => state = state.copyWith(notifyViaEmail: value);
  void setNotifyViaWhatsapp(bool value) => state = state.copyWith(notifyViaWhatsapp: value);

  // ── Custom title ──────────────────────────────────────────────────────────

  void setCustomTitle(String? title) =>
      state = state.copyWith(customTitle: title);

  // ── Sleep window check ────────────────────────────────────────────────────

  Future<void> checkSleepWindow() async {
    final prefs = await _prefsRepo.get();
    final sleepTime = prefs.sleepTime; // HH:mm
    final wakeTime  = prefs.wakeUpTime;

    bool inWindow = false;
    for (final time in state.scheduledTimes) {
      if (_isTimeBetween(time, sleepTime, wakeTime)) {
        inWindow = true;
        break;
      }
    }
    state = state.copyWith(isWithinSleepWindow: inWindow);
  }

  bool _isTimeBetween(String time, String start, String end) {
    final t = _parseMinutes(time);
    final s = _parseMinutes(start);
    final e = _parseMinutes(end);
    if (s > e) {
      // Overnight window e.g. 22:30 → 07:00
      return t >= s || t <= e;
    }
    return t >= s && t <= e;
  }

  int _parseMinutes(String hhmm) {
    final parts = hhmm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> save() async {
    if (state.isSaving) return;
    state = state.copyWith(isSaving: true, saveError: null, saveSuccess: false);

    final task = state.toSavedTask(existingTaskId: _args.existingTaskId);
    final Command command;

    if (_args.existingTaskId != null) {
      command = EditTaskCommand(
        taskRepo: _taskRepo,
        updatedTask: task,
      );
    } else {
      command = CreateTaskCommand(
        taskRepo: _taskRepo,
        prefsRepo: _prefsRepo,
        task: task,
      );
    }

    final result = await _dispatcher.dispatch(command);

    if (result is CommandSuccess) {
      state = state.copyWith(isSaving: false, saveSuccess: true);
    } else if (result is CommandFailure) {
      state = state.copyWith(
        isSaving: false,
        saveError: result.message,
      );
    }
  }

  void resetSaveState() =>
      state = state.copyWith(saveSuccess: false, saveError: null);

  // ── Getters ───────────────────────────────────────────────────────────────

  TaskConfig? get taskConfig => _taskConfig;

  bool get canAddMoreTimes {
    final max = _taskConfig?.multipleTimesPerDay?.maxTimes ?? 1;
    return state.scheduledTimes.length < max;
  }

  bool get multipleTimesEnabled =>
      _taskConfig?.multipleTimesPerDay?.enabled ?? false;

  int get yearlyMaxDateSelections =>
      _taskConfig?.yearlyConfig?.maxDateSelections ?? 2;

  bool get isYearlySingleDateOnly =>
      _taskConfig?.yearlyConfig?.singleDatePicker ?? false;
}

// Import needed by toSavedTask
import '../../../core/data/models/saved_task.dart';
