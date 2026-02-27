import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config_models.dart';
import '../../../core/theme/midnight_focus_theme.dart';
import '../notifiers/schedule_notifier.dart';

class RepeatSection extends ConsumerWidget {
  const RepeatSection({
    super.key,
    required this.taskConfig,
    required this.notifierParams,
  });

  final TaskConfig taskConfig;
  final ({String categoryId, String taskConfigId}) notifierParams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(scheduleFormNotifierProvider(taskConfig));
    final notifier = ref.read(scheduleFormNotifierProvider(taskConfig).notifier);

    return _SectionCard(
      title: 'Repeat',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Repeat option chips
          _RepeatChips(
            allowed:  taskConfig.allowedRepeats,
            selected: form.repeatOption,
            onSelect: notifier.setRepeat,
          ),
          const SizedBox(height: 20),

          // Sub-section based on selected repeat
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _repeatSubSection(form, notifier),
          ),
        ],
      ),
    );
  }

  Widget _repeatSubSection(ScheduleFormState form, ScheduleFormNotifier notifier) {
    switch (form.repeatOption) {
      case RepeatOption.never:
        return _DateTimePicker(
          key: const ValueKey('never'),
          label: 'On date',
          time: form.scheduledTimes.first,
          onTimeChanged: (t) => notifier.setTime(t),
        );

      case RepeatOption.daily:
        return _MultiTimePicker(
          key: const ValueKey('daily'),
          taskConfig:    taskConfig,
          times:         form.scheduledTimes,
          onAdd:         notifier.addTime,
          onRemove:      notifier.removeTime,
          onTimeChanged: notifier.setTime,
        );

      case RepeatOption.weekly:
      case RepeatOption.biweekly:
        return _WeeklyPicker(
          key:              ValueKey(form.repeatOption.name),
          times:            form.scheduledTimes,
          selectedWeekdays: form.scheduledWeekdays,
          onToggleDay:      notifier.toggleWeekday,
          onTimeChanged:    (t) => notifier.setTime(t),
        );

      case RepeatOption.monthly:
        return _MonthlyPicker(
          key:              const ValueKey('monthly'),
          monthlyMode:      form.monthlyMode ?? 'specific_date',
          specificDate:     form.monthlySpecificDate ?? 1,
          shortFallback:    form.monthlyShortMonthFallback ?? 'use_last_day',
          time:             form.scheduledTimes.first,
          onModeChanged:    notifier.setMonthlyMode,
          onDateChanged:    notifier.setMonthlySpecificDate,
          onFallbackChanged:notifier.setMonthlyShortFallback,
          onTimeChanged:    (t) => notifier.setTime(t),
        );

      case RepeatOption.quarterly:
        return _QuarterlyPicker(
          key:  const ValueKey('quarterly'),
          time: form.scheduledTimes.first,
          onTimeChanged: (t) => notifier.setTime(t),
        );

      case RepeatOption.yearly:
        return _YearlyPicker(
          key:          const ValueKey('yearly'),
          yearlyConfig: taskConfig.yearlyConfig ?? YearlyConfig.defaults,
          selectedDates: form.scheduledYearlyDates,
          time:         form.scheduledTimes.first,
          onDateSelected: notifier.setYearlyDate,
          onTimeChanged:  (t) => notifier.setTime(t),
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Repeat option chips
// ─────────────────────────────────────────────────────────────────────────────

class _RepeatChips extends StatelessWidget {
  const _RepeatChips({
    required this.allowed,
    required this.selected,
    required this.onSelect,
  });

  final List<RepeatOption> allowed;
  final RepeatOption selected;
  final ValueChanged<RepeatOption> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: allowed.map((option) {
        final isSelected = option == selected;
        return GestureDetector(
          onTap: () => onSelect(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? MidnightFocusTheme.primary
                  : MidnightFocusTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? MidnightFocusTheme.primary
                    : MidnightFocusTheme.border,
              ),
            ),
            child: Text(
              _label(option),
              style: TextStyle(
                fontFamily:  'Sora',
                fontSize:    13,
                fontWeight:  FontWeight.w500,
                color:       isSelected
                    ? Colors.white
                    : MidnightFocusTheme.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _label(RepeatOption option) {
    const labels = {
      RepeatOption.never:     'Never',
      RepeatOption.daily:     'Daily',
      RepeatOption.weekly:    'Weekly',
      RepeatOption.biweekly:  'Every 2 weeks',
      RepeatOption.monthly:   'Monthly',
      RepeatOption.quarterly: 'Quarterly',
      RepeatOption.yearly:    'Yearly',
    };
    return labels[option] ?? option.name;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Time picker row
// ─────────────────────────────────────────────────────────────────────────────

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    super.key,
    required this.label,
    required this.time,
    required this.onTimeChanged,
  });

  final String label;
  final String time;
  final ValueChanged<String> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return _TimePickerRow(
      label:         label,
      time:          time,
      onTimeChanged: onTimeChanged,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Multi-time picker (for daily medication etc.)
// ─────────────────────────────────────────────────────────────────────────────

class _MultiTimePicker extends StatelessWidget {
  const _MultiTimePicker({
    super.key,
    required this.taskConfig,
    required this.times,
    required this.onAdd,
    required this.onRemove,
    required this.onTimeChanged,
  });

  final TaskConfig taskConfig;
  final List<String> times;
  final ValueChanged<String> onAdd;
  final ValueChanged<int> onRemove;
  final void Function(String time, {int index}) onTimeChanged;

  bool get _canAdd {
    final max = taskConfig.multipleTimesPerDay?.maxTimes ?? 1;
    return taskConfig.multipleTimesPerDay != null && times.length < max;
  }

  @override
  Widget build(BuildContext context) {
    final multiConfig = taskConfig.multipleTimesPerDay;
    final timeLabelKey = multiConfig?.timeLabelKey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...times.asMap().entries.map((entry) {
          final index = entry.key;
          final time  = entry.value;
          final label = timeLabelKey != null
              ? 'Dose ${index + 1}'   // TODO: resolve i18n key with index
              : 'Time ${index + 1}';

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: _TimePickerRow(
                    label:         times.length > 1 ? label : 'Time',
                    time:          time,
                    onTimeChanged: (t) => onTimeChanged(t, index: index),
                  ),
                ),
                if (times.length > 1) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => onRemove(index),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color:        MidnightFocusTheme.surfaceElevated,
                        borderRadius: BorderRadius.circular(8),
                        border:       Border.all(color: MidnightFocusTheme.border),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: MidnightFocusTheme.error,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }),

        if (_canAdd)
          GestureDetector(
            onTap: () => onAdd('09:00'),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    color: MidnightFocusTheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    multiConfig?.addTimeLabelKey != null
                        ? 'Add another dose time'
                        : 'Add time',
                    style: const TextStyle(
                      fontFamily:  'Sora',
                      fontSize:    13,
                      color:       MidnightFocusTheme.primary,
                      fontWeight:  FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Weekly picker — day chips + time
// ─────────────────────────────────────────────────────────────────────────────

class _WeeklyPicker extends StatelessWidget {
  const _WeeklyPicker({
    super.key,
    required this.times,
    required this.selectedWeekdays,
    required this.onToggleDay,
    required this.onTimeChanged,
  });

  final List<String> times;
  final List<int> selectedWeekdays;
  final ValueChanged<int> onToggleDay;
  final ValueChanged<String> onTimeChanged;

  static const _days = [
    (1, 'M'), (2, 'T'), (3, 'W'), (4, 'T'), (5, 'F'), (6, 'S'), (7, 'S'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _days.map((d) {
            final (num, label) = d;
            final selected = selectedWeekdays.contains(num);
            return GestureDetector(
              onTap: () => onToggleDay(num),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? MidnightFocusTheme.primary
                      : MidnightFocusTheme.surfaceElevated,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected
                        ? MidnightFocusTheme.primary
                        : MidnightFocusTheme.border,
                  ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontFamily:  'Sora',
                      fontSize:    13,
                      fontWeight:  FontWeight.w600,
                      color:       selected
                          ? Colors.white
                          : MidnightFocusTheme.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        _TimePickerRow(
          label:         'Time',
          time:          times.first,
          onTimeChanged: onTimeChanged,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Monthly picker
// ─────────────────────────────────────────────────────────────────────────────

class _MonthlyPicker extends StatelessWidget {
  const _MonthlyPicker({
    super.key,
    required this.monthlyMode,
    required this.specificDate,
    required this.shortFallback,
    required this.time,
    required this.onModeChanged,
    required this.onDateChanged,
    required this.onFallbackChanged,
    required this.onTimeChanged,
  });

  final String monthlyMode;
  final int specificDate;
  final String shortFallback;
  final String time;
  final ValueChanged<String> onModeChanged;
  final ValueChanged<int> onDateChanged;
  final ValueChanged<String> onFallbackChanged;
  final ValueChanged<String> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode tabs
        Row(
          children: [
            _ModeTab(label: 'First day',     value: 'first_day',     selected: monthlyMode, onTap: onModeChanged),
            const SizedBox(width: 8),
            _ModeTab(label: 'Last day',      value: 'last_day',      selected: monthlyMode, onTap: onModeChanged),
            const SizedBox(width: 8),
            _ModeTab(label: 'Specific date', value: 'specific_date', selected: monthlyMode, onTap: onModeChanged),
          ],
        ),
        const SizedBox(height: 16),

        // Specific date picker
        if (monthlyMode == 'specific_date') ...[
          Text(
            'Day of month',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 12,
              color: MidnightFocusTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          _DayOfMonthPicker(
            selected:  specificDate,
            onSelect:  onDateChanged,
          ),
          const SizedBox(height: 12),
          // Short month fallback
          Row(
            children: [
              Text(
                'If month is shorter:',
                style: TextStyle(fontFamily: 'Sora', fontSize: 13, color: MidnightFocusTheme.textSecondary),
              ),
              const SizedBox(width: 8),
              _ModeTab(label: 'Use last day', value: 'use_last_day', selected: shortFallback, onTap: onFallbackChanged),
              const SizedBox(width: 8),
              _ModeTab(label: 'Skip month',   value: 'skip_month',   selected: shortFallback, onTap: onFallbackChanged),
            ],
          ),
          const SizedBox(height: 16),
        ],

        _TimePickerRow(label: 'Time', time: time, onTimeChanged: onTimeChanged),
      ],
    );
  }
}

class _DayOfMonthPicker extends StatelessWidget {
  const _DayOfMonthPicker({required this.selected, required this.onSelect});
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List.generate(31, (i) {
        final day  = i + 1;
        final sel  = day == selected;
        return GestureDetector(
          onTap: () => onSelect(day),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 36, height: 36,
            decoration: BoxDecoration(
              color:        sel ? MidnightFocusTheme.primary : MidnightFocusTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(8),
              border:       Border.all(color: sel ? MidnightFocusTheme.primary : MidnightFocusTheme.border),
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize:   12,
                  fontWeight: FontWeight.w500,
                  color:      sel ? Colors.white : MidnightFocusTheme.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quarterly picker
// ─────────────────────────────────────────────────────────────────────────────

class _QuarterlyPicker extends StatelessWidget {
  const _QuarterlyPicker({super.key, required this.time, required this.onTimeChanged});
  final String time;
  final ValueChanged<String> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repeats every 3 months on the same date',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize:   13,
            color:      MidnightFocusTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        _TimePickerRow(label: 'Time', time: time, onTimeChanged: onTimeChanged),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Yearly picker — single date or multi-date calendar
// ─────────────────────────────────────────────────────────────────────────────

class _YearlyPicker extends StatelessWidget {
  const _YearlyPicker({
    super.key,
    required this.yearlyConfig,
    required this.selectedDates,
    required this.time,
    required this.onDateSelected,
    required this.onTimeChanged,
  });

  final YearlyConfig yearlyConfig;
  final List<DateTime> selectedDates;
  final String time;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (yearlyConfig.singleDatePicker || yearlyConfig.maxDateSelections <= 1) ...[
          // Single date picker — for MOT, Road Tax etc.
          Text(
            'Select date (once a year)',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize:   13,
              color:      MidnightFocusTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          _SingleDatePickerButton(
            selected: selectedDates.isNotEmpty ? selectedDates.first : null,
            onSelect: onDateSelected,
          ),
        ] else ...[
          // Multi-date calendar
          Text(
            'Select up to ${yearlyConfig.maxDateSelections} dates per year',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize:   13,
              color:      MidnightFocusTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          ...selectedDates.map((d) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SingleDatePickerButton(
              selected: d,
              onSelect: onDateSelected,
            ),
          )),
          if (selectedDates.length < yearlyConfig.maxDateSelections)
            _SingleDatePickerButton(
              selected: null,
              onSelect: onDateSelected,
            ),
        ],

        if (yearlyConfig.showTimePicker) ...[
          const SizedBox(height: 16),
          _TimePickerRow(label: 'Time', time: time, onTimeChanged: onTimeChanged),
        ],
      ],
    );
  }
}

class _SingleDatePickerButton extends StatelessWidget {
  const _SingleDatePickerButton({this.selected, required this.onSelect});
  final DateTime? selected;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context:      context,
          initialDate:  selected ?? DateTime.now(),
          firstDate:    DateTime.now().subtract(const Duration(days: 1)),
          lastDate:     DateTime.now().add(const Duration(days: 366)),
          builder:      (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.dark(
                primary:   MidnightFocusTheme.primary,
                onPrimary: Colors.white,
                surface:   MidnightFocusTheme.surfaceCard,
                onSurface: MidnightFocusTheme.textPrimary,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:        MidnightFocusTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border:       Border.all(
            color: selected != null
                ? MidnightFocusTheme.primary
                : MidnightFocusTheme.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: selected != null
                  ? MidnightFocusTheme.primary
                  : MidnightFocusTheme.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              selected != null
                  ? '${selected!.day} ${_month(selected!.month)} ${selected!.year}'
                  : 'Select date',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize:   14,
                color: selected != null
                    ? MidnightFocusTheme.textPrimary
                    : MidnightFocusTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _month(int m) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return months[m - 1];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: Time picker row
// ─────────────────────────────────────────────────────────────────────────────

class _TimePickerRow extends StatelessWidget {
  const _TimePickerRow({
    required this.label,
    required this.time,
    required this.onTimeChanged,
  });

  final String label;
  final String time;
  final ValueChanged<String> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final parts = time.split(':');
        final initial = TimeOfDay(
          hour:   int.tryParse(parts.first) ?? 9,
          minute: int.tryParse(parts.last)  ?? 0,
        );
        final picked = await showTimePicker(
          context:     context,
          initialTime: initial,
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.dark(
                primary:   MidnightFocusTheme.primary,
                onPrimary: Colors.white,
                surface:   MidnightFocusTheme.surfaceCard,
                onSurface: MidnightFocusTheme.textPrimary,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          final h = picked.hour.toString().padLeft(2, '0');
          final m = picked.minute.toString().padLeft(2, '0');
          onTimeChanged('$h:$m');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:        MidnightFocusTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border:       Border.all(color: MidnightFocusTheme.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: MidnightFocusTheme.primary, size: 18),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Sora',
                fontSize:   13,
                color:      MidnightFocusTheme.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'Sora',
                fontSize:   16,
                fontWeight: FontWeight.w600,
                color:      MidnightFocusTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: Mode tab chip
// ─────────────────────────────────────────────────────────────────────────────

class _ModeTab extends StatelessWidget {
  const _ModeTab({required this.label, required this.value, required this.selected, required this.onTap});
  final String label;
  final String value;
  final String selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color:        isSelected ? MidnightFocusTheme.primaryDim : MidnightFocusTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border:       Border.all(
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

// ─────────────────────────────────────────────────────────────────────────────
// Section card wrapper — consistent card style for each schedule section
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              fontFamily:  'Sora',
              fontSize:    12,
              fontWeight:  FontWeight.w600,
              color:       MidnightFocusTheme.textSecondary,
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
