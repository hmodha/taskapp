import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config_models.dart';
import '../../../core/config/config_resolver.dart';
import '../../../core/data/repositories/preferences_repository.dart';
import '../../../core/theme/midnight_focus_theme.dart';
import '../notifiers/schedule_notifier.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ReminderSection
// ─────────────────────────────────────────────────────────────────────────────

class ReminderSection extends ConsumerWidget {
  const ReminderSection({super.key, required this.taskConfig});
  final TaskConfig taskConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form     = ref.watch(scheduleFormNotifierProvider(taskConfig));
    final notifier = ref.read(scheduleFormNotifierProvider(taskConfig).notifier);
    final resolverAsync = ref.watch(configResolverProvider);

    final options = resolverAsync.maybeWhen(
      data: (r) => r.resolveReminderOptions(taskConfig.reminderOptions),
      orElse: () => taskConfig.reminderOptions?.optionsMinutes ?? [10, 30, 60],
    );

    return _SectionCard(
      title: 'REMIND ME',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // No reminder chip
          _ReminderChip(
            label:      'No reminder',
            isSelected: form.reminderMinutes.isEmpty,
            onTap:      () => notifier.toggleReminder(-1),
            isNone:     true,
          ),
          ...options.map((minutes) => _ReminderChip(
            label:      _reminderLabel(minutes),
            isSelected: form.reminderMinutes.contains(minutes),
            onTap:      () => notifier.toggleReminder(minutes),
          )),
        ],
      ),
    );
  }

  String _reminderLabel(int minutes) {
    if (minutes < 60)  return '$minutes min before';
    if (minutes == 60) return '1 hour before';
    if (minutes < 1440) return '${minutes ~/ 60} hours before';
    if (minutes == 1440) return '1 day before';
    if (minutes == 10080) return '1 week before';
    if (minutes == 43200) return '1 month before';
    return '$minutes min';
  }
}

class _ReminderChip extends StatelessWidget {
  const _ReminderChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isNone = false,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isNone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isNone ? MidnightFocusTheme.surfaceElevated : MidnightFocusTheme.primaryDim)
              : MidnightFocusTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected && !isNone
                ? MidnightFocusTheme.primary
                : MidnightFocusTheme.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily:  'Sora',
            fontSize:    12,
            fontWeight:  FontWeight.w500,
            color: isSelected && !isNone
                ? Colors.white
                : MidnightFocusTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LocationSection
// ─────────────────────────────────────────────────────────────────────────────

class LocationSection extends ConsumerWidget {
  const LocationSection({super.key, required this.taskConfig});
  final TaskConfig taskConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (taskConfig.locations == null || !taskConfig.locations!.enabled) {
      return const SizedBox.shrink();
    }

    final form     = ref.watch(scheduleFormNotifierProvider(taskConfig));
    final notifier = ref.read(scheduleFormNotifierProvider(taskConfig).notifier);
    final resolverAsync  = ref.watch(configResolverProvider);
    final prefsAsync     = ref.watch(userPreferencesProvider);

    // Build effective location keys
    final locationKeys = resolverAsync.maybeWhen(
      data: (resolver) => prefsAsync.maybeWhen(
        data: (prefs) => resolver.resolveLocationKeys(
          locationConfig:    taskConfig.locations,
          userHomeLocationKeys: prefs.homeLocationKeys,
          customLocationKeys:  prefs.customLocationNames
              .map((n) => 'custom.$n')
              .toList(),
        ),
        orElse: () => _fallbackKeys(taskConfig.locations!),
      ),
      orElse: () => _fallbackKeys(taskConfig.locations!),
    );

    return _SectionCard(
      title: 'LOCATION',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // No location chip
              _LocationChip(
                label:      'Whole home',
                isSelected: form.locationKey == null && form.customLocationName == null,
                onTap:      () => notifier.setLocation(null),
              ),
              ...locationKeys.map((key) => _LocationChip(
                label:      _resolveLocationLabel(key),
                isSelected: form.locationKey == key,
                onTap:      () => notifier.setLocation(key),
              )),
            ],
          ),

          // Custom location input
          const SizedBox(height: 12),
          _CustomLocationInput(
            current:  form.customLocationName,
            onSet:    notifier.setCustomLocation,
            onClear:  () => notifier.setLocation(null),
          ),
        ],
      ),
    );
  }

  List<String> _fallbackKeys(LocationConfig config) {
    return config.overrideKeys ?? _hardcodedFallback;
  }

  String _resolveLocationLabel(String key) {
    const labels = {
      'location.living_room':     'Living Room',
      'location.bedroom':         'Bedroom',
      'location.second_bedroom':  'Second Bedroom',
      'location.third_bedroom':   'Third Bedroom',
      'location.bathroom':        'Bathroom',
      'location.ensuite':         'En-suite',
      'location.kitchen':         'Kitchen',
      'location.dining_room':     'Dining Room',
      'location.hallway':         'Hallway',
      'location.landing':         'Landing',
      'location.stairs':          'Stairs',
      'location.home_office':     'Home Office',
      'location.utility_room':    'Utility Room',
      'location.conservatory':    'Conservatory',
      'location.garage':          'Garage',
      'location.garden':          'Garden',
      'location.shed':            'Shed',
      'location.driveway':        'Driveway',
      'location.loft':            'Loft',
      'location.cellar':          'Cellar',
      'location.porch':           'Porch',
      'location.whole_home':      'Whole home',
    };
    // Custom locations stored as 'custom.Name'
    if (key.startsWith('custom.')) return key.substring(7);
    return labels[key] ?? key;
  }
}

