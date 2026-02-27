import 'package:flutter/foundation.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Config registry entry
// ─────────────────────────────────────────────────────────────────────────────

class CategoryRegistryEntry {
  final String categoryId;
  final String file;
  final String labelKey;
  final String icon;
  final String? colorHex;
  final int sortOrder;
  final bool enabled;
  final bool defaultHidden;
  final String? unlockCondition;

  const CategoryRegistryEntry({
    required this.categoryId,
    required this.file,
    required this.labelKey,
    required this.icon,
    this.colorHex,
    required this.sortOrder,
    required this.enabled,
    required this.defaultHidden,
    this.unlockCondition,
  });

  factory CategoryRegistryEntry.fromJson(Map<String, dynamic> json) {
    return CategoryRegistryEntry(
      categoryId:      json['category_id'] as String,
      file:            json['file'] as String,
      labelKey:        json['label_key'] as String,
      icon:            json['icon'] as String,
      colorHex:        json['color_hex'] as String?,
      sortOrder:       json['sort_order'] as int,
      enabled:         json['enabled'] as bool? ?? true,
      defaultHidden:   json['default_hidden'] as bool? ?? false,
      unlockCondition: json['unlock_condition'] as String?,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Repeat options
// ─────────────────────────────────────────────────────────────────────────────

enum RepeatOption {
  never,
  daily,
  weekly,
  biweekly,
  monthly,
  quarterly,
  yearly;

  static RepeatOption fromString(String value) {
    return RepeatOption.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RepeatOption.never,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Location config
// ─────────────────────────────────────────────────────────────────────────────

class LocationConfig {
  final bool enabled;
  final String optionsSource;
  final List<String>? overrideKeys;   // null = use full central list
  final bool multiSelect;
  final bool required;
  final String? noLocationLabelKey;

  const LocationConfig({
    required this.enabled,
    required this.optionsSource,
    this.overrideKeys,
    required this.multiSelect,
    required this.required,
    this.noLocationLabelKey,
  });

  factory LocationConfig.fromJson(Map<String, dynamic> json) {
    return LocationConfig(
      enabled:           json['enabled'] as bool? ?? true,
      optionsSource:     json['options_source'] as String? ?? 'ui-global-config.location.default_locations_keys',
      overrideKeys:      (json['override_keys'] as List?)?.cast<String>(),
      multiSelect:       json['multi_select'] as bool? ?? false,
      required:          json['required'] as bool? ?? false,
      noLocationLabelKey: json['no_location_label_key'] as String?,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Multiple times config
// ─────────────────────────────────────────────────────────────────────────────

class MultipleTimesConfig {
  final bool enabled;
  final int maxTimes;
  final int minTimes;
  final List<String> defaultTimes;
  final String? addTimeLabelKey;
  final String? removeTimeLabelKey;
  final String? timeLabelKey;

  const MultipleTimesConfig({
    required this.enabled,
    required this.maxTimes,
    required this.minTimes,
    required this.defaultTimes,
    this.addTimeLabelKey,
    this.removeTimeLabelKey,
    this.timeLabelKey,
  });

  factory MultipleTimesConfig.fromJson(Map<String, dynamic> json) {
    return MultipleTimesConfig(
      enabled:            json['enabled'] as bool? ?? true,
      maxTimes:           json['max_times'] as int? ?? 6,
      minTimes:           json['min_times'] as int? ?? 1,
      defaultTimes:       (json['default_times'] as List?)?.cast<String>() ?? ['08:00'],
      addTimeLabelKey:    json['add_time_label_key'] as String?,
      removeTimeLabelKey: json['remove_time_label_key'] as String?,
      timeLabelKey:       json['time_label_key'] as String?,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Yearly config
// ─────────────────────────────────────────────────────────────────────────────

class YearlyConfig {
  final int maxDateSelections;
  final bool singleDatePicker;
  final bool showTimePicker;

  const YearlyConfig({
    required this.maxDateSelections,
    required this.singleDatePicker,
    required this.showTimePicker,
  });

  factory YearlyConfig.fromJson(Map<String, dynamic> json) {
    return YearlyConfig(
      maxDateSelections: json['max_date_selections'] as int? ?? 2,
      singleDatePicker:  json['single_date_picker'] as bool? ?? false,
      showTimePicker:    json['show_time_picker'] as bool? ?? true,
    );
  }

  /// Default for tasks that don't specify yearly_config
  static const YearlyConfig defaults = YearlyConfig(
    maxDateSelections: 2,
    singleDatePicker:  false,
    showTimePicker:    true,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Reminder config
// ─────────────────────────────────────────────────────────────────────────────

class ReminderConfig {
  final List<int> optionsMinutes;
  final List<int> defaultSelectedMinutes;
  final Map<String, String> labelsKeys;

  const ReminderConfig({
    required this.optionsMinutes,
    required this.defaultSelectedMinutes,
    required this.labelsKeys,
  });

  factory ReminderConfig.fromJson(Map<String, dynamic> json) {
    return ReminderConfig(
      optionsMinutes:        (json['options_minutes'] as List?)?.cast<int>() ?? [10, 30, 60],
      defaultSelectedMinutes:(json['default_selected_minutes'] as List?)?.cast<int>() ?? [30],
      labelsKeys:            (json['labels_keys'] as Map?)?.cast<String, String>() ?? {},
    );
  }

  static const ReminderConfig defaults = ReminderConfig(
    optionsMinutes:         [10, 30, 60],
    defaultSelectedMinutes: [30],
    labelsKeys:             {},
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Notification channel config
// ─────────────────────────────────────────────────────────────────────────────

class NotificationChannelsConfig {
  final bool app;
  final bool alarm;
  final bool email;
  final bool whatsapp;

  const NotificationChannelsConfig({
    required this.app,
    required this.alarm,
    required this.email,
    required this.whatsapp,
  });

  factory NotificationChannelsConfig.fromJson(Map<String, dynamic> json) {
    return NotificationChannelsConfig(
      app:      json['app'] as bool? ?? true,
      alarm:    json['alarm'] as bool? ?? false,
      email:    json['email'] as bool? ?? false,
      whatsapp: json['whatsapp'] as bool? ?? false,
    );
  }

  static const NotificationChannelsConfig defaults = NotificationChannelsConfig(
    app: true, alarm: false, email: false, whatsapp: false,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Linked task config
// ─────────────────────────────────────────────────────────────────────────────

class LinkedTaskConfig {
  final String linkedTaskId;
  final String linkType;
  final bool autoCreatePaired;
  final int? pairedTaskTimeOffsetHours;

  const LinkedTaskConfig({
    required this.linkedTaskId,
    required this.linkType,
    required this.autoCreatePaired,
    this.pairedTaskTimeOffsetHours,
  });

  factory LinkedTaskConfig.fromJson(Map<String, dynamic> json) {
    return LinkedTaskConfig(
      linkedTaskId:              json['linked_task_id'] as String,
      linkType:                  json['link_type'] as String? ?? 'paired',
      autoCreatePaired:          json['auto_create_paired'] as bool? ?? false,
      pairedTaskTimeOffsetHours: json['paired_task_time_offset_hours'] as int?,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Task config (single task definition from category file)
// ─────────────────────────────────────────────────────────────────────────────

class TaskConfig {
  final String id;
  final String nameKey;
  final String? shortNameKey;
  final String? descriptionKey;
  final String? icon;
  final bool enabled;
  final int sortOrder;
  final String source;

  final LocationConfig? locations;
  final List<RepeatOption> allowedRepeats;
  final YearlyConfig? yearlyConfig;
  final MultipleTimesConfig? multipleTimesPerDay;
  final RepeatOption? defaultRepeat;
  final String? defaultTime;
  final List<String>? defaultDays;
  final ReminderConfig? reminderOptions;
  final NotificationChannelsConfig? notificationChannels;
  final String? customMessageKey;
  final bool alarmEnabledByDefault;
  final LinkedTaskConfig? linkedTask;
  final List<String> tags;
  final bool encourgeCustomTitle;
  final String? customTitleHintKey;

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
    this.yearlyConfig,
    this.multipleTimesPerDay,
    this.defaultRepeat,
    this.defaultTime,
    this.defaultDays,
    this.reminderOptions,
    this.notificationChannels,
    this.customMessageKey,
    required this.alarmEnabledByDefault,
    this.linkedTask,
    required this.tags,
    required this.encourgeCustomTitle,
    this.customTitleHintKey,
  });

  factory TaskConfig.fromJson(Map<String, dynamic> json) {
    // Parse allowed repeats — default to all if not specified
    final List<RepeatOption> repeats;
    final repeatJson = json['allowed_repeats'] as Map<String, dynamic>?;
    if (repeatJson != null) {
      repeats = (repeatJson['options'] as List)
          .map((e) => RepeatOption.fromString(e as String))
          .toList();
    } else {
      repeats = RepeatOption.values.toList();
    }

    // Notification section
    final notifJson = json['notification'] as Map<String, dynamic>?;
    final channelsJson = notifJson?['channels'] as Map<String, dynamic>?;

    // Custom title section
    final customTitleJson = json['custom_title'] as Map<String, dynamic>?;

    return TaskConfig(
      id:                   json['id'] as String,
      nameKey:              json['name_key'] as String,
      shortNameKey:         json['short_name_key'] as String?,
      descriptionKey:       json['description_key'] as String?,
      icon:                 json['icon'] as String?,
      enabled:              json['enabled'] as bool? ?? true,
      sortOrder:            json['sort_order'] as int? ?? 0,
      source:               json['source'] as String? ?? 'manual',
      locations:            json['locations'] != null && json['locations'] != null
                              ? LocationConfig.fromJson(json['locations'] as Map<String, dynamic>)
                              : null,
      allowedRepeats:       repeats,
      yearlyConfig:         json['yearly_config'] != null
                              ? YearlyConfig.fromJson(json['yearly_config'] as Map<String, dynamic>)
                              : null,
      multipleTimesPerDay:  json['multiple_times_per_day'] != null
                              ? MultipleTimesConfig.fromJson(json['multiple_times_per_day'] as Map<String, dynamic>)
                              : null,
      defaultRepeat:        json['default_repeat'] != null
                              ? RepeatOption.fromString(json['default_repeat'] as String)
                              : null,
      defaultTime:          json['default_time'] as String?,
      defaultDays:          (json['default_days'] as List?)?.cast<String>(),
      reminderOptions:      json['reminder_options'] != null
                              ? ReminderConfig.fromJson(json['reminder_options'] as Map<String, dynamic>)
                              : null,
      notificationChannels: channelsJson != null
                              ? NotificationChannelsConfig.fromJson(channelsJson)
                              : null,
      customMessageKey:     notifJson?['custom_message_key'] as String?,
      alarmEnabledByDefault: (json['alarm'] as Map<String, dynamic>?)?['enabled_by_default'] as bool? ?? false,
      linkedTask:           json['linked_task'] != null
                              ? LinkedTaskConfig.fromJson(json['linked_task'] as Map<String, dynamic>)
                              : null,
      tags:                 (json['tags'] as List?)?.cast<String>() ?? [],
      encourgeCustomTitle:  customTitleJson?['encouraged'] as bool? ?? false,
      customTitleHintKey:   customTitleJson?['encouraged_hint_key'] as String?,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category config (full category file)
// ─────────────────────────────────────────────────────────────────────────────

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
  final List<String> ageGroupFilter;
  final List<String> locationFilter;
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
    required this.ageGroupFilter,
    required this.locationFilter,
    required this.tasks,
  });

  factory CategoryConfig.fromJson(Map<String, dynamic> json) {
    return CategoryConfig(
      id:              json['id'] as String,
      labelKey:        json['label_key'] as String,
      descriptionKey:  json['description_key'] as String?,
      icon:            json['icon'] as String,
      colorHex:        json['color_hex'] as String?,
      sortOrder:       json['sort_order'] as int? ?? 0,
      enabled:         json['enabled'] as bool? ?? true,
      defaultHidden:   json['default_hidden'] as bool? ?? false,
      unlockCondition: json['unlock_condition'] as String?,
      ageGroupFilter:  (json['age_group_filter'] as List?)?.cast<String>() ?? [],
      locationFilter:  (json['location_filter'] as List?)?.cast<String>() ?? [],
      tasks:           (json['tasks'] as List? ?? [])
                         .map((t) => TaskConfig.fromJson(t as Map<String, dynamic>))
                         .toList(),
    );
  }
}
