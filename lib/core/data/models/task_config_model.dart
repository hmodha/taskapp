/// Parsed model for a category from category-registry.json +
/// the individual category JSON file.
class CategoryConfig {
  final String id;
  final String labelKey;
  final String? descriptionKey;
  final String icon;
  final String? colorHex;
  final int sortOrder;
  final bool enabled;
  final bool defaultHidden;
  final String? unlockCondition;
  final List<TaskConfig> tasks;

  const CategoryConfig({
    required this.id,
    required this.labelKey,
    this.descriptionKey,
    required this.icon,
    this.colorHex,
    required this.sortOrder,
    required this.enabled,
    required this.defaultHidden,
    this.unlockCondition,
    required this.tasks,
  });

  factory CategoryConfig.fromJson(Map<String, dynamic> json) {
    return CategoryConfig(
      id:             json['id'] as String,
      labelKey:       json['label_key'] as String,
      descriptionKey: json['description_key'] as String?,
      icon:           json['icon'] as String? ?? 'task_alt',
      colorHex:       json['color_hex'] as String?,
      sortOrder:      json['sort_order'] as int? ?? 99,
      enabled:        json['enabled'] as bool? ?? true,
      defaultHidden:  json['default_hidden'] as bool? ?? false,
      unlockCondition: json['unlock_condition'] as String?,
      tasks: (json['tasks'] as List<dynamic>? ?? [])
          .map((t) => TaskConfig.fromJson(t as Map<String, dynamic>))
          .where((t) => t.enabled)
          .toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)),
    );
  }
}

/// Parsed model for a task within a category config file.
class TaskConfig {
  final String id;
  final String nameKey;
  final String? shortNameKey;
  final String? descriptionKey;
  final String? icon;
  final bool enabled;
  final int sortOrder;
  final String source;

  // Location
  final LocationConfig? locations;

  // Repeat
  final List<String> allowedRepeats;
  final String? defaultRepeat;
  final String? defaultTime;
  final List<String> defaultDays;

  // Yearly override
  final YearlyConfig? yearlyConfig;

  // Multi-time
  final MultiTimeConfig? multipleTimesPerDay;

  // Reminders
  final ReminderConfig? reminderOptions;

  // Notification
  final TaskNotificationConfig? notification;

  // Alarm
  final bool alarmEnabledByDefault;

  // Points
  final int pointsPerCompletion;

  // API source
  final ApiSourceConfig? apiSource;

  const TaskConfig({
    required this.id,
    required this.nameKey,
    this.shortNameKey,
    this.descriptionKey,
    this.icon,
    required this.enabled,
    required this.sortOrder,
    required this.source,
    this.locations,
    required this.allowedRepeats,
    this.defaultRepeat,
    this.defaultTime,
    required this.defaultDays,
    this.yearlyConfig,
    this.multipleTimesPerDay,
    this.reminderOptions,
    this.notification,
    required this.alarmEnabledByDefault,
    required this.pointsPerCompletion,
    this.apiSource,
  });

  factory TaskConfig.fromJson(Map<String, dynamic> json) {
    final locJson = json['locations'] as Map<String, dynamic>?;
    final yearlyJson = json['yearly_config'] as Map<String, dynamic>?;
    final multiJson = json['multiple_times_per_day'] as Map<String, dynamic>?;
    final reminderJson = json['reminder_options'] as Map<String, dynamic>?;
    final notifJson = json['notification'] as Map<String, dynamic>?;
    final alarmJson = json['alarm'] as Map<String, dynamic>?;
    final pointsJson = json['points'] as Map<String, dynamic>?;
    final apiJson = json['api_source'] as Map<String, dynamic>?;

    return TaskConfig(
      id:             json['id'] as String,
      nameKey:        json['name_key'] as String,
      shortNameKey:   json['short_name_key'] as String?,
      descriptionKey: json['description_key'] as String?,
      icon:           json['icon'] as String?,
      enabled:        json['enabled'] as bool? ?? true,
      sortOrder:      json['sort_order'] as int? ?? 99,
      source:         json['source'] as String? ?? 'manual',
      locations:      locJson != null ? LocationConfig.fromJson(locJson) : null,
      allowedRepeats: (json['allowed_repeats'] as Map<String, dynamic>?)?['options']
              ?.cast<String>() ??
          ['never', 'daily', 'weekly', 'biweekly', 'monthly', 'quarterly', 'yearly'],
      defaultRepeat:  json['default_repeat'] as String?,
      defaultTime:    json['default_time'] as String?,
      defaultDays:    (json['default_days'] as List<dynamic>?)?.cast<String>() ?? [],
      yearlyConfig:   yearlyJson != null ? YearlyConfig.fromJson(yearlyJson) : null,
      multipleTimesPerDay: multiJson != null ? MultiTimeConfig.fromJson(multiJson) : null,
      reminderOptions: reminderJson != null ? ReminderConfig.fromJson(reminderJson) : null,
      notification:   notifJson != null ? TaskNotificationConfig.fromJson(notifJson) : null,
      alarmEnabledByDefault: (alarmJson?['enabled_by_default'] as bool?) ?? false,
      pointsPerCompletion: (pointsJson?['per_completion'] as int?) ?? 1,
      apiSource: apiJson != null ? ApiSourceConfig.fromJson(apiJson) : null,
    );
  }
}

class LocationConfig {
  final bool enabled;
  final String optionsSource;
  final List<String>? overrideKeys; // null = use full central list
  final bool multiSelect;
  final bool required;
  final String noLocationLabelKey;