const List<String> _hardcodedFallback = [
  'location.living_room', 'location.bedroom', 'location.kitchen',
  'location.bathroom', 'location.hallway',
];

class _LocationChip extends StatelessWidget {
  const _LocationChip({required this.label, required this.isSelected, required this.onTap});
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? MidnightFocusTheme.primaryDim : MidnightFocusTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? MidnightFocusTheme.primary : MidnightFocusTheme.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily:  'Sora',
            fontSize:    12,
            fontWeight:  FontWeight.w500,
            color:       isSelected ? Colors.white : MidnightFocusTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CustomLocationInput extends StatefulWidget {
  const _CustomLocationInput({this.current, required this.onSet, required this.onClear});
  final String? current;
  final ValueChanged<String> onSet;
  final VoidCallback onClear;

  @override
  State<_CustomLocationInput> createState() => _CustomLocationInputState();
}

class _CustomLocationInputState extends State<_CustomLocationInput> {
  bool _isAdding = false;
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.current != null && !_isAdding) {
      return Row(
        children: [
          const Icon(Icons.location_on, color: MidnightFocusTheme.primary, size: 16),
          const SizedBox(width: 6),
          Text(
            widget.current!,
            style: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 13,
              color: MidnightFocusTheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: widget.onClear,
            child: const Icon(Icons.close, color: MidnightFocusTheme.textSecondary, size: 16),
          ),
        ],
      );
    }

