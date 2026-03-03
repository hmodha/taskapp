// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SavedTasksTableTable extends SavedTasksTable
    with TableInfo<$SavedTasksTableTable, SavedTasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedTasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _taskConfigIdMeta =
      const VerificationMeta('taskConfigId');
  @override
  late final GeneratedColumn<String> taskConfigId = GeneratedColumn<String>(
      'task_config_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskNameKeyMeta =
      const VerificationMeta('taskNameKey');
  @override
  late final GeneratedColumn<String> taskNameKey = GeneratedColumn<String>(
      'task_name_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _taskNameOverrideMeta =
      const VerificationMeta('taskNameOverride');
  @override
  late final GeneratedColumn<String> taskNameOverride = GeneratedColumn<String>(
      'task_name_override', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customTitleMeta =
      const VerificationMeta('customTitle');
  @override
  late final GeneratedColumn<String> customTitle = GeneratedColumn<String>(
      'custom_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _repeatOptionMeta =
      const VerificationMeta('repeatOption');
  @override
  late final GeneratedColumn<String> repeatOption = GeneratedColumn<String>(
      'repeat_option', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledTimesJsonMeta =
      const VerificationMeta('scheduledTimesJson');
  @override
  late final GeneratedColumn<String> scheduledTimesJson =
      GeneratedColumn<String>('scheduled_times_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledWeekdaysJsonMeta =
      const VerificationMeta('scheduledWeekdaysJson');
  @override
  late final GeneratedColumn<String> scheduledWeekdaysJson =
      GeneratedColumn<String>('scheduled_weekdays_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledYearlyDateMsMeta =
      const VerificationMeta('scheduledYearlyDateMs');
  @override
  late final GeneratedColumn<int> scheduledYearlyDateMs = GeneratedColumn<int>(
      'scheduled_yearly_date_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _scheduledYearlyDatesJsonMeta =
      const VerificationMeta('scheduledYearlyDatesJson');
  @override
  late final GeneratedColumn<String> scheduledYearlyDatesJson =
      GeneratedColumn<String>('scheduled_yearly_dates_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthlyModeMeta =
      const VerificationMeta('monthlyMode');
  @override
  late final GeneratedColumn<String> monthlyMode = GeneratedColumn<String>(
      'monthly_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _monthlySpecificDateMeta =
      const VerificationMeta('monthlySpecificDate');
  @override
  late final GeneratedColumn<int> monthlySpecificDate = GeneratedColumn<int>(
      'monthly_specific_date', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _monthlyShortMonthFallbackMeta =
      const VerificationMeta('monthlyShortMonthFallback');
  @override
  late final GeneratedColumn<String> monthlyShortMonthFallback =
      GeneratedColumn<String>('monthly_short_month_fallback', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reminderMinutesJsonMeta =
      const VerificationMeta('reminderMinutesJson');
  @override
  late final GeneratedColumn<String> reminderMinutesJson =
      GeneratedColumn<String>('reminder_minutes_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _channelAppMeta =
      const VerificationMeta('channelApp');
  @override
  late final GeneratedColumn<bool> channelApp = GeneratedColumn<bool>(
      'channel_app', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("channel_app" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _channelAlarmMeta =
      const VerificationMeta('channelAlarm');
  @override
  late final GeneratedColumn<bool> channelAlarm = GeneratedColumn<bool>(
      'channel_alarm', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("channel_alarm" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _channelEmailMeta =
      const VerificationMeta('channelEmail');
  @override
  late final GeneratedColumn<bool> channelEmail = GeneratedColumn<bool>(
      'channel_email', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("channel_email" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _channelWhatsAppMeta =
      const VerificationMeta('channelWhatsApp');
  @override
  late final GeneratedColumn<bool> channelWhatsApp = GeneratedColumn<bool>(
      'channel_whats_app', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("channel_whats_app" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _locationKeyMeta =
      const VerificationMeta('locationKey');
  @override
  late final GeneratedColumn<String> locationKey = GeneratedColumn<String>(
      'location_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customLocationNameMeta =
      const VerificationMeta('customLocationName');
  @override
  late final GeneratedColumn<String> customLocationName =
      GeneratedColumn<String>('custom_location_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedTaskConfigIdMeta =
      const VerificationMeta('linkedTaskConfigId');
  @override
  late final GeneratedColumn<String> linkedTaskConfigId =
      GeneratedColumn<String>('linked_task_config_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pointsPerCompletionMeta =
      const VerificationMeta('pointsPerCompletion');
  @override
  late final GeneratedColumn<int> pointsPerCompletion = GeneratedColumn<int>(
      'points_per_completion', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _homeTimezoneMeta =
      const VerificationMeta('homeTimezone');
  @override
  late final GeneratedColumn<String> homeTimezone = GeneratedColumn<String>(
      'home_timezone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _systemTimezoneAtCreationMeta =
      const VerificationMeta('systemTimezoneAtCreation');
  @override
  late final GeneratedColumn<String> systemTimezoneAtCreation =
      GeneratedColumn<String>('system_timezone_at_creation', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _apiResponseJsonMeta =
      const VerificationMeta('apiResponseJson');
  @override
  late final GeneratedColumn<String> apiResponseJson = GeneratedColumn<String>(
      'api_response_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskConfigId,
        categoryId,
        source,
        taskNameKey,
        taskNameOverride,
        customTitle,
        repeatOption,
        scheduledTimesJson,
        scheduledWeekdaysJson,
        scheduledYearlyDateMs,
        scheduledYearlyDatesJson,
        monthlyMode,
        monthlySpecificDate,
        monthlyShortMonthFallback,
        reminderMinutesJson,
        channelApp,
        channelAlarm,
        channelEmail,
        channelWhatsApp,
        locationKey,
        customLocationName,
        linkedTaskConfigId,
        groupId,
        pointsPerCompletion,
        homeTimezone,
        systemTimezoneAtCreation,
        createdAt,
        updatedAt,
        isArchived,
        apiResponseJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_tasks';
  @override
  VerificationContext validateIntegrity(
      Insertable<SavedTasksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_config_id')) {
      context.handle(
          _taskConfigIdMeta,
          taskConfigId.isAcceptableOrUnknown(
              data['task_config_id']!, _taskConfigIdMeta));
    } else if (isInserting) {
      context.missing(_taskConfigIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('task_name_key')) {
      context.handle(
          _taskNameKeyMeta,
          taskNameKey.isAcceptableOrUnknown(
              data['task_name_key']!, _taskNameKeyMeta));
    }
    if (data.containsKey('task_name_override')) {
      context.handle(
          _taskNameOverrideMeta,
          taskNameOverride.isAcceptableOrUnknown(
              data['task_name_override']!, _taskNameOverrideMeta));
    }
    if (data.containsKey('custom_title')) {
      context.handle(
          _customTitleMeta,
          customTitle.isAcceptableOrUnknown(
              data['custom_title']!, _customTitleMeta));
    }
    if (data.containsKey('repeat_option')) {
      context.handle(
          _repeatOptionMeta,
          repeatOption.isAcceptableOrUnknown(
              data['repeat_option']!, _repeatOptionMeta));
    } else if (isInserting) {
      context.missing(_repeatOptionMeta);
    }
    if (data.containsKey('scheduled_times_json')) {
      context.handle(
          _scheduledTimesJsonMeta,
          scheduledTimesJson.isAcceptableOrUnknown(
              data['scheduled_times_json']!, _scheduledTimesJsonMeta));
    } else if (isInserting) {
      context.missing(_scheduledTimesJsonMeta);
    }
    if (data.containsKey('scheduled_weekdays_json')) {
      context.handle(
          _scheduledWeekdaysJsonMeta,
          scheduledWeekdaysJson.isAcceptableOrUnknown(
              data['scheduled_weekdays_json']!, _scheduledWeekdaysJsonMeta));
    } else if (isInserting) {
      context.missing(_scheduledWeekdaysJsonMeta);
    }
    if (data.containsKey('scheduled_yearly_date_ms')) {
      context.handle(
          _scheduledYearlyDateMsMeta,
          scheduledYearlyDateMs.isAcceptableOrUnknown(
              data['scheduled_yearly_date_ms']!, _scheduledYearlyDateMsMeta));
    }
    if (data.containsKey('scheduled_yearly_dates_json')) {
      context.handle(
          _scheduledYearlyDatesJsonMeta,
          scheduledYearlyDatesJson.isAcceptableOrUnknown(
              data['scheduled_yearly_dates_json']!,
              _scheduledYearlyDatesJsonMeta));
    } else if (isInserting) {
      context.missing(_scheduledYearlyDatesJsonMeta);
    }
    if (data.containsKey('monthly_mode')) {
      context.handle(
          _monthlyModeMeta,
          monthlyMode.isAcceptableOrUnknown(
              data['monthly_mode']!, _monthlyModeMeta));
    }
    if (data.containsKey('monthly_specific_date')) {
      context.handle(
          _monthlySpecificDateMeta,
          monthlySpecificDate.isAcceptableOrUnknown(
              data['monthly_specific_date']!, _monthlySpecificDateMeta));
    }
    if (data.containsKey('monthly_short_month_fallback')) {
      context.handle(
          _monthlyShortMonthFallbackMeta,
          monthlyShortMonthFallback.isAcceptableOrUnknown(
              data['monthly_short_month_fallback']!,
              _monthlyShortMonthFallbackMeta));
    }
    if (data.containsKey('reminder_minutes_json')) {
      context.handle(
          _reminderMinutesJsonMeta,
          reminderMinutesJson.isAcceptableOrUnknown(
              data['reminder_minutes_json']!, _reminderMinutesJsonMeta));
    } else if (isInserting) {
      context.missing(_reminderMinutesJsonMeta);
    }
    if (data.containsKey('channel_app')) {
      context.handle(
          _channelAppMeta,
          channelApp.isAcceptableOrUnknown(
              data['channel_app']!, _channelAppMeta));
    }
    if (data.containsKey('channel_alarm')) {
      context.handle(
          _channelAlarmMeta,
          channelAlarm.isAcceptableOrUnknown(
              data['channel_alarm']!, _channelAlarmMeta));
    }
    if (data.containsKey('channel_email')) {
      context.handle(
          _channelEmailMeta,
          channelEmail.isAcceptableOrUnknown(
              data['channel_email']!, _channelEmailMeta));
    }
    if (data.containsKey('channel_whats_app')) {
      context.handle(
          _channelWhatsAppMeta,
          channelWhatsApp.isAcceptableOrUnknown(
              data['channel_whats_app']!, _channelWhatsAppMeta));
    }
    if (data.containsKey('location_key')) {
      context.handle(
          _locationKeyMeta,
          locationKey.isAcceptableOrUnknown(
              data['location_key']!, _locationKeyMeta));
    }
    if (data.containsKey('custom_location_name')) {
      context.handle(
          _customLocationNameMeta,
          customLocationName.isAcceptableOrUnknown(
              data['custom_location_name']!, _customLocationNameMeta));
    }
    if (data.containsKey('linked_task_config_id')) {
      context.handle(
          _linkedTaskConfigIdMeta,
          linkedTaskConfigId.isAcceptableOrUnknown(
              data['linked_task_config_id']!, _linkedTaskConfigIdMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    if (data.containsKey('points_per_completion')) {
      context.handle(
          _pointsPerCompletionMeta,
          pointsPerCompletion.isAcceptableOrUnknown(
              data['points_per_completion']!, _pointsPerCompletionMeta));
    }
    if (data.containsKey('home_timezone')) {
      context.handle(
          _homeTimezoneMeta,
          homeTimezone.isAcceptableOrUnknown(
              data['home_timezone']!, _homeTimezoneMeta));
    } else if (isInserting) {
      context.missing(_homeTimezoneMeta);
    }
    if (data.containsKey('system_timezone_at_creation')) {
      context.handle(
          _systemTimezoneAtCreationMeta,
          systemTimezoneAtCreation.isAcceptableOrUnknown(
              data['system_timezone_at_creation']!,
              _systemTimezoneAtCreationMeta));
    } else if (isInserting) {
      context.missing(_systemTimezoneAtCreationMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('api_response_json')) {
      context.handle(
          _apiResponseJsonMeta,
          apiResponseJson.isAcceptableOrUnknown(
              data['api_response_json']!, _apiResponseJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedTasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedTasksTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taskConfigId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_config_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      taskNameKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_name_key']),
      taskNameOverride: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}task_name_override']),
      customTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}custom_title']),
      repeatOption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repeat_option'])!,
      scheduledTimesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}scheduled_times_json'])!,
      scheduledWeekdaysJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}scheduled_weekdays_json'])!,
      scheduledYearlyDateMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}scheduled_yearly_date_ms']),
      scheduledYearlyDatesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}scheduled_yearly_dates_json'])!,
      monthlyMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}monthly_mode']),
      monthlySpecificDate: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}monthly_specific_date']),
      monthlyShortMonthFallback: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}monthly_short_month_fallback']),
      reminderMinutesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_minutes_json'])!,
      channelApp: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}channel_app'])!,
      channelAlarm: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}channel_alarm'])!,
      channelEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}channel_email'])!,
      channelWhatsApp: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}channel_whats_app'])!,
      locationKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_key']),
      customLocationName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}custom_location_name']),
      linkedTaskConfigId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_task_config_id']),
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id']),
      pointsPerCompletion: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}points_per_completion'])!,
      homeTimezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}home_timezone'])!,
      systemTimezoneAtCreation: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}system_timezone_at_creation'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      apiResponseJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}api_response_json']),
    );
  }

  @override
  $SavedTasksTableTable createAlias(String alias) {
    return $SavedTasksTableTable(attachedDatabase, alias);
  }
}

class SavedTasksTableData extends DataClass
    implements Insertable<SavedTasksTableData> {
  final int id;
  final String taskConfigId;
  final String categoryId;
  final String source;
  final String? taskNameKey;
  final String? taskNameOverride;
  final String? customTitle;
  final String repeatOption;
  final String scheduledTimesJson;
  final String scheduledWeekdaysJson;
  final int? scheduledYearlyDateMs;
  final String scheduledYearlyDatesJson;
  final String? monthlyMode;
  final int? monthlySpecificDate;
  final String? monthlyShortMonthFallback;
  final String reminderMinutesJson;
  final bool channelApp;
  final bool channelAlarm;
  final bool channelEmail;
  final bool channelWhatsApp;
  final String? locationKey;
  final String? customLocationName;
  final String? linkedTaskConfigId;
  final String? groupId;
  final int pointsPerCompletion;
  final String homeTimezone;
  final String systemTimezoneAtCreation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  final String? apiResponseJson;
  const SavedTasksTableData(
      {required this.id,
      required this.taskConfigId,
      required this.categoryId,
      required this.source,
      this.taskNameKey,
      this.taskNameOverride,
      this.customTitle,
      required this.repeatOption,
      required this.scheduledTimesJson,
      required this.scheduledWeekdaysJson,
      this.scheduledYearlyDateMs,
      required this.scheduledYearlyDatesJson,
      this.monthlyMode,
      this.monthlySpecificDate,
      this.monthlyShortMonthFallback,
      required this.reminderMinutesJson,
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
      this.apiResponseJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_config_id'] = Variable<String>(taskConfigId);
    map['category_id'] = Variable<String>(categoryId);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || taskNameKey != null) {
      map['task_name_key'] = Variable<String>(taskNameKey);
    }
    if (!nullToAbsent || taskNameOverride != null) {
      map['task_name_override'] = Variable<String>(taskNameOverride);
    }
    if (!nullToAbsent || customTitle != null) {
      map['custom_title'] = Variable<String>(customTitle);
    }
    map['repeat_option'] = Variable<String>(repeatOption);
    map['scheduled_times_json'] = Variable<String>(scheduledTimesJson);
    map['scheduled_weekdays_json'] = Variable<String>(scheduledWeekdaysJson);
    if (!nullToAbsent || scheduledYearlyDateMs != null) {
      map['scheduled_yearly_date_ms'] = Variable<int>(scheduledYearlyDateMs);
    }
    map['scheduled_yearly_dates_json'] =
        Variable<String>(scheduledYearlyDatesJson);
    if (!nullToAbsent || monthlyMode != null) {
      map['monthly_mode'] = Variable<String>(monthlyMode);
    }
    if (!nullToAbsent || monthlySpecificDate != null) {
      map['monthly_specific_date'] = Variable<int>(monthlySpecificDate);
    }
    if (!nullToAbsent || monthlyShortMonthFallback != null) {
      map['monthly_short_month_fallback'] =
          Variable<String>(monthlyShortMonthFallback);
    }
    map['reminder_minutes_json'] = Variable<String>(reminderMinutesJson);
    map['channel_app'] = Variable<bool>(channelApp);
    map['channel_alarm'] = Variable<bool>(channelAlarm);
    map['channel_email'] = Variable<bool>(channelEmail);
    map['channel_whats_app'] = Variable<bool>(channelWhatsApp);
    if (!nullToAbsent || locationKey != null) {
      map['location_key'] = Variable<String>(locationKey);
    }
    if (!nullToAbsent || customLocationName != null) {
      map['custom_location_name'] = Variable<String>(customLocationName);
    }
    if (!nullToAbsent || linkedTaskConfigId != null) {
      map['linked_task_config_id'] = Variable<String>(linkedTaskConfigId);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    map['points_per_completion'] = Variable<int>(pointsPerCompletion);
    map['home_timezone'] = Variable<String>(homeTimezone);
    map['system_timezone_at_creation'] =
        Variable<String>(systemTimezoneAtCreation);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_archived'] = Variable<bool>(isArchived);
    if (!nullToAbsent || apiResponseJson != null) {
      map['api_response_json'] = Variable<String>(apiResponseJson);
    }
    return map;
  }

  SavedTasksTableCompanion toCompanion(bool nullToAbsent) {
    return SavedTasksTableCompanion(
      id: Value(id),
      taskConfigId: Value(taskConfigId),
      categoryId: Value(categoryId),
      source: Value(source),
      taskNameKey: taskNameKey == null && nullToAbsent
          ? const Value.absent()
          : Value(taskNameKey),
      taskNameOverride: taskNameOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(taskNameOverride),
      customTitle: customTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(customTitle),
      repeatOption: Value(repeatOption),
      scheduledTimesJson: Value(scheduledTimesJson),
      scheduledWeekdaysJson: Value(scheduledWeekdaysJson),
      scheduledYearlyDateMs: scheduledYearlyDateMs == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledYearlyDateMs),
      scheduledYearlyDatesJson: Value(scheduledYearlyDatesJson),
      monthlyMode: monthlyMode == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyMode),
      monthlySpecificDate: monthlySpecificDate == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlySpecificDate),
      monthlyShortMonthFallback:
          monthlyShortMonthFallback == null && nullToAbsent
              ? const Value.absent()
              : Value(monthlyShortMonthFallback),
      reminderMinutesJson: Value(reminderMinutesJson),
      channelApp: Value(channelApp),
      channelAlarm: Value(channelAlarm),
      channelEmail: Value(channelEmail),
      channelWhatsApp: Value(channelWhatsApp),
      locationKey: locationKey == null && nullToAbsent
          ? const Value.absent()
          : Value(locationKey),
      customLocationName: customLocationName == null && nullToAbsent
          ? const Value.absent()
          : Value(customLocationName),
      linkedTaskConfigId: linkedTaskConfigId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedTaskConfigId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      pointsPerCompletion: Value(pointsPerCompletion),
      homeTimezone: Value(homeTimezone),
      systemTimezoneAtCreation: Value(systemTimezoneAtCreation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isArchived: Value(isArchived),
      apiResponseJson: apiResponseJson == null && nullToAbsent
          ? const Value.absent()
          : Value(apiResponseJson),
    );
  }

  factory SavedTasksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedTasksTableData(
      id: serializer.fromJson<int>(json['id']),
      taskConfigId: serializer.fromJson<String>(json['taskConfigId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      source: serializer.fromJson<String>(json['source']),
      taskNameKey: serializer.fromJson<String?>(json['taskNameKey']),
      taskNameOverride: serializer.fromJson<String?>(json['taskNameOverride']),
      customTitle: serializer.fromJson<String?>(json['customTitle']),
      repeatOption: serializer.fromJson<String>(json['repeatOption']),
      scheduledTimesJson:
          serializer.fromJson<String>(json['scheduledTimesJson']),
      scheduledWeekdaysJson:
          serializer.fromJson<String>(json['scheduledWeekdaysJson']),
      scheduledYearlyDateMs:
          serializer.fromJson<int?>(json['scheduledYearlyDateMs']),
      scheduledYearlyDatesJson:
          serializer.fromJson<String>(json['scheduledYearlyDatesJson']),
      monthlyMode: serializer.fromJson<String?>(json['monthlyMode']),
      monthlySpecificDate:
          serializer.fromJson<int?>(json['monthlySpecificDate']),
      monthlyShortMonthFallback:
          serializer.fromJson<String?>(json['monthlyShortMonthFallback']),
      reminderMinutesJson:
          serializer.fromJson<String>(json['reminderMinutesJson']),
      channelApp: serializer.fromJson<bool>(json['channelApp']),
      channelAlarm: serializer.fromJson<bool>(json['channelAlarm']),
      channelEmail: serializer.fromJson<bool>(json['channelEmail']),
      channelWhatsApp: serializer.fromJson<bool>(json['channelWhatsApp']),
      locationKey: serializer.fromJson<String?>(json['locationKey']),
      customLocationName:
          serializer.fromJson<String?>(json['customLocationName']),
      linkedTaskConfigId:
          serializer.fromJson<String?>(json['linkedTaskConfigId']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      pointsPerCompletion:
          serializer.fromJson<int>(json['pointsPerCompletion']),
      homeTimezone: serializer.fromJson<String>(json['homeTimezone']),
      systemTimezoneAtCreation:
          serializer.fromJson<String>(json['systemTimezoneAtCreation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      apiResponseJson: serializer.fromJson<String?>(json['apiResponseJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskConfigId': serializer.toJson<String>(taskConfigId),
      'categoryId': serializer.toJson<String>(categoryId),
      'source': serializer.toJson<String>(source),
      'taskNameKey': serializer.toJson<String?>(taskNameKey),
      'taskNameOverride': serializer.toJson<String?>(taskNameOverride),
      'customTitle': serializer.toJson<String?>(customTitle),
      'repeatOption': serializer.toJson<String>(repeatOption),
      'scheduledTimesJson': serializer.toJson<String>(scheduledTimesJson),
      'scheduledWeekdaysJson': serializer.toJson<String>(scheduledWeekdaysJson),
      'scheduledYearlyDateMs': serializer.toJson<int?>(scheduledYearlyDateMs),
      'scheduledYearlyDatesJson':
          serializer.toJson<String>(scheduledYearlyDatesJson),
      'monthlyMode': serializer.toJson<String?>(monthlyMode),
      'monthlySpecificDate': serializer.toJson<int?>(monthlySpecificDate),
      'monthlyShortMonthFallback':
          serializer.toJson<String?>(monthlyShortMonthFallback),
      'reminderMinutesJson': serializer.toJson<String>(reminderMinutesJson),
      'channelApp': serializer.toJson<bool>(channelApp),
      'channelAlarm': serializer.toJson<bool>(channelAlarm),
      'channelEmail': serializer.toJson<bool>(channelEmail),
      'channelWhatsApp': serializer.toJson<bool>(channelWhatsApp),
      'locationKey': serializer.toJson<String?>(locationKey),
      'customLocationName': serializer.toJson<String?>(customLocationName),
      'linkedTaskConfigId': serializer.toJson<String?>(linkedTaskConfigId),
      'groupId': serializer.toJson<String?>(groupId),
      'pointsPerCompletion': serializer.toJson<int>(pointsPerCompletion),
      'homeTimezone': serializer.toJson<String>(homeTimezone),
      'systemTimezoneAtCreation':
          serializer.toJson<String>(systemTimezoneAtCreation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isArchived': serializer.toJson<bool>(isArchived),
      'apiResponseJson': serializer.toJson<String?>(apiResponseJson),
    };
  }

  SavedTasksTableData copyWith(
          {int? id,
          String? taskConfigId,
          String? categoryId,
          String? source,
          Value<String?> taskNameKey = const Value.absent(),
          Value<String?> taskNameOverride = const Value.absent(),
          Value<String?> customTitle = const Value.absent(),
          String? repeatOption,
          String? scheduledTimesJson,
          String? scheduledWeekdaysJson,
          Value<int?> scheduledYearlyDateMs = const Value.absent(),
          String? scheduledYearlyDatesJson,
          Value<String?> monthlyMode = const Value.absent(),
          Value<int?> monthlySpecificDate = const Value.absent(),
          Value<String?> monthlyShortMonthFallback = const Value.absent(),
          String? reminderMinutesJson,
          bool? channelApp,
          bool? channelAlarm,
          bool? channelEmail,
          bool? channelWhatsApp,
          Value<String?> locationKey = const Value.absent(),
          Value<String?> customLocationName = const Value.absent(),
          Value<String?> linkedTaskConfigId = const Value.absent(),
          Value<String?> groupId = const Value.absent(),
          int? pointsPerCompletion,
          String? homeTimezone,
          String? systemTimezoneAtCreation,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isArchived,
          Value<String?> apiResponseJson = const Value.absent()}) =>
      SavedTasksTableData(
        id: id ?? this.id,
        taskConfigId: taskConfigId ?? this.taskConfigId,
        categoryId: categoryId ?? this.categoryId,
        source: source ?? this.source,
        taskNameKey: taskNameKey.present ? taskNameKey.value : this.taskNameKey,
        taskNameOverride: taskNameOverride.present
            ? taskNameOverride.value
            : this.taskNameOverride,
        customTitle: customTitle.present ? customTitle.value : this.customTitle,
        repeatOption: repeatOption ?? this.repeatOption,
        scheduledTimesJson: scheduledTimesJson ?? this.scheduledTimesJson,
        scheduledWeekdaysJson:
            scheduledWeekdaysJson ?? this.scheduledWeekdaysJson,
        scheduledYearlyDateMs: scheduledYearlyDateMs.present
            ? scheduledYearlyDateMs.value
            : this.scheduledYearlyDateMs,
        scheduledYearlyDatesJson:
            scheduledYearlyDatesJson ?? this.scheduledYearlyDatesJson,
        monthlyMode: monthlyMode.present ? monthlyMode.value : this.monthlyMode,
        monthlySpecificDate: monthlySpecificDate.present
            ? monthlySpecificDate.value
            : this.monthlySpecificDate,
        monthlyShortMonthFallback: monthlyShortMonthFallback.present
            ? monthlyShortMonthFallback.value
            : this.monthlyShortMonthFallback,
        reminderMinutesJson: reminderMinutesJson ?? this.reminderMinutesJson,
        channelApp: channelApp ?? this.channelApp,
        channelAlarm: channelAlarm ?? this.channelAlarm,
        channelEmail: channelEmail ?? this.channelEmail,
        channelWhatsApp: channelWhatsApp ?? this.channelWhatsApp,
        locationKey: locationKey.present ? locationKey.value : this.locationKey,
        customLocationName: customLocationName.present
            ? customLocationName.value
            : this.customLocationName,
        linkedTaskConfigId: linkedTaskConfigId.present
            ? linkedTaskConfigId.value
            : this.linkedTaskConfigId,
        groupId: groupId.present ? groupId.value : this.groupId,
        pointsPerCompletion: pointsPerCompletion ?? this.pointsPerCompletion,
        homeTimezone: homeTimezone ?? this.homeTimezone,
        systemTimezoneAtCreation:
            systemTimezoneAtCreation ?? this.systemTimezoneAtCreation,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isArchived: isArchived ?? this.isArchived,
        apiResponseJson: apiResponseJson.present
            ? apiResponseJson.value
            : this.apiResponseJson,
      );
  SavedTasksTableData copyWithCompanion(SavedTasksTableCompanion data) {
    return SavedTasksTableData(
      id: data.id.present ? data.id.value : this.id,
      taskConfigId: data.taskConfigId.present
          ? data.taskConfigId.value
          : this.taskConfigId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      source: data.source.present ? data.source.value : this.source,
      taskNameKey:
          data.taskNameKey.present ? data.taskNameKey.value : this.taskNameKey,
      taskNameOverride: data.taskNameOverride.present
          ? data.taskNameOverride.value
          : this.taskNameOverride,
      customTitle:
          data.customTitle.present ? data.customTitle.value : this.customTitle,
      repeatOption: data.repeatOption.present
          ? data.repeatOption.value
          : this.repeatOption,
      scheduledTimesJson: data.scheduledTimesJson.present
          ? data.scheduledTimesJson.value
          : this.scheduledTimesJson,
      scheduledWeekdaysJson: data.scheduledWeekdaysJson.present
          ? data.scheduledWeekdaysJson.value
          : this.scheduledWeekdaysJson,
      scheduledYearlyDateMs: data.scheduledYearlyDateMs.present
          ? data.scheduledYearlyDateMs.value
          : this.scheduledYearlyDateMs,
      scheduledYearlyDatesJson: data.scheduledYearlyDatesJson.present
          ? data.scheduledYearlyDatesJson.value
          : this.scheduledYearlyDatesJson,
      monthlyMode:
          data.monthlyMode.present ? data.monthlyMode.value : this.monthlyMode,
      monthlySpecificDate: data.monthlySpecificDate.present
          ? data.monthlySpecificDate.value
          : this.monthlySpecificDate,
      monthlyShortMonthFallback: data.monthlyShortMonthFallback.present
          ? data.monthlyShortMonthFallback.value
          : this.monthlyShortMonthFallback,
      reminderMinutesJson: data.reminderMinutesJson.present
          ? data.reminderMinutesJson.value
          : this.reminderMinutesJson,
      channelApp:
          data.channelApp.present ? data.channelApp.value : this.channelApp,
      channelAlarm: data.channelAlarm.present
          ? data.channelAlarm.value
          : this.channelAlarm,
      channelEmail: data.channelEmail.present
          ? data.channelEmail.value
          : this.channelEmail,
      channelWhatsApp: data.channelWhatsApp.present
          ? data.channelWhatsApp.value
          : this.channelWhatsApp,
      locationKey:
          data.locationKey.present ? data.locationKey.value : this.locationKey,
      customLocationName: data.customLocationName.present
          ? data.customLocationName.value
          : this.customLocationName,
      linkedTaskConfigId: data.linkedTaskConfigId.present
          ? data.linkedTaskConfigId.value
          : this.linkedTaskConfigId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      pointsPerCompletion: data.pointsPerCompletion.present
          ? data.pointsPerCompletion.value
          : this.pointsPerCompletion,
      homeTimezone: data.homeTimezone.present
          ? data.homeTimezone.value
          : this.homeTimezone,
      systemTimezoneAtCreation: data.systemTimezoneAtCreation.present
          ? data.systemTimezoneAtCreation.value
          : this.systemTimezoneAtCreation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      apiResponseJson: data.apiResponseJson.present
          ? data.apiResponseJson.value
          : this.apiResponseJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedTasksTableData(')
          ..write('id: $id, ')
          ..write('taskConfigId: $taskConfigId, ')
          ..write('categoryId: $categoryId, ')
          ..write('source: $source, ')
          ..write('taskNameKey: $taskNameKey, ')
          ..write('taskNameOverride: $taskNameOverride, ')
          ..write('customTitle: $customTitle, ')
          ..write('repeatOption: $repeatOption, ')
          ..write('scheduledTimesJson: $scheduledTimesJson, ')
          ..write('scheduledWeekdaysJson: $scheduledWeekdaysJson, ')
          ..write('scheduledYearlyDateMs: $scheduledYearlyDateMs, ')
          ..write('scheduledYearlyDatesJson: $scheduledYearlyDatesJson, ')
          ..write('monthlyMode: $monthlyMode, ')
          ..write('monthlySpecificDate: $monthlySpecificDate, ')
          ..write('monthlyShortMonthFallback: $monthlyShortMonthFallback, ')
          ..write('reminderMinutesJson: $reminderMinutesJson, ')
          ..write('channelApp: $channelApp, ')
          ..write('channelAlarm: $channelAlarm, ')
          ..write('channelEmail: $channelEmail, ')
          ..write('channelWhatsApp: $channelWhatsApp, ')
          ..write('locationKey: $locationKey, ')
          ..write('customLocationName: $customLocationName, ')
          ..write('linkedTaskConfigId: $linkedTaskConfigId, ')
          ..write('groupId: $groupId, ')
          ..write('pointsPerCompletion: $pointsPerCompletion, ')
          ..write('homeTimezone: $homeTimezone, ')
          ..write('systemTimezoneAtCreation: $systemTimezoneAtCreation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('apiResponseJson: $apiResponseJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        taskConfigId,
        categoryId,
        source,
        taskNameKey,
        taskNameOverride,
        customTitle,
        repeatOption,
        scheduledTimesJson,
        scheduledWeekdaysJson,
        scheduledYearlyDateMs,
        scheduledYearlyDatesJson,
        monthlyMode,
        monthlySpecificDate,
        monthlyShortMonthFallback,
        reminderMinutesJson,
        channelApp,
        channelAlarm,
        channelEmail,
        channelWhatsApp,
        locationKey,
        customLocationName,
        linkedTaskConfigId,
        groupId,
        pointsPerCompletion,
        homeTimezone,
        systemTimezoneAtCreation,
        createdAt,
        updatedAt,
        isArchived,
        apiResponseJson
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedTasksTableData &&
          other.id == this.id &&
          other.taskConfigId == this.taskConfigId &&
          other.categoryId == this.categoryId &&
          other.source == this.source &&
          other.taskNameKey == this.taskNameKey &&
          other.taskNameOverride == this.taskNameOverride &&
          other.customTitle == this.customTitle &&
          other.repeatOption == this.repeatOption &&
          other.scheduledTimesJson == this.scheduledTimesJson &&
          other.scheduledWeekdaysJson == this.scheduledWeekdaysJson &&
          other.scheduledYearlyDateMs == this.scheduledYearlyDateMs &&
          other.scheduledYearlyDatesJson == this.scheduledYearlyDatesJson &&
          other.monthlyMode == this.monthlyMode &&
          other.monthlySpecificDate == this.monthlySpecificDate &&
          other.monthlyShortMonthFallback == this.monthlyShortMonthFallback &&
          other.reminderMinutesJson == this.reminderMinutesJson &&
          other.channelApp == this.channelApp &&
          other.channelAlarm == this.channelAlarm &&
          other.channelEmail == this.channelEmail &&
          other.channelWhatsApp == this.channelWhatsApp &&
          other.locationKey == this.locationKey &&
          other.customLocationName == this.customLocationName &&
          other.linkedTaskConfigId == this.linkedTaskConfigId &&
          other.groupId == this.groupId &&
          other.pointsPerCompletion == this.pointsPerCompletion &&
          other.homeTimezone == this.homeTimezone &&
          other.systemTimezoneAtCreation == this.systemTimezoneAtCreation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isArchived == this.isArchived &&
          other.apiResponseJson == this.apiResponseJson);
}

class SavedTasksTableCompanion extends UpdateCompanion<SavedTasksTableData> {
  final Value<int> id;
  final Value<String> taskConfigId;
  final Value<String> categoryId;
  final Value<String> source;
  final Value<String?> taskNameKey;
  final Value<String?> taskNameOverride;
  final Value<String?> customTitle;
  final Value<String> repeatOption;
  final Value<String> scheduledTimesJson;
  final Value<String> scheduledWeekdaysJson;
  final Value<int?> scheduledYearlyDateMs;
  final Value<String> scheduledYearlyDatesJson;
  final Value<String?> monthlyMode;
  final Value<int?> monthlySpecificDate;
  final Value<String?> monthlyShortMonthFallback;
  final Value<String> reminderMinutesJson;
  final Value<bool> channelApp;
  final Value<bool> channelAlarm;
  final Value<bool> channelEmail;
  final Value<bool> channelWhatsApp;
  final Value<String?> locationKey;
  final Value<String?> customLocationName;
  final Value<String?> linkedTaskConfigId;
  final Value<String?> groupId;
  final Value<int> pointsPerCompletion;
  final Value<String> homeTimezone;
  final Value<String> systemTimezoneAtCreation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isArchived;
  final Value<String?> apiResponseJson;
  const SavedTasksTableCompanion({
    this.id = const Value.absent(),
    this.taskConfigId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.source = const Value.absent(),
    this.taskNameKey = const Value.absent(),
    this.taskNameOverride = const Value.absent(),
    this.customTitle = const Value.absent(),
    this.repeatOption = const Value.absent(),
    this.scheduledTimesJson = const Value.absent(),
    this.scheduledWeekdaysJson = const Value.absent(),
    this.scheduledYearlyDateMs = const Value.absent(),
    this.scheduledYearlyDatesJson = const Value.absent(),
    this.monthlyMode = const Value.absent(),
    this.monthlySpecificDate = const Value.absent(),
    this.monthlyShortMonthFallback = const Value.absent(),
    this.reminderMinutesJson = const Value.absent(),
    this.channelApp = const Value.absent(),
    this.channelAlarm = const Value.absent(),
    this.channelEmail = const Value.absent(),
    this.channelWhatsApp = const Value.absent(),
    this.locationKey = const Value.absent(),
    this.customLocationName = const Value.absent(),
    this.linkedTaskConfigId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.pointsPerCompletion = const Value.absent(),
    this.homeTimezone = const Value.absent(),
    this.systemTimezoneAtCreation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.apiResponseJson = const Value.absent(),
  });
  SavedTasksTableCompanion.insert({
    this.id = const Value.absent(),
    required String taskConfigId,
    required String categoryId,
    required String source,
    this.taskNameKey = const Value.absent(),
    this.taskNameOverride = const Value.absent(),
    this.customTitle = const Value.absent(),
    required String repeatOption,
    required String scheduledTimesJson,
    required String scheduledWeekdaysJson,
    this.scheduledYearlyDateMs = const Value.absent(),
    required String scheduledYearlyDatesJson,
    this.monthlyMode = const Value.absent(),
    this.monthlySpecificDate = const Value.absent(),
    this.monthlyShortMonthFallback = const Value.absent(),
    required String reminderMinutesJson,
    this.channelApp = const Value.absent(),
    this.channelAlarm = const Value.absent(),
    this.channelEmail = const Value.absent(),
    this.channelWhatsApp = const Value.absent(),
    this.locationKey = const Value.absent(),
    this.customLocationName = const Value.absent(),
    this.linkedTaskConfigId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.pointsPerCompletion = const Value.absent(),
    required String homeTimezone,
    required String systemTimezoneAtCreation,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isArchived = const Value.absent(),
    this.apiResponseJson = const Value.absent(),
  })  : taskConfigId = Value(taskConfigId),
        categoryId = Value(categoryId),
        source = Value(source),
        repeatOption = Value(repeatOption),
        scheduledTimesJson = Value(scheduledTimesJson),
        scheduledWeekdaysJson = Value(scheduledWeekdaysJson),
        scheduledYearlyDatesJson = Value(scheduledYearlyDatesJson),
        reminderMinutesJson = Value(reminderMinutesJson),
        homeTimezone = Value(homeTimezone),
        systemTimezoneAtCreation = Value(systemTimezoneAtCreation),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SavedTasksTableData> custom({
    Expression<int>? id,
    Expression<String>? taskConfigId,
    Expression<String>? categoryId,
    Expression<String>? source,
    Expression<String>? taskNameKey,
    Expression<String>? taskNameOverride,
    Expression<String>? customTitle,
    Expression<String>? repeatOption,
    Expression<String>? scheduledTimesJson,
    Expression<String>? scheduledWeekdaysJson,
    Expression<int>? scheduledYearlyDateMs,
    Expression<String>? scheduledYearlyDatesJson,
    Expression<String>? monthlyMode,
    Expression<int>? monthlySpecificDate,
    Expression<String>? monthlyShortMonthFallback,
    Expression<String>? reminderMinutesJson,
    Expression<bool>? channelApp,
    Expression<bool>? channelAlarm,
    Expression<bool>? channelEmail,
    Expression<bool>? channelWhatsApp,
    Expression<String>? locationKey,
    Expression<String>? customLocationName,
    Expression<String>? linkedTaskConfigId,
    Expression<String>? groupId,
    Expression<int>? pointsPerCompletion,
    Expression<String>? homeTimezone,
    Expression<String>? systemTimezoneAtCreation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isArchived,
    Expression<String>? apiResponseJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskConfigId != null) 'task_config_id': taskConfigId,
      if (categoryId != null) 'category_id': categoryId,
      if (source != null) 'source': source,
      if (taskNameKey != null) 'task_name_key': taskNameKey,
      if (taskNameOverride != null) 'task_name_override': taskNameOverride,
      if (customTitle != null) 'custom_title': customTitle,
      if (repeatOption != null) 'repeat_option': repeatOption,
      if (scheduledTimesJson != null)
        'scheduled_times_json': scheduledTimesJson,
      if (scheduledWeekdaysJson != null)
        'scheduled_weekdays_json': scheduledWeekdaysJson,
      if (scheduledYearlyDateMs != null)
        'scheduled_yearly_date_ms': scheduledYearlyDateMs,
      if (scheduledYearlyDatesJson != null)
        'scheduled_yearly_dates_json': scheduledYearlyDatesJson,
      if (monthlyMode != null) 'monthly_mode': monthlyMode,
      if (monthlySpecificDate != null)
        'monthly_specific_date': monthlySpecificDate,
      if (monthlyShortMonthFallback != null)
        'monthly_short_month_fallback': monthlyShortMonthFallback,
      if (reminderMinutesJson != null)
        'reminder_minutes_json': reminderMinutesJson,
      if (channelApp != null) 'channel_app': channelApp,
      if (channelAlarm != null) 'channel_alarm': channelAlarm,
      if (channelEmail != null) 'channel_email': channelEmail,
      if (channelWhatsApp != null) 'channel_whats_app': channelWhatsApp,
      if (locationKey != null) 'location_key': locationKey,
      if (customLocationName != null)
        'custom_location_name': customLocationName,
      if (linkedTaskConfigId != null)
        'linked_task_config_id': linkedTaskConfigId,
      if (groupId != null) 'group_id': groupId,
      if (pointsPerCompletion != null)
        'points_per_completion': pointsPerCompletion,
      if (homeTimezone != null) 'home_timezone': homeTimezone,
      if (systemTimezoneAtCreation != null)
        'system_timezone_at_creation': systemTimezoneAtCreation,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (apiResponseJson != null) 'api_response_json': apiResponseJson,
    });
  }

  SavedTasksTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? taskConfigId,
      Value<String>? categoryId,
      Value<String>? source,
      Value<String?>? taskNameKey,
      Value<String?>? taskNameOverride,
      Value<String?>? customTitle,
      Value<String>? repeatOption,
      Value<String>? scheduledTimesJson,
      Value<String>? scheduledWeekdaysJson,
      Value<int?>? scheduledYearlyDateMs,
      Value<String>? scheduledYearlyDatesJson,
      Value<String?>? monthlyMode,
      Value<int?>? monthlySpecificDate,
      Value<String?>? monthlyShortMonthFallback,
      Value<String>? reminderMinutesJson,
      Value<bool>? channelApp,
      Value<bool>? channelAlarm,
      Value<bool>? channelEmail,
      Value<bool>? channelWhatsApp,
      Value<String?>? locationKey,
      Value<String?>? customLocationName,
      Value<String?>? linkedTaskConfigId,
      Value<String?>? groupId,
      Value<int>? pointsPerCompletion,
      Value<String>? homeTimezone,
      Value<String>? systemTimezoneAtCreation,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isArchived,
      Value<String?>? apiResponseJson}) {
    return SavedTasksTableCompanion(
      id: id ?? this.id,
      taskConfigId: taskConfigId ?? this.taskConfigId,
      categoryId: categoryId ?? this.categoryId,
      source: source ?? this.source,
      taskNameKey: taskNameKey ?? this.taskNameKey,
      taskNameOverride: taskNameOverride ?? this.taskNameOverride,
      customTitle: customTitle ?? this.customTitle,
      repeatOption: repeatOption ?? this.repeatOption,
      scheduledTimesJson: scheduledTimesJson ?? this.scheduledTimesJson,
      scheduledWeekdaysJson:
          scheduledWeekdaysJson ?? this.scheduledWeekdaysJson,
      scheduledYearlyDateMs:
          scheduledYearlyDateMs ?? this.scheduledYearlyDateMs,
      scheduledYearlyDatesJson:
          scheduledYearlyDatesJson ?? this.scheduledYearlyDatesJson,
      monthlyMode: monthlyMode ?? this.monthlyMode,
      monthlySpecificDate: monthlySpecificDate ?? this.monthlySpecificDate,
      monthlyShortMonthFallback:
          monthlyShortMonthFallback ?? this.monthlyShortMonthFallback,
      reminderMinutesJson: reminderMinutesJson ?? this.reminderMinutesJson,
      channelApp: channelApp ?? this.channelApp,
      channelAlarm: channelAlarm ?? this.channelAlarm,
      channelEmail: channelEmail ?? this.channelEmail,
      channelWhatsApp: channelWhatsApp ?? this.channelWhatsApp,
      locationKey: locationKey ?? this.locationKey,
      customLocationName: customLocationName ?? this.customLocationName,
      linkedTaskConfigId: linkedTaskConfigId ?? this.linkedTaskConfigId,
      groupId: groupId ?? this.groupId,
      pointsPerCompletion: pointsPerCompletion ?? this.pointsPerCompletion,
      homeTimezone: homeTimezone ?? this.homeTimezone,
      systemTimezoneAtCreation:
          systemTimezoneAtCreation ?? this.systemTimezoneAtCreation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
      apiResponseJson: apiResponseJson ?? this.apiResponseJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskConfigId.present) {
      map['task_config_id'] = Variable<String>(taskConfigId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (taskNameKey.present) {
      map['task_name_key'] = Variable<String>(taskNameKey.value);
    }
    if (taskNameOverride.present) {
      map['task_name_override'] = Variable<String>(taskNameOverride.value);
    }
    if (customTitle.present) {
      map['custom_title'] = Variable<String>(customTitle.value);
    }
    if (repeatOption.present) {
      map['repeat_option'] = Variable<String>(repeatOption.value);
    }
    if (scheduledTimesJson.present) {
      map['scheduled_times_json'] = Variable<String>(scheduledTimesJson.value);
    }
    if (scheduledWeekdaysJson.present) {
      map['scheduled_weekdays_json'] =
          Variable<String>(scheduledWeekdaysJson.value);
    }
    if (scheduledYearlyDateMs.present) {
      map['scheduled_yearly_date_ms'] =
          Variable<int>(scheduledYearlyDateMs.value);
    }
    if (scheduledYearlyDatesJson.present) {
      map['scheduled_yearly_dates_json'] =
          Variable<String>(scheduledYearlyDatesJson.value);
    }
    if (monthlyMode.present) {
      map['monthly_mode'] = Variable<String>(monthlyMode.value);
    }
    if (monthlySpecificDate.present) {
      map['monthly_specific_date'] = Variable<int>(monthlySpecificDate.value);
    }
    if (monthlyShortMonthFallback.present) {
      map['monthly_short_month_fallback'] =
          Variable<String>(monthlyShortMonthFallback.value);
    }
    if (reminderMinutesJson.present) {
      map['reminder_minutes_json'] =
          Variable<String>(reminderMinutesJson.value);
    }
    if (channelApp.present) {
      map['channel_app'] = Variable<bool>(channelApp.value);
    }
    if (channelAlarm.present) {
      map['channel_alarm'] = Variable<bool>(channelAlarm.value);
    }
    if (channelEmail.present) {
      map['channel_email'] = Variable<bool>(channelEmail.value);
    }
    if (channelWhatsApp.present) {
      map['channel_whats_app'] = Variable<bool>(channelWhatsApp.value);
    }
    if (locationKey.present) {
      map['location_key'] = Variable<String>(locationKey.value);
    }
    if (customLocationName.present) {
      map['custom_location_name'] = Variable<String>(customLocationName.value);
    }
    if (linkedTaskConfigId.present) {
      map['linked_task_config_id'] = Variable<String>(linkedTaskConfigId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (pointsPerCompletion.present) {
      map['points_per_completion'] = Variable<int>(pointsPerCompletion.value);
    }
    if (homeTimezone.present) {
      map['home_timezone'] = Variable<String>(homeTimezone.value);
    }
    if (systemTimezoneAtCreation.present) {
      map['system_timezone_at_creation'] =
          Variable<String>(systemTimezoneAtCreation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (apiResponseJson.present) {
      map['api_response_json'] = Variable<String>(apiResponseJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedTasksTableCompanion(')
          ..write('id: $id, ')
          ..write('taskConfigId: $taskConfigId, ')
          ..write('categoryId: $categoryId, ')
          ..write('source: $source, ')
          ..write('taskNameKey: $taskNameKey, ')
          ..write('taskNameOverride: $taskNameOverride, ')
          ..write('customTitle: $customTitle, ')
          ..write('repeatOption: $repeatOption, ')
          ..write('scheduledTimesJson: $scheduledTimesJson, ')
          ..write('scheduledWeekdaysJson: $scheduledWeekdaysJson, ')
          ..write('scheduledYearlyDateMs: $scheduledYearlyDateMs, ')
          ..write('scheduledYearlyDatesJson: $scheduledYearlyDatesJson, ')
          ..write('monthlyMode: $monthlyMode, ')
          ..write('monthlySpecificDate: $monthlySpecificDate, ')
          ..write('monthlyShortMonthFallback: $monthlyShortMonthFallback, ')
          ..write('reminderMinutesJson: $reminderMinutesJson, ')
          ..write('channelApp: $channelApp, ')
          ..write('channelAlarm: $channelAlarm, ')
          ..write('channelEmail: $channelEmail, ')
          ..write('channelWhatsApp: $channelWhatsApp, ')
          ..write('locationKey: $locationKey, ')
          ..write('customLocationName: $customLocationName, ')
          ..write('linkedTaskConfigId: $linkedTaskConfigId, ')
          ..write('groupId: $groupId, ')
          ..write('pointsPerCompletion: $pointsPerCompletion, ')
          ..write('homeTimezone: $homeTimezone, ')
          ..write('systemTimezoneAtCreation: $systemTimezoneAtCreation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('apiResponseJson: $apiResponseJson')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTableTable extends UserPreferencesTable
    with TableInfo<$UserPreferencesTableTable, UserPreferencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _wakeTimeMeta =
      const VerificationMeta('wakeTime');
  @override
  late final GeneratedColumn<String> wakeTime = GeneratedColumn<String>(
      'wake_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('07:00'));
  static const VerificationMeta _sleepTimeMeta =
      const VerificationMeta('sleepTime');
  @override
  late final GeneratedColumn<String> sleepTime = GeneratedColumn<String>(
      'sleep_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('22:30'));
  static const VerificationMeta _jobStartTimeMeta =
      const VerificationMeta('jobStartTime');
  @override
  late final GeneratedColumn<String> jobStartTime = GeneratedColumn<String>(
      'job_start_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('09:00'));
  static const VerificationMeta _jobEndTimeMeta =
      const VerificationMeta('jobEndTime');
  @override
  late final GeneratedColumn<String> jobEndTime = GeneratedColumn<String>(
      'job_end_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('17:30'));
  static const VerificationMeta _weekendWakeTimeMeta =
      const VerificationMeta('weekendWakeTime');
  @override
  late final GeneratedColumn<String> weekendWakeTime = GeneratedColumn<String>(
      'weekend_wake_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('08:30'));
  static const VerificationMeta _daysOffJsonMeta =
      const VerificationMeta('daysOffJson');
  @override
  late final GeneratedColumn<String> daysOffJson = GeneratedColumn<String>(
      'days_off_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[6,7]'));
  static const VerificationMeta _homeTimezoneMeta =
      const VerificationMeta('homeTimezone');
  @override
  late final GeneratedColumn<String> homeTimezone = GeneratedColumn<String>(
      'home_timezone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Europe/London'));
  static const VerificationMeta _homeLocationKeysJsonMeta =
      const VerificationMeta('homeLocationKeysJson');
  @override
  late final GeneratedColumn<String> homeLocationKeysJson =
      GeneratedColumn<String>('home_location_keys_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _customLocationNamesJsonMeta =
      const VerificationMeta('customLocationNamesJson');
  @override
  late final GeneratedColumn<String> customLocationNamesJson =
      GeneratedColumn<String>('custom_location_names_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _householdAgeGroupsJsonMeta =
      const VerificationMeta('householdAgeGroupsJson');
  @override
  late final GeneratedColumn<String> householdAgeGroupsJson =
      GeneratedColumn<String>('household_age_groups_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _vehiclesJsonMeta =
      const VerificationMeta('vehiclesJson');
  @override
  late final GeneratedColumn<String> vehiclesJson = GeneratedColumn<String>(
      'vehicles_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _petsJsonMeta =
      const VerificationMeta('petsJson');
  @override
  late final GeneratedColumn<String> petsJson = GeneratedColumn<String>(
      'pets_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _themeIdMeta =
      const VerificationMeta('themeId');
  @override
  late final GeneratedColumn<String> themeId = GeneratedColumn<String>(
      'theme_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('midnight_focus'));
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  static const VerificationMeta _textScaleFactorMeta =
      const VerificationMeta('textScaleFactor');
  @override
  late final GeneratedColumn<double> textScaleFactor = GeneratedColumn<double>(
      'text_scale_factor', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _setupWizardCompletedMeta =
      const VerificationMeta('setupWizardCompleted');
  @override
  late final GeneratedColumn<bool> setupWizardCompleted = GeneratedColumn<bool>(
      'setup_wizard_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("setup_wizard_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
      'onboarding_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _postcodeMeta =
      const VerificationMeta('postcode');
  @override
  late final GeneratedColumn<String> postcode = GeneratedColumn<String>(
      'postcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationLatitudeMeta =
      const VerificationMeta('locationLatitude');
  @override
  late final GeneratedColumn<double> locationLatitude = GeneratedColumn<double>(
      'location_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationLongitudeMeta =
      const VerificationMeta('locationLongitude');
  @override
  late final GeneratedColumn<double> locationLongitude =
      GeneratedColumn<double>('location_longitude', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _whatsAppNumberMeta =
      const VerificationMeta('whatsAppNumber');
  @override
  late final GeneratedColumn<String> whatsAppNumber = GeneratedColumn<String>(
      'whats_app_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _whatsAppEnabledMeta =
      const VerificationMeta('whatsAppEnabled');
  @override
  late final GeneratedColumn<bool> whatsAppEnabled = GeneratedColumn<bool>(
      'whats_app_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("whats_app_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _emailAddressMeta =
      const VerificationMeta('emailAddress');
  @override
  late final GeneratedColumn<String> emailAddress = GeneratedColumn<String>(
      'email_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailEnabledMeta =
      const VerificationMeta('emailEnabled');
  @override
  late final GeneratedColumn<bool> emailEnabled = GeneratedColumn<bool>(
      'email_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("email_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wakeTime,
        sleepTime,
        jobStartTime,
        jobEndTime,
        weekendWakeTime,
        daysOffJson,
        homeTimezone,
        homeLocationKeysJson,
        customLocationNamesJson,
        householdAgeGroupsJson,
        vehiclesJson,
        petsJson,
        themeId,
        languageCode,
        textScaleFactor,
        notificationsEnabled,
        setupWizardCompleted,
        onboardingCompleted,
        postcode,
        locationLatitude,
        locationLongitude,
        whatsAppNumber,
        whatsAppEnabled,
        emailAddress,
        emailEnabled,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserPreferencesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wake_time')) {
      context.handle(_wakeTimeMeta,
          wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta));
    }
    if (data.containsKey('sleep_time')) {
      context.handle(_sleepTimeMeta,
          sleepTime.isAcceptableOrUnknown(data['sleep_time']!, _sleepTimeMeta));
    }
    if (data.containsKey('job_start_time')) {
      context.handle(
          _jobStartTimeMeta,
          jobStartTime.isAcceptableOrUnknown(
              data['job_start_time']!, _jobStartTimeMeta));
    }
    if (data.containsKey('job_end_time')) {
      context.handle(
          _jobEndTimeMeta,
          jobEndTime.isAcceptableOrUnknown(
              data['job_end_time']!, _jobEndTimeMeta));
    }
    if (data.containsKey('weekend_wake_time')) {
      context.handle(
          _weekendWakeTimeMeta,
          weekendWakeTime.isAcceptableOrUnknown(
              data['weekend_wake_time']!, _weekendWakeTimeMeta));
    }
    if (data.containsKey('days_off_json')) {
      context.handle(
          _daysOffJsonMeta,
          daysOffJson.isAcceptableOrUnknown(
              data['days_off_json']!, _daysOffJsonMeta));
    }
    if (data.containsKey('home_timezone')) {
      context.handle(
          _homeTimezoneMeta,
          homeTimezone.isAcceptableOrUnknown(
              data['home_timezone']!, _homeTimezoneMeta));
    }
    if (data.containsKey('home_location_keys_json')) {
      context.handle(
          _homeLocationKeysJsonMeta,
          homeLocationKeysJson.isAcceptableOrUnknown(
              data['home_location_keys_json']!, _homeLocationKeysJsonMeta));
    }
    if (data.containsKey('custom_location_names_json')) {
      context.handle(
          _customLocationNamesJsonMeta,
          customLocationNamesJson.isAcceptableOrUnknown(
              data['custom_location_names_json']!,
              _customLocationNamesJsonMeta));
    }
    if (data.containsKey('household_age_groups_json')) {
      context.handle(
          _householdAgeGroupsJsonMeta,
          householdAgeGroupsJson.isAcceptableOrUnknown(
              data['household_age_groups_json']!, _householdAgeGroupsJsonMeta));
    }
    if (data.containsKey('vehicles_json')) {
      context.handle(
          _vehiclesJsonMeta,
          vehiclesJson.isAcceptableOrUnknown(
              data['vehicles_json']!, _vehiclesJsonMeta));
    }
    if (data.containsKey('pets_json')) {
      context.handle(_petsJsonMeta,
          petsJson.isAcceptableOrUnknown(data['pets_json']!, _petsJsonMeta));
    }
    if (data.containsKey('theme_id')) {
      context.handle(_themeIdMeta,
          themeId.isAcceptableOrUnknown(data['theme_id']!, _themeIdMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('text_scale_factor')) {
      context.handle(
          _textScaleFactorMeta,
          textScaleFactor.isAcceptableOrUnknown(
              data['text_scale_factor']!, _textScaleFactorMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('setup_wizard_completed')) {
      context.handle(
          _setupWizardCompletedMeta,
          setupWizardCompleted.isAcceptableOrUnknown(
              data['setup_wizard_completed']!, _setupWizardCompletedMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
          _onboardingCompletedMeta,
          onboardingCompleted.isAcceptableOrUnknown(
              data['onboarding_completed']!, _onboardingCompletedMeta));
    }
    if (data.containsKey('postcode')) {
      context.handle(_postcodeMeta,
          postcode.isAcceptableOrUnknown(data['postcode']!, _postcodeMeta));
    }
    if (data.containsKey('location_latitude')) {
      context.handle(
          _locationLatitudeMeta,
          locationLatitude.isAcceptableOrUnknown(
              data['location_latitude']!, _locationLatitudeMeta));
    }
    if (data.containsKey('location_longitude')) {
      context.handle(
          _locationLongitudeMeta,
          locationLongitude.isAcceptableOrUnknown(
              data['location_longitude']!, _locationLongitudeMeta));
    }
    if (data.containsKey('whats_app_number')) {
      context.handle(
          _whatsAppNumberMeta,
          whatsAppNumber.isAcceptableOrUnknown(
              data['whats_app_number']!, _whatsAppNumberMeta));
    }
    if (data.containsKey('whats_app_enabled')) {
      context.handle(
          _whatsAppEnabledMeta,
          whatsAppEnabled.isAcceptableOrUnknown(
              data['whats_app_enabled']!, _whatsAppEnabledMeta));
    }
    if (data.containsKey('email_address')) {
      context.handle(
          _emailAddressMeta,
          emailAddress.isAcceptableOrUnknown(
              data['email_address']!, _emailAddressMeta));
    }
    if (data.containsKey('email_enabled')) {
      context.handle(
          _emailEnabledMeta,
          emailEnabled.isAcceptableOrUnknown(
              data['email_enabled']!, _emailEnabledMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreferencesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferencesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wakeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wake_time'])!,
      sleepTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sleep_time'])!,
      jobStartTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_start_time'])!,
      jobEndTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_end_time'])!,
      weekendWakeTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}weekend_wake_time'])!,
      daysOffJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}days_off_json'])!,
      homeTimezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}home_timezone'])!,
      homeLocationKeysJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}home_location_keys_json'])!,
      customLocationNamesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}custom_location_names_json'])!,
      householdAgeGroupsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}household_age_groups_json'])!,
      vehiclesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicles_json'])!,
      petsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pets_json'])!,
      themeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_id'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      textScaleFactor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}text_scale_factor'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      setupWizardCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}setup_wizard_completed'])!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}onboarding_completed'])!,
      postcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postcode']),
      locationLatitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}location_latitude']),
      locationLongitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}location_longitude']),
      whatsAppNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}whats_app_number']),
      whatsAppEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}whats_app_enabled'])!,
      emailAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email_address']),
      emailEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}email_enabled'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserPreferencesTableTable createAlias(String alias) {
    return $UserPreferencesTableTable(attachedDatabase, alias);
  }
}

class UserPreferencesTableData extends DataClass
    implements Insertable<UserPreferencesTableData> {
  final int id;
  final String wakeTime;
  final String sleepTime;
  final String jobStartTime;
  final String jobEndTime;
  final String weekendWakeTime;
  final String daysOffJson;
  final String homeTimezone;
  final String homeLocationKeysJson;
  final String customLocationNamesJson;
  final String householdAgeGroupsJson;
  final String vehiclesJson;
  final String petsJson;
  final String themeId;
  final String languageCode;
  final double textScaleFactor;
  final bool notificationsEnabled;
  final bool setupWizardCompleted;
  final bool onboardingCompleted;
  final String? postcode;
  final double? locationLatitude;
  final double? locationLongitude;
  final String? whatsAppNumber;
  final bool whatsAppEnabled;
  final String? emailAddress;
  final bool emailEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserPreferencesTableData(
      {required this.id,
      required this.wakeTime,
      required this.sleepTime,
      required this.jobStartTime,
      required this.jobEndTime,
      required this.weekendWakeTime,
      required this.daysOffJson,
      required this.homeTimezone,
      required this.homeLocationKeysJson,
      required this.customLocationNamesJson,
      required this.householdAgeGroupsJson,
      required this.vehiclesJson,
      required this.petsJson,
      required this.themeId,
      required this.languageCode,
      required this.textScaleFactor,
      required this.notificationsEnabled,
      required this.setupWizardCompleted,
      required this.onboardingCompleted,
      this.postcode,
      this.locationLatitude,
      this.locationLongitude,
      this.whatsAppNumber,
      required this.whatsAppEnabled,
      this.emailAddress,
      required this.emailEnabled,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wake_time'] = Variable<String>(wakeTime);
    map['sleep_time'] = Variable<String>(sleepTime);
    map['job_start_time'] = Variable<String>(jobStartTime);
    map['job_end_time'] = Variable<String>(jobEndTime);
    map['weekend_wake_time'] = Variable<String>(weekendWakeTime);
    map['days_off_json'] = Variable<String>(daysOffJson);
    map['home_timezone'] = Variable<String>(homeTimezone);
    map['home_location_keys_json'] = Variable<String>(homeLocationKeysJson);
    map['custom_location_names_json'] =
        Variable<String>(customLocationNamesJson);
    map['household_age_groups_json'] = Variable<String>(householdAgeGroupsJson);
    map['vehicles_json'] = Variable<String>(vehiclesJson);
    map['pets_json'] = Variable<String>(petsJson);
    map['theme_id'] = Variable<String>(themeId);
    map['language_code'] = Variable<String>(languageCode);
    map['text_scale_factor'] = Variable<double>(textScaleFactor);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['setup_wizard_completed'] = Variable<bool>(setupWizardCompleted);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    if (!nullToAbsent || postcode != null) {
      map['postcode'] = Variable<String>(postcode);
    }
    if (!nullToAbsent || locationLatitude != null) {
      map['location_latitude'] = Variable<double>(locationLatitude);
    }
    if (!nullToAbsent || locationLongitude != null) {
      map['location_longitude'] = Variable<double>(locationLongitude);
    }
    if (!nullToAbsent || whatsAppNumber != null) {
      map['whats_app_number'] = Variable<String>(whatsAppNumber);
    }
    map['whats_app_enabled'] = Variable<bool>(whatsAppEnabled);
    if (!nullToAbsent || emailAddress != null) {
      map['email_address'] = Variable<String>(emailAddress);
    }
    map['email_enabled'] = Variable<bool>(emailEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesTableCompanion(
      id: Value(id),
      wakeTime: Value(wakeTime),
      sleepTime: Value(sleepTime),
      jobStartTime: Value(jobStartTime),
      jobEndTime: Value(jobEndTime),
      weekendWakeTime: Value(weekendWakeTime),
      daysOffJson: Value(daysOffJson),
      homeTimezone: Value(homeTimezone),
      homeLocationKeysJson: Value(homeLocationKeysJson),
      customLocationNamesJson: Value(customLocationNamesJson),
      householdAgeGroupsJson: Value(householdAgeGroupsJson),
      vehiclesJson: Value(vehiclesJson),
      petsJson: Value(petsJson),
      themeId: Value(themeId),
      languageCode: Value(languageCode),
      textScaleFactor: Value(textScaleFactor),
      notificationsEnabled: Value(notificationsEnabled),
      setupWizardCompleted: Value(setupWizardCompleted),
      onboardingCompleted: Value(onboardingCompleted),
      postcode: postcode == null && nullToAbsent
          ? const Value.absent()
          : Value(postcode),
      locationLatitude: locationLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLatitude),
      locationLongitude: locationLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLongitude),
      whatsAppNumber: whatsAppNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsAppNumber),
      whatsAppEnabled: Value(whatsAppEnabled),
      emailAddress: emailAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(emailAddress),
      emailEnabled: Value(emailEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreferencesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferencesTableData(
      id: serializer.fromJson<int>(json['id']),
      wakeTime: serializer.fromJson<String>(json['wakeTime']),
      sleepTime: serializer.fromJson<String>(json['sleepTime']),
      jobStartTime: serializer.fromJson<String>(json['jobStartTime']),
      jobEndTime: serializer.fromJson<String>(json['jobEndTime']),
      weekendWakeTime: serializer.fromJson<String>(json['weekendWakeTime']),
      daysOffJson: serializer.fromJson<String>(json['daysOffJson']),
      homeTimezone: serializer.fromJson<String>(json['homeTimezone']),
      homeLocationKeysJson:
          serializer.fromJson<String>(json['homeLocationKeysJson']),
      customLocationNamesJson:
          serializer.fromJson<String>(json['customLocationNamesJson']),
      householdAgeGroupsJson:
          serializer.fromJson<String>(json['householdAgeGroupsJson']),
      vehiclesJson: serializer.fromJson<String>(json['vehiclesJson']),
      petsJson: serializer.fromJson<String>(json['petsJson']),
      themeId: serializer.fromJson<String>(json['themeId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      textScaleFactor: serializer.fromJson<double>(json['textScaleFactor']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      setupWizardCompleted:
          serializer.fromJson<bool>(json['setupWizardCompleted']),
      onboardingCompleted:
          serializer.fromJson<bool>(json['onboardingCompleted']),
      postcode: serializer.fromJson<String?>(json['postcode']),
      locationLatitude: serializer.fromJson<double?>(json['locationLatitude']),
      locationLongitude:
          serializer.fromJson<double?>(json['locationLongitude']),
      whatsAppNumber: serializer.fromJson<String?>(json['whatsAppNumber']),
      whatsAppEnabled: serializer.fromJson<bool>(json['whatsAppEnabled']),
      emailAddress: serializer.fromJson<String?>(json['emailAddress']),
      emailEnabled: serializer.fromJson<bool>(json['emailEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wakeTime': serializer.toJson<String>(wakeTime),
      'sleepTime': serializer.toJson<String>(sleepTime),
      'jobStartTime': serializer.toJson<String>(jobStartTime),
      'jobEndTime': serializer.toJson<String>(jobEndTime),
      'weekendWakeTime': serializer.toJson<String>(weekendWakeTime),
      'daysOffJson': serializer.toJson<String>(daysOffJson),
      'homeTimezone': serializer.toJson<String>(homeTimezone),
      'homeLocationKeysJson': serializer.toJson<String>(homeLocationKeysJson),
      'customLocationNamesJson':
          serializer.toJson<String>(customLocationNamesJson),
      'householdAgeGroupsJson':
          serializer.toJson<String>(householdAgeGroupsJson),
      'vehiclesJson': serializer.toJson<String>(vehiclesJson),
      'petsJson': serializer.toJson<String>(petsJson),
      'themeId': serializer.toJson<String>(themeId),
      'languageCode': serializer.toJson<String>(languageCode),
      'textScaleFactor': serializer.toJson<double>(textScaleFactor),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'setupWizardCompleted': serializer.toJson<bool>(setupWizardCompleted),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'postcode': serializer.toJson<String?>(postcode),
      'locationLatitude': serializer.toJson<double?>(locationLatitude),
      'locationLongitude': serializer.toJson<double?>(locationLongitude),
      'whatsAppNumber': serializer.toJson<String?>(whatsAppNumber),
      'whatsAppEnabled': serializer.toJson<bool>(whatsAppEnabled),
      'emailAddress': serializer.toJson<String?>(emailAddress),
      'emailEnabled': serializer.toJson<bool>(emailEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreferencesTableData copyWith(
          {int? id,
          String? wakeTime,
          String? sleepTime,
          String? jobStartTime,
          String? jobEndTime,
          String? weekendWakeTime,
          String? daysOffJson,
          String? homeTimezone,
          String? homeLocationKeysJson,
          String? customLocationNamesJson,
          String? householdAgeGroupsJson,
          String? vehiclesJson,
          String? petsJson,
          String? themeId,
          String? languageCode,
          double? textScaleFactor,
          bool? notificationsEnabled,
          bool? setupWizardCompleted,
          bool? onboardingCompleted,
          Value<String?> postcode = const Value.absent(),
          Value<double?> locationLatitude = const Value.absent(),
          Value<double?> locationLongitude = const Value.absent(),
          Value<String?> whatsAppNumber = const Value.absent(),
          bool? whatsAppEnabled,
          Value<String?> emailAddress = const Value.absent(),
          bool? emailEnabled,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserPreferencesTableData(
        id: id ?? this.id,
        wakeTime: wakeTime ?? this.wakeTime,
        sleepTime: sleepTime ?? this.sleepTime,
        jobStartTime: jobStartTime ?? this.jobStartTime,
        jobEndTime: jobEndTime ?? this.jobEndTime,
        weekendWakeTime: weekendWakeTime ?? this.weekendWakeTime,
        daysOffJson: daysOffJson ?? this.daysOffJson,
        homeTimezone: homeTimezone ?? this.homeTimezone,
        homeLocationKeysJson: homeLocationKeysJson ?? this.homeLocationKeysJson,
        customLocationNamesJson:
            customLocationNamesJson ?? this.customLocationNamesJson,
        householdAgeGroupsJson:
            householdAgeGroupsJson ?? this.householdAgeGroupsJson,
        vehiclesJson: vehiclesJson ?? this.vehiclesJson,
        petsJson: petsJson ?? this.petsJson,
        themeId: themeId ?? this.themeId,
        languageCode: languageCode ?? this.languageCode,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        setupWizardCompleted: setupWizardCompleted ?? this.setupWizardCompleted,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
        postcode: postcode.present ? postcode.value : this.postcode,
        locationLatitude: locationLatitude.present
            ? locationLatitude.value
            : this.locationLatitude,
        locationLongitude: locationLongitude.present
            ? locationLongitude.value
            : this.locationLongitude,
        whatsAppNumber:
            whatsAppNumber.present ? whatsAppNumber.value : this.whatsAppNumber,
        whatsAppEnabled: whatsAppEnabled ?? this.whatsAppEnabled,
        emailAddress:
            emailAddress.present ? emailAddress.value : this.emailAddress,
        emailEnabled: emailEnabled ?? this.emailEnabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserPreferencesTableData copyWithCompanion(
      UserPreferencesTableCompanion data) {
    return UserPreferencesTableData(
      id: data.id.present ? data.id.value : this.id,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      sleepTime: data.sleepTime.present ? data.sleepTime.value : this.sleepTime,
      jobStartTime: data.jobStartTime.present
          ? data.jobStartTime.value
          : this.jobStartTime,
      jobEndTime:
          data.jobEndTime.present ? data.jobEndTime.value : this.jobEndTime,
      weekendWakeTime: data.weekendWakeTime.present
          ? data.weekendWakeTime.value
          : this.weekendWakeTime,
      daysOffJson:
          data.daysOffJson.present ? data.daysOffJson.value : this.daysOffJson,
      homeTimezone: data.homeTimezone.present
          ? data.homeTimezone.value
          : this.homeTimezone,
      homeLocationKeysJson: data.homeLocationKeysJson.present
          ? data.homeLocationKeysJson.value
          : this.homeLocationKeysJson,
      customLocationNamesJson: data.customLocationNamesJson.present
          ? data.customLocationNamesJson.value
          : this.customLocationNamesJson,
      householdAgeGroupsJson: data.householdAgeGroupsJson.present
          ? data.householdAgeGroupsJson.value
          : this.householdAgeGroupsJson,
      vehiclesJson: data.vehiclesJson.present
          ? data.vehiclesJson.value
          : this.vehiclesJson,
      petsJson: data.petsJson.present ? data.petsJson.value : this.petsJson,
      themeId: data.themeId.present ? data.themeId.value : this.themeId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      textScaleFactor: data.textScaleFactor.present
          ? data.textScaleFactor.value
          : this.textScaleFactor,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      setupWizardCompleted: data.setupWizardCompleted.present
          ? data.setupWizardCompleted.value
          : this.setupWizardCompleted,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      postcode: data.postcode.present ? data.postcode.value : this.postcode,
      locationLatitude: data.locationLatitude.present
          ? data.locationLatitude.value
          : this.locationLatitude,
      locationLongitude: data.locationLongitude.present
          ? data.locationLongitude.value
          : this.locationLongitude,
      whatsAppNumber: data.whatsAppNumber.present
          ? data.whatsAppNumber.value
          : this.whatsAppNumber,
      whatsAppEnabled: data.whatsAppEnabled.present
          ? data.whatsAppEnabled.value
          : this.whatsAppEnabled,
      emailAddress: data.emailAddress.present
          ? data.emailAddress.value
          : this.emailAddress,
      emailEnabled: data.emailEnabled.present
          ? data.emailEnabled.value
          : this.emailEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableData(')
          ..write('id: $id, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('sleepTime: $sleepTime, ')
          ..write('jobStartTime: $jobStartTime, ')
          ..write('jobEndTime: $jobEndTime, ')
          ..write('weekendWakeTime: $weekendWakeTime, ')
          ..write('daysOffJson: $daysOffJson, ')
          ..write('homeTimezone: $homeTimezone, ')
          ..write('homeLocationKeysJson: $homeLocationKeysJson, ')
          ..write('customLocationNamesJson: $customLocationNamesJson, ')
          ..write('householdAgeGroupsJson: $householdAgeGroupsJson, ')
          ..write('vehiclesJson: $vehiclesJson, ')
          ..write('petsJson: $petsJson, ')
          ..write('themeId: $themeId, ')
          ..write('languageCode: $languageCode, ')
          ..write('textScaleFactor: $textScaleFactor, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('setupWizardCompleted: $setupWizardCompleted, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('postcode: $postcode, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('whatsAppNumber: $whatsAppNumber, ')
          ..write('whatsAppEnabled: $whatsAppEnabled, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('emailEnabled: $emailEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        wakeTime,
        sleepTime,
        jobStartTime,
        jobEndTime,
        weekendWakeTime,
        daysOffJson,
        homeTimezone,
        homeLocationKeysJson,
        customLocationNamesJson,
        householdAgeGroupsJson,
        vehiclesJson,
        petsJson,
        themeId,
        languageCode,
        textScaleFactor,
        notificationsEnabled,
        setupWizardCompleted,
        onboardingCompleted,
        postcode,
        locationLatitude,
        locationLongitude,
        whatsAppNumber,
        whatsAppEnabled,
        emailAddress,
        emailEnabled,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferencesTableData &&
          other.id == this.id &&
          other.wakeTime == this.wakeTime &&
          other.sleepTime == this.sleepTime &&
          other.jobStartTime == this.jobStartTime &&
          other.jobEndTime == this.jobEndTime &&
          other.weekendWakeTime == this.weekendWakeTime &&
          other.daysOffJson == this.daysOffJson &&
          other.homeTimezone == this.homeTimezone &&
          other.homeLocationKeysJson == this.homeLocationKeysJson &&
          other.customLocationNamesJson == this.customLocationNamesJson &&
          other.householdAgeGroupsJson == this.householdAgeGroupsJson &&
          other.vehiclesJson == this.vehiclesJson &&
          other.petsJson == this.petsJson &&
          other.themeId == this.themeId &&
          other.languageCode == this.languageCode &&
          other.textScaleFactor == this.textScaleFactor &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.setupWizardCompleted == this.setupWizardCompleted &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.postcode == this.postcode &&
          other.locationLatitude == this.locationLatitude &&
          other.locationLongitude == this.locationLongitude &&
          other.whatsAppNumber == this.whatsAppNumber &&
          other.whatsAppEnabled == this.whatsAppEnabled &&
          other.emailAddress == this.emailAddress &&
          other.emailEnabled == this.emailEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesTableCompanion
    extends UpdateCompanion<UserPreferencesTableData> {
  final Value<int> id;
  final Value<String> wakeTime;
  final Value<String> sleepTime;
  final Value<String> jobStartTime;
  final Value<String> jobEndTime;
  final Value<String> weekendWakeTime;
  final Value<String> daysOffJson;
  final Value<String> homeTimezone;
  final Value<String> homeLocationKeysJson;
  final Value<String> customLocationNamesJson;
  final Value<String> householdAgeGroupsJson;
  final Value<String> vehiclesJson;
  final Value<String> petsJson;
  final Value<String> themeId;
  final Value<String> languageCode;
  final Value<double> textScaleFactor;
  final Value<bool> notificationsEnabled;
  final Value<bool> setupWizardCompleted;
  final Value<bool> onboardingCompleted;
  final Value<String?> postcode;
  final Value<double?> locationLatitude;
  final Value<double?> locationLongitude;
  final Value<String?> whatsAppNumber;
  final Value<bool> whatsAppEnabled;
  final Value<String?> emailAddress;
  final Value<bool> emailEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserPreferencesTableCompanion({
    this.id = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.sleepTime = const Value.absent(),
    this.jobStartTime = const Value.absent(),
    this.jobEndTime = const Value.absent(),
    this.weekendWakeTime = const Value.absent(),
    this.daysOffJson = const Value.absent(),
    this.homeTimezone = const Value.absent(),
    this.homeLocationKeysJson = const Value.absent(),
    this.customLocationNamesJson = const Value.absent(),
    this.householdAgeGroupsJson = const Value.absent(),
    this.vehiclesJson = const Value.absent(),
    this.petsJson = const Value.absent(),
    this.themeId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.textScaleFactor = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.setupWizardCompleted = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.postcode = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.whatsAppNumber = const Value.absent(),
    this.whatsAppEnabled = const Value.absent(),
    this.emailAddress = const Value.absent(),
    this.emailEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.sleepTime = const Value.absent(),
    this.jobStartTime = const Value.absent(),
    this.jobEndTime = const Value.absent(),
    this.weekendWakeTime = const Value.absent(),
    this.daysOffJson = const Value.absent(),
    this.homeTimezone = const Value.absent(),
    this.homeLocationKeysJson = const Value.absent(),
    this.customLocationNamesJson = const Value.absent(),
    this.householdAgeGroupsJson = const Value.absent(),
    this.vehiclesJson = const Value.absent(),
    this.petsJson = const Value.absent(),
    this.themeId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.textScaleFactor = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.setupWizardCompleted = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.postcode = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.whatsAppNumber = const Value.absent(),
    this.whatsAppEnabled = const Value.absent(),
    this.emailAddress = const Value.absent(),
    this.emailEnabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UserPreferencesTableData> custom({
    Expression<int>? id,
    Expression<String>? wakeTime,
    Expression<String>? sleepTime,
    Expression<String>? jobStartTime,
    Expression<String>? jobEndTime,
    Expression<String>? weekendWakeTime,
    Expression<String>? daysOffJson,
    Expression<String>? homeTimezone,
    Expression<String>? homeLocationKeysJson,
    Expression<String>? customLocationNamesJson,
    Expression<String>? householdAgeGroupsJson,
    Expression<String>? vehiclesJson,
    Expression<String>? petsJson,
    Expression<String>? themeId,
    Expression<String>? languageCode,
    Expression<double>? textScaleFactor,
    Expression<bool>? notificationsEnabled,
    Expression<bool>? setupWizardCompleted,
    Expression<bool>? onboardingCompleted,
    Expression<String>? postcode,
    Expression<double>? locationLatitude,
    Expression<double>? locationLongitude,
    Expression<String>? whatsAppNumber,
    Expression<bool>? whatsAppEnabled,
    Expression<String>? emailAddress,
    Expression<bool>? emailEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (sleepTime != null) 'sleep_time': sleepTime,
      if (jobStartTime != null) 'job_start_time': jobStartTime,
      if (jobEndTime != null) 'job_end_time': jobEndTime,
      if (weekendWakeTime != null) 'weekend_wake_time': weekendWakeTime,
      if (daysOffJson != null) 'days_off_json': daysOffJson,
      if (homeTimezone != null) 'home_timezone': homeTimezone,
      if (homeLocationKeysJson != null)
        'home_location_keys_json': homeLocationKeysJson,
      if (customLocationNamesJson != null)
        'custom_location_names_json': customLocationNamesJson,
      if (householdAgeGroupsJson != null)
        'household_age_groups_json': householdAgeGroupsJson,
      if (vehiclesJson != null) 'vehicles_json': vehiclesJson,
      if (petsJson != null) 'pets_json': petsJson,
      if (themeId != null) 'theme_id': themeId,
      if (languageCode != null) 'language_code': languageCode,
      if (textScaleFactor != null) 'text_scale_factor': textScaleFactor,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (setupWizardCompleted != null)
        'setup_wizard_completed': setupWizardCompleted,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (postcode != null) 'postcode': postcode,
      if (locationLatitude != null) 'location_latitude': locationLatitude,
      if (locationLongitude != null) 'location_longitude': locationLongitude,
      if (whatsAppNumber != null) 'whats_app_number': whatsAppNumber,
      if (whatsAppEnabled != null) 'whats_app_enabled': whatsAppEnabled,
      if (emailAddress != null) 'email_address': emailAddress,
      if (emailEnabled != null) 'email_enabled': emailEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPreferencesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? wakeTime,
      Value<String>? sleepTime,
      Value<String>? jobStartTime,
      Value<String>? jobEndTime,
      Value<String>? weekendWakeTime,
      Value<String>? daysOffJson,
      Value<String>? homeTimezone,
      Value<String>? homeLocationKeysJson,
      Value<String>? customLocationNamesJson,
      Value<String>? householdAgeGroupsJson,
      Value<String>? vehiclesJson,
      Value<String>? petsJson,
      Value<String>? themeId,
      Value<String>? languageCode,
      Value<double>? textScaleFactor,
      Value<bool>? notificationsEnabled,
      Value<bool>? setupWizardCompleted,
      Value<bool>? onboardingCompleted,
      Value<String?>? postcode,
      Value<double?>? locationLatitude,
      Value<double?>? locationLongitude,
      Value<String?>? whatsAppNumber,
      Value<bool>? whatsAppEnabled,
      Value<String?>? emailAddress,
      Value<bool>? emailEnabled,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserPreferencesTableCompanion(
      id: id ?? this.id,
      wakeTime: wakeTime ?? this.wakeTime,
      sleepTime: sleepTime ?? this.sleepTime,
      jobStartTime: jobStartTime ?? this.jobStartTime,
      jobEndTime: jobEndTime ?? this.jobEndTime,
      weekendWakeTime: weekendWakeTime ?? this.weekendWakeTime,
      daysOffJson: daysOffJson ?? this.daysOffJson,
      homeTimezone: homeTimezone ?? this.homeTimezone,
      homeLocationKeysJson: homeLocationKeysJson ?? this.homeLocationKeysJson,
      customLocationNamesJson:
          customLocationNamesJson ?? this.customLocationNamesJson,
      householdAgeGroupsJson:
          householdAgeGroupsJson ?? this.householdAgeGroupsJson,
      vehiclesJson: vehiclesJson ?? this.vehiclesJson,
      petsJson: petsJson ?? this.petsJson,
      themeId: themeId ?? this.themeId,
      languageCode: languageCode ?? this.languageCode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      setupWizardCompleted: setupWizardCompleted ?? this.setupWizardCompleted,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      postcode: postcode ?? this.postcode,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
      whatsAppEnabled: whatsAppEnabled ?? this.whatsAppEnabled,
      emailAddress: emailAddress ?? this.emailAddress,
      emailEnabled: emailEnabled ?? this.emailEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<String>(wakeTime.value);
    }
    if (sleepTime.present) {
      map['sleep_time'] = Variable<String>(sleepTime.value);
    }
    if (jobStartTime.present) {
      map['job_start_time'] = Variable<String>(jobStartTime.value);
    }
    if (jobEndTime.present) {
      map['job_end_time'] = Variable<String>(jobEndTime.value);
    }
    if (weekendWakeTime.present) {
      map['weekend_wake_time'] = Variable<String>(weekendWakeTime.value);
    }
    if (daysOffJson.present) {
      map['days_off_json'] = Variable<String>(daysOffJson.value);
    }
    if (homeTimezone.present) {
      map['home_timezone'] = Variable<String>(homeTimezone.value);
    }
    if (homeLocationKeysJson.present) {
      map['home_location_keys_json'] =
          Variable<String>(homeLocationKeysJson.value);
    }
    if (customLocationNamesJson.present) {
      map['custom_location_names_json'] =
          Variable<String>(customLocationNamesJson.value);
    }
    if (householdAgeGroupsJson.present) {
      map['household_age_groups_json'] =
          Variable<String>(householdAgeGroupsJson.value);
    }
    if (vehiclesJson.present) {
      map['vehicles_json'] = Variable<String>(vehiclesJson.value);
    }
    if (petsJson.present) {
      map['pets_json'] = Variable<String>(petsJson.value);
    }
    if (themeId.present) {
      map['theme_id'] = Variable<String>(themeId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (textScaleFactor.present) {
      map['text_scale_factor'] = Variable<double>(textScaleFactor.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (setupWizardCompleted.present) {
      map['setup_wizard_completed'] =
          Variable<bool>(setupWizardCompleted.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (postcode.present) {
      map['postcode'] = Variable<String>(postcode.value);
    }
    if (locationLatitude.present) {
      map['location_latitude'] = Variable<double>(locationLatitude.value);
    }
    if (locationLongitude.present) {
      map['location_longitude'] = Variable<double>(locationLongitude.value);
    }
    if (whatsAppNumber.present) {
      map['whats_app_number'] = Variable<String>(whatsAppNumber.value);
    }
    if (whatsAppEnabled.present) {
      map['whats_app_enabled'] = Variable<bool>(whatsAppEnabled.value);
    }
    if (emailAddress.present) {
      map['email_address'] = Variable<String>(emailAddress.value);
    }
    if (emailEnabled.present) {
      map['email_enabled'] = Variable<bool>(emailEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('sleepTime: $sleepTime, ')
          ..write('jobStartTime: $jobStartTime, ')
          ..write('jobEndTime: $jobEndTime, ')
          ..write('weekendWakeTime: $weekendWakeTime, ')
          ..write('daysOffJson: $daysOffJson, ')
          ..write('homeTimezone: $homeTimezone, ')
          ..write('homeLocationKeysJson: $homeLocationKeysJson, ')
          ..write('customLocationNamesJson: $customLocationNamesJson, ')
          ..write('householdAgeGroupsJson: $householdAgeGroupsJson, ')
          ..write('vehiclesJson: $vehiclesJson, ')
          ..write('petsJson: $petsJson, ')
          ..write('themeId: $themeId, ')
          ..write('languageCode: $languageCode, ')
          ..write('textScaleFactor: $textScaleFactor, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('setupWizardCompleted: $setupWizardCompleted, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('postcode: $postcode, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('whatsAppNumber: $whatsAppNumber, ')
          ..write('whatsAppEnabled: $whatsAppEnabled, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('emailEnabled: $emailEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedTasksTableTable savedTasksTable =
      $SavedTasksTableTable(this);
  late final $UserPreferencesTableTable userPreferencesTable =
      $UserPreferencesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [savedTasksTable, userPreferencesTable];
}

typedef $$SavedTasksTableTableCreateCompanionBuilder = SavedTasksTableCompanion
    Function({
  Value<int> id,
  required String taskConfigId,
  required String categoryId,
  required String source,
  Value<String?> taskNameKey,
  Value<String?> taskNameOverride,
  Value<String?> customTitle,
  required String repeatOption,
  required String scheduledTimesJson,
  required String scheduledWeekdaysJson,
  Value<int?> scheduledYearlyDateMs,
  required String scheduledYearlyDatesJson,
  Value<String?> monthlyMode,
  Value<int?> monthlySpecificDate,
  Value<String?> monthlyShortMonthFallback,
  required String reminderMinutesJson,
  Value<bool> channelApp,
  Value<bool> channelAlarm,
  Value<bool> channelEmail,
  Value<bool> channelWhatsApp,
  Value<String?> locationKey,
  Value<String?> customLocationName,
  Value<String?> linkedTaskConfigId,
  Value<String?> groupId,
  Value<int> pointsPerCompletion,
  required String homeTimezone,
  required String systemTimezoneAtCreation,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> isArchived,
  Value<String?> apiResponseJson,
});
typedef $$SavedTasksTableTableUpdateCompanionBuilder = SavedTasksTableCompanion
    Function({
  Value<int> id,
  Value<String> taskConfigId,
  Value<String> categoryId,
  Value<String> source,
  Value<String?> taskNameKey,
  Value<String?> taskNameOverride,
  Value<String?> customTitle,
  Value<String> repeatOption,
  Value<String> scheduledTimesJson,
  Value<String> scheduledWeekdaysJson,
  Value<int?> scheduledYearlyDateMs,
  Value<String> scheduledYearlyDatesJson,
  Value<String?> monthlyMode,
  Value<int?> monthlySpecificDate,
  Value<String?> monthlyShortMonthFallback,
  Value<String> reminderMinutesJson,
  Value<bool> channelApp,
  Value<bool> channelAlarm,
  Value<bool> channelEmail,
  Value<bool> channelWhatsApp,
  Value<String?> locationKey,
  Value<String?> customLocationName,
  Value<String?> linkedTaskConfigId,
  Value<String?> groupId,
  Value<int> pointsPerCompletion,
  Value<String> homeTimezone,
  Value<String> systemTimezoneAtCreation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isArchived,
  Value<String?> apiResponseJson,
});

class $$SavedTasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavedTasksTableTable> {
  $$SavedTasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskConfigId => $composableBuilder(
      column: $table.taskConfigId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskNameKey => $composableBuilder(
      column: $table.taskNameKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskNameOverride => $composableBuilder(
      column: $table.taskNameOverride,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customTitle => $composableBuilder(
      column: $table.customTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repeatOption => $composableBuilder(
      column: $table.repeatOption, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduledTimesJson => $composableBuilder(
      column: $table.scheduledTimesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduledWeekdaysJson => $composableBuilder(
      column: $table.scheduledWeekdaysJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scheduledYearlyDateMs => $composableBuilder(
      column: $table.scheduledYearlyDateMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduledYearlyDatesJson => $composableBuilder(
      column: $table.scheduledYearlyDatesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get monthlyMode => $composableBuilder(
      column: $table.monthlyMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlySpecificDate => $composableBuilder(
      column: $table.monthlySpecificDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get monthlyShortMonthFallback => $composableBuilder(
      column: $table.monthlyShortMonthFallback,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderMinutesJson => $composableBuilder(
      column: $table.reminderMinutesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get channelApp => $composableBuilder(
      column: $table.channelApp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get channelAlarm => $composableBuilder(
      column: $table.channelAlarm, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get channelEmail => $composableBuilder(
      column: $table.channelEmail, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get channelWhatsApp => $composableBuilder(
      column: $table.channelWhatsApp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationKey => $composableBuilder(
      column: $table.locationKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customLocationName => $composableBuilder(
      column: $table.customLocationName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedTaskConfigId => $composableBuilder(
      column: $table.linkedTaskConfigId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pointsPerCompletion => $composableBuilder(
      column: $table.pointsPerCompletion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get homeTimezone => $composableBuilder(
      column: $table.homeTimezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get systemTimezoneAtCreation => $composableBuilder(
      column: $table.systemTimezoneAtCreation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apiResponseJson => $composableBuilder(
      column: $table.apiResponseJson,
      builder: (column) => ColumnFilters(column));
}

class $$SavedTasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedTasksTableTable> {
  $$SavedTasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskConfigId => $composableBuilder(
      column: $table.taskConfigId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskNameKey => $composableBuilder(
      column: $table.taskNameKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskNameOverride => $composableBuilder(
      column: $table.taskNameOverride,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customTitle => $composableBuilder(
      column: $table.customTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repeatOption => $composableBuilder(
      column: $table.repeatOption,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduledTimesJson => $composableBuilder(
      column: $table.scheduledTimesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduledWeekdaysJson => $composableBuilder(
      column: $table.scheduledWeekdaysJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduledYearlyDateMs => $composableBuilder(
      column: $table.scheduledYearlyDateMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduledYearlyDatesJson => $composableBuilder(
      column: $table.scheduledYearlyDatesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get monthlyMode => $composableBuilder(
      column: $table.monthlyMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlySpecificDate => $composableBuilder(
      column: $table.monthlySpecificDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get monthlyShortMonthFallback => $composableBuilder(
      column: $table.monthlyShortMonthFallback,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderMinutesJson => $composableBuilder(
      column: $table.reminderMinutesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get channelApp => $composableBuilder(
      column: $table.channelApp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get channelAlarm => $composableBuilder(
      column: $table.channelAlarm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get channelEmail => $composableBuilder(
      column: $table.channelEmail,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get channelWhatsApp => $composableBuilder(
      column: $table.channelWhatsApp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationKey => $composableBuilder(
      column: $table.locationKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customLocationName => $composableBuilder(
      column: $table.customLocationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedTaskConfigId => $composableBuilder(
      column: $table.linkedTaskConfigId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pointsPerCompletion => $composableBuilder(
      column: $table.pointsPerCompletion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get homeTimezone => $composableBuilder(
      column: $table.homeTimezone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get systemTimezoneAtCreation => $composableBuilder(
      column: $table.systemTimezoneAtCreation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apiResponseJson => $composableBuilder(
      column: $table.apiResponseJson,
      builder: (column) => ColumnOrderings(column));
}

class $$SavedTasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedTasksTableTable> {
  $$SavedTasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskConfigId => $composableBuilder(
      column: $table.taskConfigId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get taskNameKey => $composableBuilder(
      column: $table.taskNameKey, builder: (column) => column);

  GeneratedColumn<String> get taskNameOverride => $composableBuilder(
      column: $table.taskNameOverride, builder: (column) => column);

  GeneratedColumn<String> get customTitle => $composableBuilder(
      column: $table.customTitle, builder: (column) => column);

  GeneratedColumn<String> get repeatOption => $composableBuilder(
      column: $table.repeatOption, builder: (column) => column);

  GeneratedColumn<String> get scheduledTimesJson => $composableBuilder(
      column: $table.scheduledTimesJson, builder: (column) => column);

  GeneratedColumn<String> get scheduledWeekdaysJson => $composableBuilder(
      column: $table.scheduledWeekdaysJson, builder: (column) => column);

  GeneratedColumn<int> get scheduledYearlyDateMs => $composableBuilder(
      column: $table.scheduledYearlyDateMs, builder: (column) => column);

  GeneratedColumn<String> get scheduledYearlyDatesJson => $composableBuilder(
      column: $table.scheduledYearlyDatesJson, builder: (column) => column);

  GeneratedColumn<String> get monthlyMode => $composableBuilder(
      column: $table.monthlyMode, builder: (column) => column);

  GeneratedColumn<int> get monthlySpecificDate => $composableBuilder(
      column: $table.monthlySpecificDate, builder: (column) => column);

  GeneratedColumn<String> get monthlyShortMonthFallback => $composableBuilder(
      column: $table.monthlyShortMonthFallback, builder: (column) => column);

  GeneratedColumn<String> get reminderMinutesJson => $composableBuilder(
      column: $table.reminderMinutesJson, builder: (column) => column);

  GeneratedColumn<bool> get channelApp => $composableBuilder(
      column: $table.channelApp, builder: (column) => column);

  GeneratedColumn<bool> get channelAlarm => $composableBuilder(
      column: $table.channelAlarm, builder: (column) => column);

  GeneratedColumn<bool> get channelEmail => $composableBuilder(
      column: $table.channelEmail, builder: (column) => column);

  GeneratedColumn<bool> get channelWhatsApp => $composableBuilder(
      column: $table.channelWhatsApp, builder: (column) => column);

  GeneratedColumn<String> get locationKey => $composableBuilder(
      column: $table.locationKey, builder: (column) => column);

  GeneratedColumn<String> get customLocationName => $composableBuilder(
      column: $table.customLocationName, builder: (column) => column);

  GeneratedColumn<String> get linkedTaskConfigId => $composableBuilder(
      column: $table.linkedTaskConfigId, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<int> get pointsPerCompletion => $composableBuilder(
      column: $table.pointsPerCompletion, builder: (column) => column);

  GeneratedColumn<String> get homeTimezone => $composableBuilder(
      column: $table.homeTimezone, builder: (column) => column);

  GeneratedColumn<String> get systemTimezoneAtCreation => $composableBuilder(
      column: $table.systemTimezoneAtCreation, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<String> get apiResponseJson => $composableBuilder(
      column: $table.apiResponseJson, builder: (column) => column);
}

class $$SavedTasksTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedTasksTableTable,
    SavedTasksTableData,
    $$SavedTasksTableTableFilterComposer,
    $$SavedTasksTableTableOrderingComposer,
    $$SavedTasksTableTableAnnotationComposer,
    $$SavedTasksTableTableCreateCompanionBuilder,
    $$SavedTasksTableTableUpdateCompanionBuilder,
    (
      SavedTasksTableData,
      BaseReferences<_$AppDatabase, $SavedTasksTableTable, SavedTasksTableData>
    ),
    SavedTasksTableData,
    PrefetchHooks Function()> {
  $$SavedTasksTableTableTableManager(
      _$AppDatabase db, $SavedTasksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedTasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedTasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedTasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> taskConfigId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> taskNameKey = const Value.absent(),
            Value<String?> taskNameOverride = const Value.absent(),
            Value<String?> customTitle = const Value.absent(),
            Value<String> repeatOption = const Value.absent(),
            Value<String> scheduledTimesJson = const Value.absent(),
            Value<String> scheduledWeekdaysJson = const Value.absent(),
            Value<int?> scheduledYearlyDateMs = const Value.absent(),
            Value<String> scheduledYearlyDatesJson = const Value.absent(),
            Value<String?> monthlyMode = const Value.absent(),
            Value<int?> monthlySpecificDate = const Value.absent(),
            Value<String?> monthlyShortMonthFallback = const Value.absent(),
            Value<String> reminderMinutesJson = const Value.absent(),
            Value<bool> channelApp = const Value.absent(),
            Value<bool> channelAlarm = const Value.absent(),
            Value<bool> channelEmail = const Value.absent(),
            Value<bool> channelWhatsApp = const Value.absent(),
            Value<String?> locationKey = const Value.absent(),
            Value<String?> customLocationName = const Value.absent(),
            Value<String?> linkedTaskConfigId = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            Value<int> pointsPerCompletion = const Value.absent(),
            Value<String> homeTimezone = const Value.absent(),
            Value<String> systemTimezoneAtCreation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<String?> apiResponseJson = const Value.absent(),
          }) =>
              SavedTasksTableCompanion(
            id: id,
            taskConfigId: taskConfigId,
            categoryId: categoryId,
            source: source,
            taskNameKey: taskNameKey,
            taskNameOverride: taskNameOverride,
            customTitle: customTitle,
            repeatOption: repeatOption,
            scheduledTimesJson: scheduledTimesJson,
            scheduledWeekdaysJson: scheduledWeekdaysJson,
            scheduledYearlyDateMs: scheduledYearlyDateMs,
            scheduledYearlyDatesJson: scheduledYearlyDatesJson,
            monthlyMode: monthlyMode,
            monthlySpecificDate: monthlySpecificDate,
            monthlyShortMonthFallback: monthlyShortMonthFallback,
            reminderMinutesJson: reminderMinutesJson,
            channelApp: channelApp,
            channelAlarm: channelAlarm,
            channelEmail: channelEmail,
            channelWhatsApp: channelWhatsApp,
            locationKey: locationKey,
            customLocationName: customLocationName,
            linkedTaskConfigId: linkedTaskConfigId,
            groupId: groupId,
            pointsPerCompletion: pointsPerCompletion,
            homeTimezone: homeTimezone,
            systemTimezoneAtCreation: systemTimezoneAtCreation,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            apiResponseJson: apiResponseJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String taskConfigId,
            required String categoryId,
            required String source,
            Value<String?> taskNameKey = const Value.absent(),
            Value<String?> taskNameOverride = const Value.absent(),
            Value<String?> customTitle = const Value.absent(),
            required String repeatOption,
            required String scheduledTimesJson,
            required String scheduledWeekdaysJson,
            Value<int?> scheduledYearlyDateMs = const Value.absent(),
            required String scheduledYearlyDatesJson,
            Value<String?> monthlyMode = const Value.absent(),
            Value<int?> monthlySpecificDate = const Value.absent(),
            Value<String?> monthlyShortMonthFallback = const Value.absent(),
            required String reminderMinutesJson,
            Value<bool> channelApp = const Value.absent(),
            Value<bool> channelAlarm = const Value.absent(),
            Value<bool> channelEmail = const Value.absent(),
            Value<bool> channelWhatsApp = const Value.absent(),
            Value<String?> locationKey = const Value.absent(),
            Value<String?> customLocationName = const Value.absent(),
            Value<String?> linkedTaskConfigId = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            Value<int> pointsPerCompletion = const Value.absent(),
            required String homeTimezone,
            required String systemTimezoneAtCreation,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> isArchived = const Value.absent(),
            Value<String?> apiResponseJson = const Value.absent(),
          }) =>
              SavedTasksTableCompanion.insert(
            id: id,
            taskConfigId: taskConfigId,
            categoryId: categoryId,
            source: source,
            taskNameKey: taskNameKey,
            taskNameOverride: taskNameOverride,
            customTitle: customTitle,
            repeatOption: repeatOption,
            scheduledTimesJson: scheduledTimesJson,
            scheduledWeekdaysJson: scheduledWeekdaysJson,
            scheduledYearlyDateMs: scheduledYearlyDateMs,
            scheduledYearlyDatesJson: scheduledYearlyDatesJson,
            monthlyMode: monthlyMode,
            monthlySpecificDate: monthlySpecificDate,
            monthlyShortMonthFallback: monthlyShortMonthFallback,
            reminderMinutesJson: reminderMinutesJson,
            channelApp: channelApp,
            channelAlarm: channelAlarm,
            channelEmail: channelEmail,
            channelWhatsApp: channelWhatsApp,
            locationKey: locationKey,
            customLocationName: customLocationName,
            linkedTaskConfigId: linkedTaskConfigId,
            groupId: groupId,
            pointsPerCompletion: pointsPerCompletion,
            homeTimezone: homeTimezone,
            systemTimezoneAtCreation: systemTimezoneAtCreation,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isArchived: isArchived,
            apiResponseJson: apiResponseJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SavedTasksTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedTasksTableTable,
    SavedTasksTableData,
    $$SavedTasksTableTableFilterComposer,
    $$SavedTasksTableTableOrderingComposer,
    $$SavedTasksTableTableAnnotationComposer,
    $$SavedTasksTableTableCreateCompanionBuilder,
    $$SavedTasksTableTableUpdateCompanionBuilder,
    (
      SavedTasksTableData,
      BaseReferences<_$AppDatabase, $SavedTasksTableTable, SavedTasksTableData>
    ),
    SavedTasksTableData,
    PrefetchHooks Function()>;
typedef $$UserPreferencesTableTableCreateCompanionBuilder
    = UserPreferencesTableCompanion Function({
  Value<int> id,
  Value<String> wakeTime,
  Value<String> sleepTime,
  Value<String> jobStartTime,
  Value<String> jobEndTime,
  Value<String> weekendWakeTime,
  Value<String> daysOffJson,
  Value<String> homeTimezone,
  Value<String> homeLocationKeysJson,
  Value<String> customLocationNamesJson,
  Value<String> householdAgeGroupsJson,
  Value<String> vehiclesJson,
  Value<String> petsJson,
  Value<String> themeId,
  Value<String> languageCode,
  Value<double> textScaleFactor,
  Value<bool> notificationsEnabled,
  Value<bool> setupWizardCompleted,
  Value<bool> onboardingCompleted,
  Value<String?> postcode,
  Value<double?> locationLatitude,
  Value<double?> locationLongitude,
  Value<String?> whatsAppNumber,
  Value<bool> whatsAppEnabled,
  Value<String?> emailAddress,
  Value<bool> emailEnabled,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$UserPreferencesTableTableUpdateCompanionBuilder
    = UserPreferencesTableCompanion Function({
  Value<int> id,
  Value<String> wakeTime,
  Value<String> sleepTime,
  Value<String> jobStartTime,
  Value<String> jobEndTime,
  Value<String> weekendWakeTime,
  Value<String> daysOffJson,
  Value<String> homeTimezone,
  Value<String> homeLocationKeysJson,
  Value<String> customLocationNamesJson,
  Value<String> householdAgeGroupsJson,
  Value<String> vehiclesJson,
  Value<String> petsJson,
  Value<String> themeId,
  Value<String> languageCode,
  Value<double> textScaleFactor,
  Value<bool> notificationsEnabled,
  Value<bool> setupWizardCompleted,
  Value<bool> onboardingCompleted,
  Value<String?> postcode,
  Value<double?> locationLatitude,
  Value<double?> locationLongitude,
  Value<String?> whatsAppNumber,
  Value<bool> whatsAppEnabled,
  Value<String?> emailAddress,
  Value<bool> emailEnabled,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$UserPreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wakeTime => $composableBuilder(
      column: $table.wakeTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sleepTime => $composableBuilder(
      column: $table.sleepTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobStartTime => $composableBuilder(
      column: $table.jobStartTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobEndTime => $composableBuilder(
      column: $table.jobEndTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weekendWakeTime => $composableBuilder(
      column: $table.weekendWakeTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get daysOffJson => $composableBuilder(
      column: $table.daysOffJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get homeTimezone => $composableBuilder(
      column: $table.homeTimezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get homeLocationKeysJson => $composableBuilder(
      column: $table.homeLocationKeysJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customLocationNamesJson => $composableBuilder(
      column: $table.customLocationNamesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdAgeGroupsJson => $composableBuilder(
      column: $table.householdAgeGroupsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vehiclesJson => $composableBuilder(
      column: $table.vehiclesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get petsJson => $composableBuilder(
      column: $table.petsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeId => $composableBuilder(
      column: $table.themeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get textScaleFactor => $composableBuilder(
      column: $table.textScaleFactor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get setupWizardCompleted => $composableBuilder(
      column: $table.setupWizardCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get postcode => $composableBuilder(
      column: $table.postcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLatitude => $composableBuilder(
      column: $table.locationLatitude,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLongitude => $composableBuilder(
      column: $table.locationLongitude,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get whatsAppNumber => $composableBuilder(
      column: $table.whatsAppNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get whatsAppEnabled => $composableBuilder(
      column: $table.whatsAppEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emailAddress => $composableBuilder(
      column: $table.emailAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get emailEnabled => $composableBuilder(
      column: $table.emailEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserPreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wakeTime => $composableBuilder(
      column: $table.wakeTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sleepTime => $composableBuilder(
      column: $table.sleepTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobStartTime => $composableBuilder(
      column: $table.jobStartTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobEndTime => $composableBuilder(
      column: $table.jobEndTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weekendWakeTime => $composableBuilder(
      column: $table.weekendWakeTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get daysOffJson => $composableBuilder(
      column: $table.daysOffJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get homeTimezone => $composableBuilder(
      column: $table.homeTimezone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get homeLocationKeysJson => $composableBuilder(
      column: $table.homeLocationKeysJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customLocationNamesJson => $composableBuilder(
      column: $table.customLocationNamesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdAgeGroupsJson => $composableBuilder(
      column: $table.householdAgeGroupsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vehiclesJson => $composableBuilder(
      column: $table.vehiclesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get petsJson => $composableBuilder(
      column: $table.petsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeId => $composableBuilder(
      column: $table.themeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get textScaleFactor => $composableBuilder(
      column: $table.textScaleFactor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get setupWizardCompleted => $composableBuilder(
      column: $table.setupWizardCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get postcode => $composableBuilder(
      column: $table.postcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLatitude => $composableBuilder(
      column: $table.locationLatitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLongitude => $composableBuilder(
      column: $table.locationLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get whatsAppNumber => $composableBuilder(
      column: $table.whatsAppNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get whatsAppEnabled => $composableBuilder(
      column: $table.whatsAppEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emailAddress => $composableBuilder(
      column: $table.emailAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get emailEnabled => $composableBuilder(
      column: $table.emailEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserPreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<String> get sleepTime =>
      $composableBuilder(column: $table.sleepTime, builder: (column) => column);

  GeneratedColumn<String> get jobStartTime => $composableBuilder(
      column: $table.jobStartTime, builder: (column) => column);

  GeneratedColumn<String> get jobEndTime => $composableBuilder(
      column: $table.jobEndTime, builder: (column) => column);

  GeneratedColumn<String> get weekendWakeTime => $composableBuilder(
      column: $table.weekendWakeTime, builder: (column) => column);

  GeneratedColumn<String> get daysOffJson => $composableBuilder(
      column: $table.daysOffJson, builder: (column) => column);

  GeneratedColumn<String> get homeTimezone => $composableBuilder(
      column: $table.homeTimezone, builder: (column) => column);

  GeneratedColumn<String> get homeLocationKeysJson => $composableBuilder(
      column: $table.homeLocationKeysJson, builder: (column) => column);

  GeneratedColumn<String> get customLocationNamesJson => $composableBuilder(
      column: $table.customLocationNamesJson, builder: (column) => column);

  GeneratedColumn<String> get householdAgeGroupsJson => $composableBuilder(
      column: $table.householdAgeGroupsJson, builder: (column) => column);

  GeneratedColumn<String> get vehiclesJson => $composableBuilder(
      column: $table.vehiclesJson, builder: (column) => column);

  GeneratedColumn<String> get petsJson =>
      $composableBuilder(column: $table.petsJson, builder: (column) => column);

  GeneratedColumn<String> get themeId =>
      $composableBuilder(column: $table.themeId, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<double> get textScaleFactor => $composableBuilder(
      column: $table.textScaleFactor, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<bool> get setupWizardCompleted => $composableBuilder(
      column: $table.setupWizardCompleted, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted, builder: (column) => column);

  GeneratedColumn<String> get postcode =>
      $composableBuilder(column: $table.postcode, builder: (column) => column);

  GeneratedColumn<double> get locationLatitude => $composableBuilder(
      column: $table.locationLatitude, builder: (column) => column);

  GeneratedColumn<double> get locationLongitude => $composableBuilder(
      column: $table.locationLongitude, builder: (column) => column);

  GeneratedColumn<String> get whatsAppNumber => $composableBuilder(
      column: $table.whatsAppNumber, builder: (column) => column);

  GeneratedColumn<bool> get whatsAppEnabled => $composableBuilder(
      column: $table.whatsAppEnabled, builder: (column) => column);

  GeneratedColumn<String> get emailAddress => $composableBuilder(
      column: $table.emailAddress, builder: (column) => column);

  GeneratedColumn<bool> get emailEnabled => $composableBuilder(
      column: $table.emailEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPreferencesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserPreferencesTableTable,
    UserPreferencesTableData,
    $$UserPreferencesTableTableFilterComposer,
    $$UserPreferencesTableTableOrderingComposer,
    $$UserPreferencesTableTableAnnotationComposer,
    $$UserPreferencesTableTableCreateCompanionBuilder,
    $$UserPreferencesTableTableUpdateCompanionBuilder,
    (
      UserPreferencesTableData,
      BaseReferences<_$AppDatabase, $UserPreferencesTableTable,
          UserPreferencesTableData>
    ),
    UserPreferencesTableData,
    PrefetchHooks Function()> {
  $$UserPreferencesTableTableTableManager(
      _$AppDatabase db, $UserPreferencesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> wakeTime = const Value.absent(),
            Value<String> sleepTime = const Value.absent(),
            Value<String> jobStartTime = const Value.absent(),
            Value<String> jobEndTime = const Value.absent(),
            Value<String> weekendWakeTime = const Value.absent(),
            Value<String> daysOffJson = const Value.absent(),
            Value<String> homeTimezone = const Value.absent(),
            Value<String> homeLocationKeysJson = const Value.absent(),
            Value<String> customLocationNamesJson = const Value.absent(),
            Value<String> householdAgeGroupsJson = const Value.absent(),
            Value<String> vehiclesJson = const Value.absent(),
            Value<String> petsJson = const Value.absent(),
            Value<String> themeId = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<double> textScaleFactor = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<bool> setupWizardCompleted = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<String?> postcode = const Value.absent(),
            Value<double?> locationLatitude = const Value.absent(),
            Value<double?> locationLongitude = const Value.absent(),
            Value<String?> whatsAppNumber = const Value.absent(),
            Value<bool> whatsAppEnabled = const Value.absent(),
            Value<String?> emailAddress = const Value.absent(),
            Value<bool> emailEnabled = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserPreferencesTableCompanion(
            id: id,
            wakeTime: wakeTime,
            sleepTime: sleepTime,
            jobStartTime: jobStartTime,
            jobEndTime: jobEndTime,
            weekendWakeTime: weekendWakeTime,
            daysOffJson: daysOffJson,
            homeTimezone: homeTimezone,
            homeLocationKeysJson: homeLocationKeysJson,
            customLocationNamesJson: customLocationNamesJson,
            householdAgeGroupsJson: householdAgeGroupsJson,
            vehiclesJson: vehiclesJson,
            petsJson: petsJson,
            themeId: themeId,
            languageCode: languageCode,
            textScaleFactor: textScaleFactor,
            notificationsEnabled: notificationsEnabled,
            setupWizardCompleted: setupWizardCompleted,
            onboardingCompleted: onboardingCompleted,
            postcode: postcode,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude,
            whatsAppNumber: whatsAppNumber,
            whatsAppEnabled: whatsAppEnabled,
            emailAddress: emailAddress,
            emailEnabled: emailEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> wakeTime = const Value.absent(),
            Value<String> sleepTime = const Value.absent(),
            Value<String> jobStartTime = const Value.absent(),
            Value<String> jobEndTime = const Value.absent(),
            Value<String> weekendWakeTime = const Value.absent(),
            Value<String> daysOffJson = const Value.absent(),
            Value<String> homeTimezone = const Value.absent(),
            Value<String> homeLocationKeysJson = const Value.absent(),
            Value<String> customLocationNamesJson = const Value.absent(),
            Value<String> householdAgeGroupsJson = const Value.absent(),
            Value<String> vehiclesJson = const Value.absent(),
            Value<String> petsJson = const Value.absent(),
            Value<String> themeId = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<double> textScaleFactor = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<bool> setupWizardCompleted = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<String?> postcode = const Value.absent(),
            Value<double?> locationLatitude = const Value.absent(),
            Value<double?> locationLongitude = const Value.absent(),
            Value<String?> whatsAppNumber = const Value.absent(),
            Value<bool> whatsAppEnabled = const Value.absent(),
            Value<String?> emailAddress = const Value.absent(),
            Value<bool> emailEnabled = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              UserPreferencesTableCompanion.insert(
            id: id,
            wakeTime: wakeTime,
            sleepTime: sleepTime,
            jobStartTime: jobStartTime,
            jobEndTime: jobEndTime,
            weekendWakeTime: weekendWakeTime,
            daysOffJson: daysOffJson,
            homeTimezone: homeTimezone,
            homeLocationKeysJson: homeLocationKeysJson,
            customLocationNamesJson: customLocationNamesJson,
            householdAgeGroupsJson: householdAgeGroupsJson,
            vehiclesJson: vehiclesJson,
            petsJson: petsJson,
            themeId: themeId,
            languageCode: languageCode,
            textScaleFactor: textScaleFactor,
            notificationsEnabled: notificationsEnabled,
            setupWizardCompleted: setupWizardCompleted,
            onboardingCompleted: onboardingCompleted,
            postcode: postcode,
            locationLatitude: locationLatitude,
            locationLongitude: locationLongitude,
            whatsAppNumber: whatsAppNumber,
            whatsAppEnabled: whatsAppEnabled,
            emailAddress: emailAddress,
            emailEnabled: emailEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserPreferencesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UserPreferencesTableTable,
        UserPreferencesTableData,
        $$UserPreferencesTableTableFilterComposer,
        $$UserPreferencesTableTableOrderingComposer,
        $$UserPreferencesTableTableAnnotationComposer,
        $$UserPreferencesTableTableCreateCompanionBuilder,
        $$UserPreferencesTableTableUpdateCompanionBuilder,
        (
          UserPreferencesTableData,
          BaseReferences<_$AppDatabase, $UserPreferencesTableTable,
              UserPreferencesTableData>
        ),
        UserPreferencesTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedTasksTableTableTableManager get savedTasksTable =>
      $$SavedTasksTableTableTableManager(_db, _db.savedTasksTable);
  $$UserPreferencesTableTableTableManager get userPreferencesTable =>
      $$UserPreferencesTableTableTableManager(_db, _db.userPreferencesTable);
}