  const LocationConfig({
    required this.enabled,
    required this.optionsSource,
    this.overrideKeys,
    required this.multiSelect,
    required this.required,
    required this.noLocationLabelKey,
  });

  factory LocationConfig.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty || json['enabled'] == false) {
      return const LocationConfig(
        enabled: false,
        optionsSource: '',
        multiSelect: false,
        required: false,
        noLocationLabelKey: 'location.whole_home',
      );
    }
    return LocationConfig(
      enabled:       json['enabled'] as bool? ?? true,
      optionsSource: json['options_source'] as String? ?? '',
      overrideKeys:  (json['override_keys'] as List<dynamic>?)?.cast<String>(),
      multiSelect:   json['multi_select'] as bool? ?? false,
      required:      json['required'] as bool? ?? false,
      noLocationLabelKey: json['no_location_label_key'] as String? ?? 'location.whole_home',
    );
  }
}

class YearlyConfig {
  final int maxDateSelections;
  final bool singleDatePicker;
  final bool showTimePicker;

  const YearlyConfig({
    required this.maxDateSelections,
    required this.singleDatePicker,
    required this.showTimePicker,
  });

  factory YearlyConfig.fromJson(Map<String, dynamic> json) => YearlyConfig(
    maxDateSelections: json['max_date_selections'] as int? ?? 2,
    singleDatePicker:  json['single_date_picker'] as bool? ?? false,
    showTimePicker:    json['show_time_picker'] as bool? ?? true,
  );
}

class MultiTimeConfig {
  final bool enabled;
  final int maxTimes;
  final int minTimes;
  final List<String> defaultTimes;
  final String? addTimeLabelKey;
  final String? timeLabelKey;

  const MultiTimeConfig({
    required this.enabled,
    required this.maxTimes,
    required this.minTimes,
    required this.defaultTimes,
    this.addTimeLabelKey,
    this.timeLabelKey,
  });

  factory MultiTimeConfig.fromJson(Map<String, dynamic> json) => MultiTimeConfig(
    enabled:         json['enabled'] as bool? ?? false,
    maxTimes:        json['max_times'] as int? ?? 3,
    minTimes:        json['min_times'] as int? ?? 1,
    defaultTimes:    (json['default_times'] as List<dynamic>?)?.cast<String>() ?? ['09:00'],
    addTimeLabelKey: json['add_time_label_key'] as String?,
    timeLabelKey:    json['time_label_key'] as String?,
  );
}

class ReminderConfig {
  final List<int> optionsMinutes;
  final List<int> defaultSelectedMinutes;

  const ReminderConfig({
    required this.optionsMinutes,
    required this.defaultSelectedMinutes,
  });

  factory ReminderConfig.fromJson(Map<String, dynamic> json) => ReminderConfig(
    optionsMinutes: (json['options_minutes'] as List<dynamic>?)?.cast<int>() ?? [30],
    defaultSelectedMinutes:
        (json['default_selected_minutes'] as List<dynamic>?)?.cast<int>() ?? [30],
  );
}

class TaskNotificationConfig {
  final String? customMessageKey;
  final bool notifyViaApp;
  final bool notifyViaAlarm;
  final bool notifyViaEmail;
  final bool notifyViaWhatsapp;

  const TaskNotificationConfig({
    this.customMessageKey,
    required this.notifyViaApp,
    required this.notifyViaAlarm,
    required this.notifyViaEmail,
    required this.notifyViaWhatsapp,
  });

  factory TaskNotificationConfig.fromJson(Map<String, dynamic> json) {
    final channels = json['channels'] as Map<String, dynamic>? ?? {};
    return TaskNotificationConfig(
      customMessageKey: json['custom_message_key'] as String?,
      notifyViaApp:       channels['app'] as bool? ?? true,
      notifyViaAlarm:     channels['alarm'] as bool? ?? false,
      notifyViaEmail:     channels['email'] as bool? ?? false,
      notifyViaWhatsapp:  channels['whatsapp'] as bool? ?? false,
    );
  }
}

class ApiSourceConfig {
  final String? apiType;
  final bool prepopulateScheduleScreen;
  final bool userCanModify;
  final Map<String, dynamic> prepopulatedFields;

  const ApiSourceConfig({
    this.apiType,
    required this.prepopulateScheduleScreen,
    required this.userCanModify,
    required this.prepopulatedFields,
  });

  factory ApiSourceConfig.fromJson(Map<String, dynamic> json) => ApiSourceConfig(
    apiType:                   json['api_type'] as String?,
    prepopulateScheduleScreen: json['prepopulate_schedule_screen'] as bool? ?? false,
    userCanModify:             json['user_can_modify'] as bool? ?? true,
    prepopulatedFields:
        json['prepopulated_fields'] as Map<String, dynamic>? ?? {},
  );
}

/// Registry entry from category-registry.json
class CategoryRegistryEntry {
  final String categoryId;
  final String file;
  final String labelKey;
  final String icon;
  final String? colorHex;
  final int sortOrder;
  final bool enabled;

  const CategoryRegistryEntry({
    required this.categoryId,
    required this.file,
    required this.labelKey,
    required this.icon,
    this.colorHex,
    required this.sortOrder,
    required this.enabled,
  });

  factory CategoryRegistryEntry.fromJson(Map<String, dynamic> json) =>
      CategoryRegistryEntry(
        categoryId: json['category_id'] as String,
        file:       json['file'] as String,
        labelKey:   json['label_key'] as String,
        icon:       json['icon'] as String? ?? 'task_alt',
        colorHex:   json['color_hex'] as String?,
        sortOrder:  json['sort_order'] as int? ?? 99,
        enabled:    json['enabled'] as bool? ?? true,
      );
}