    if (_isAdding) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: _ctrl,
              autofocus:  true,
              style: const TextStyle(fontFamily: 'Sora', fontSize: 14, color: MidnightFocusTheme.textPrimary),
              decoration: const InputDecoration(
                hintText:        'e.g. Sunroom, Workshop',
                hintStyle:       TextStyle(fontFamily: 'Sora', color: MidnightFocusTheme.textDisabled, fontSize: 13),
                contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onSubmitted: (v) {
                if (v.trim().isNotEmpty) {
                  widget.onSet(v.trim());
                  setState(() { _isAdding = false; });
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() { _isAdding = false; }),
            child: const Icon(Icons.close, color: MidnightFocusTheme.textSecondary, size: 18),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () => setState(() { _isAdding = true; _ctrl.clear(); }),
      child: const Row(
        children: [
          Icon(Icons.add_location_outlined, color: MidnightFocusTheme.primary, size: 16),
          SizedBox(width: 6),
          Text(
            '+ Add a location',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize:   13,
              color:      MidnightFocusTheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NotificationChannelSection
// ─────────────────────────────────────────────────────────────────────────────

class NotificationChannelSection extends ConsumerWidget {
  const NotificationChannelSection({super.key, required this.taskConfig});
  final TaskConfig taskConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form     = ref.watch(scheduleFormNotifierProvider(taskConfig));
    final notifier = ref.read(scheduleFormNotifierProvider(taskConfig).notifier);

    return _SectionCard(
      title: 'NOTIFY VIA',
      child: Column(
        children: [
          _ChannelRow(
            icon:      Icons.notifications_outlined,
            label:     'App notification',
            value:     form.channelApp,
            onChanged: notifier.setChannelApp,
            enabled:   true,
          ),
          const SizedBox(height: 12),
          _ChannelRow(
            icon:      Icons.alarm_outlined,
            label:     'Alarm',
            subtitle:  _alarmSubtitle(),
            value:     form.channelAlarm,
            onChanged: notifier.setChannelAlarm,
            enabled:   _isAlarmSupported(),
          ),
          const SizedBox(height: 12),
          _ChannelRow(
            icon:      Icons.email_outlined,
            label:     'Email',
            subtitle:  'Setup required in preferences',
            value:     form.channelEmail,
            onChanged: notifier.setChannelEmail,
            enabled:   true,
          ),
          const SizedBox(height: 12),
          _ChannelRow(
            icon:      Icons.chat_outlined,
            label:     'WhatsApp',
            subtitle:  'Setup required in preferences',
            value:     form.channelWhatsApp,
            onChanged: notifier.setChannelWhatsApp,
            enabled:   true,
          ),
        ],
      ),
    );
  }

  bool _isAlarmSupported() {
    // TODO: detect iOS and return false
    return true;
  }

  String? _alarmSubtitle() {
    if (!_isAlarmSupported()) {
      return 'Not supported on iOS — standard notification used instead';
    }
    return null;
  }
}

class _ChannelRow extends StatelessWidget {
  const _ChannelRow({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: MidnightFocusTheme.textSecondary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize:   14,
                  color: enabled
                      ? MidnightFocusTheme.textPrimary
                      : MidnightFocusTheme.textDisabled,
                ),
              ),
              if (subtitle != null) Text(
                subtitle!,
                style: const TextStyle(
                  fontFamily: 'Sora',
                  fontSize:   11,
                  color:      MidnightFocusTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value:     enabled ? value : false,
          onChanged: enabled ? onChanged : null,
          activeColor: MidnightFocusTheme.primary,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SummarySection — live summary card
// ─────────────────────────────────────────────────────────────────────────────

class SummarySection extends ConsumerWidget {
  const SummarySection({super.key, required this.taskConfig});
  final TaskConfig taskConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(scheduleFormNotifierProvider(taskConfig));

    final summary = _buildSummary(form);
    if (summary.isEmpty) return const SizedBox.shrink();

    return Container(
      width:   double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:        MidnightFocusTheme.primaryDim.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
        border:       Border.all(color: MidnightFocusTheme.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontFamily:    'Sora',
              fontSize:      11,
              fontWeight:    FontWeight.w600,
              color:         MidnightFocusTheme.primary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          ...summary.map((line) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: MidnightFocusTheme.primary)),
                Expanded(
                  child: Text(
                    line,
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize:   13,
                      color:      MidnightFocusTheme.textPrimary,
                      height:     1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  List<String> _buildSummary(ScheduleFormState form) {
    final lines = <String>[];

    // Repeat + times
    switch (form.repeatOption) {
      case RepeatOption.never:
        if (form.scheduledTimes.isNotEmpty) {
          lines.add('Once at ${form.scheduledTimes.first}');
        }
      case RepeatOption.daily:
        if (form.scheduledTimes.length == 1) {
          lines.add('Every day at ${form.scheduledTimes.first}');
        } else if (form.scheduledTimes.isNotEmpty) {
          lines.add('Every day at ${form.scheduledTimes.join(', ')}');
        }
      case RepeatOption.weekly:
        if (form.scheduledWeekdays.isNotEmpty && form.scheduledTimes.isNotEmpty) {
          final days = form.scheduledWeekdays.map(_dayName).join(', ');
          lines.add('Every $days at ${form.scheduledTimes.first}');
        }
      case RepeatOption.biweekly:
        if (form.scheduledWeekdays.isNotEmpty && form.scheduledTimes.isNotEmpty) {
          final days = form.scheduledWeekdays.map(_dayName).join(', ');
          lines.add('Every 2 weeks on $days at ${form.scheduledTimes.first}');
        }
      case RepeatOption.monthly:
        final mode = form.monthlyMode ?? 'specific_date';
        final time = form.scheduledTimes.isNotEmpty ? form.scheduledTimes.first : '';
        if (mode == 'first_day') {
          lines.add('1st of every month at $time');
        } else if (mode == 'last_day') {
          lines.add('Last day of every month at $time');
        } else {
          lines.add('Day ${form.monthlySpecificDate ?? 1} of every month at $time');
        }
      case RepeatOption.quarterly:
        lines.add('Every 3 months at ${form.scheduledTimes.first}');
      case RepeatOption.yearly:
        if (form.scheduledYearlyDates.isNotEmpty) {
          final dates = form.scheduledYearlyDates.map((d) => '${d.day} ${_month(d.month)}').join(', ');
          lines.add('Every year on $dates at ${form.scheduledTimes.first}');
        }
    }

    // Reminder
    if (form.reminderMinutes.isEmpty) {
      lines.add('No reminder set');
    } else {
      final reminders = form.reminderMinutes.map(_reminderLabel).join(', ');
      lines.add('Reminder $reminders');
    }

    // Location
    if (form.locationKey != null) {
      lines.add('Location: ${_locationLabel(form.locationKey!)}');
    } else if (form.customLocationName != null) {
      lines.add('Location: ${form.customLocationName}');
    }

    return lines;
  }

  String _dayName(int day) {
    const days = {1: 'Mon', 2: 'Tue', 3: 'Wed', 4: 'Thu', 5: 'Fri', 6: 'Sat', 7: 'Sun'};
    return days[day] ?? '$day';
  }

  String _month(int m) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return months[m - 1];
  }

  String _reminderLabel(int minutes) {
    if (minutes < 60) return '$minutes min before';
    if (minutes == 60) return '1 hour before';
    if (minutes < 1440) return '${minutes ~/ 60} hours before';
    if (minutes == 1440) return '1 day before';
    if (minutes == 10080) return '1 week before';
    if (minutes == 43200) return '1 month before';
    return '$minutes min';
  }

  String _locationLabel(String key) {
    const labels = {
      'location.living_room': 'Living Room', 'location.bedroom': 'Bedroom',
      'location.kitchen': 'Kitchen', 'location.bathroom': 'Bathroom',
      'location.hallway': 'Hallway', 'location.stairs': 'Stairs',
      'location.whole_home': 'Whole home',
    };
    if (key.startsWith('custom.')) return key.substring(7);
    return labels[key] ?? key;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared section card
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:   double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:        MidnightFocusTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border:       Border.all(color: MidnightFocusTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily:    'Sora',
              fontSize:      11,
              fontWeight:    FontWeight.w600,
              color:         MidnightFocusTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
