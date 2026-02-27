import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/midnight_theme.dart';
import '../models/schedule_form_state.dart';
import '../providers/schedule_providers.dart';
import '../notifiers/schedule_notifier.dart';

/// Handles the full repeat section of the schedule screen.
/// Renders the correct sub-widget based on selected repeat frequency.
class RepeatSection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const RepeatSection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(scheduleFormProvider(args));
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final l10n     = AppLocalizations.of(context)!;

    // Determine which repeats are available for this task
    final allowedRepeats = notifier.taskConfig?.allowedRepeats ??
        RepeatFrequency.values.map((r) => r.configKey).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Repeat frequency selector
        _RepeatChips(
          allowedRepeats: allowedRepeats,
          selected:       state.repeatFrequency,
          onSelect:       notifier.setRepeatFrequency,
          l10n:           l10n,
        ),
        const SizedBox(height: MidnightTheme.lg),

        // Sub-widget per frequency
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: switch (state.repeatFrequency) {
            RepeatFrequency.daily     => _DailySection(args: args, key: const ValueKey('daily')),
            RepeatFrequency.weekly    => _WeeklySection(args: args, key: const ValueKey('weekly')),
            RepeatFrequency.biweekly  => _WeeklySection(args: args, key: const ValueKey('biweekly')),
            RepeatFrequency.monthly   => _MonthlySection(args: args, key: const ValueKey('monthly')),
            RepeatFrequency.quarterly => _MonthlySection(args: args, key: const ValueKey('quarterly')),
            RepeatFrequency.yearly    => _YearlySection(args: args, key: const ValueKey('yearly')),
            RepeatFrequency.never     => const SizedBox.shrink(key: ValueKey('never')),
          },
        ),
      ],
    );
  }
}

// ── Repeat chips ──────────────────────────────────────────────────────────────

class _RepeatChips extends StatelessWidget {
  final List<String> allowedRepeats;
  final RepeatFrequency selected;
  final ValueChanged<RepeatFrequency> onSelect;
  final AppLocalizations l10n;

  const _RepeatChips({
    required this.allowedRepeats,
    required this.selected,
    required this.onSelect,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: allowedRepeats.map((key) {
        final freq    = RepeatFrequency.values.firstWhere((r) => r.configKey == key);
        final isActive = freq == selected;

        return GestureDetector(
          onTap: () => onSelect(freq),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isActive
                  ? MidnightTheme.primary.withOpacity(0.15)
                  : MidnightTheme.surface2,
              borderRadius: BorderRadius.circular(MidnightTheme.radiusPill),
              border: Border.all(
                color: isActive ? MidnightTheme.primary : MidnightTheme.border,
              ),
            ),
            child: Text(
              _label(freq, l10n),
              style: MidnightTheme.bodyMedium.copyWith(
                color: isActive ? MidnightTheme.primary : MidnightTheme.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _label(RepeatFrequency freq, AppLocalizations l10n) => switch (freq) {
    RepeatFrequency.never     => l10n.repeatNever,
    RepeatFrequency.daily     => l10n.repeatDaily,
    RepeatFrequency.weekly    => l10n.repeatWeekly,
    RepeatFrequency.biweekly  => l10n.repeatBiweekly,
    RepeatFrequency.monthly   => l10n.repeatMonthly,
    RepeatFrequency.quarterly => l10n.repeatQuarterly,
    RepeatFrequency.yearly    => l10n.repeatYearly,
  };
}

// ── Daily section ─────────────────────────────────────────────────────────────

class _DailySection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const _DailySection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(scheduleFormProvider(args));
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final l10n     = AppLocalizations.of(context)!;
    final canAdd   = notifier.canAddMoreTimes;
    final isMulti  = notifier.multipleTimesEnabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time slots
        ...state.scheduledTimes.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _TimePickerRow(
              label:    isMulti ? '${l10n.taskHealthMedicationDoseTimeLabel.replaceFirst('{n}', '${entry.key + 1}')}' : 'Time',
              time:     entry.value,
              onTap:    () => _pickTime(context, entry.key, entry.value, notifier),
              onRemove: state.scheduledTimes.length > 1
                  ? () => notifier.removeTime(entry.key)
                  : null,
            ),
          ),
        ),

        // Add time button (multi-time tasks only)
        if (isMulti && canAdd)
          _AddTimeButton(
            label:  l10n.repeatDailyAddTime,
            onTap:  () => _pickTime(
              context,
              state.scheduledTimes.length,
              '09:00',
              notifier,
              isNew: true,
            ),
          ),
      ],
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    int index,
    String current,
    ScheduleFormNotifier notifier, {
    bool isNew = false,
  }) async {
    final parts = current.split(':');
    final initial = TimeOfDay(
      hour:   int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final picked = await showTimePicker(
      context:     context,
      initialTime: initial,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx),
        child: child!,
      ),
    );

    if (picked != null) {
      final formatted =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      if (isNew) {
        notifier.addTime(formatted);
      } else {
        notifier.setTime(index, formatted);
      }
    }
  }
}

// ── Weekly section ────────────────────────────────────────────────────────────

class _WeeklySection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const _WeeklySection({super.key, required this.args});

  static const _days = [
    'monday', 'tuesday', 'wednesday', 'thursday',
    'friday', 'saturday', 'sunday',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(scheduleFormProvider(args));
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final l10n     = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day selector row
        Row(
          children: _days.map((day) {
            final isSelected = state.selectedDays.contains(day);
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: GestureDetector(
                  onTap: () => notifier.toggleDay(day),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? MidnightTheme.primary
                          : MidnightTheme.surface2,
                      borderRadius: BorderRadius.circular(MidnightTheme.radiusSm),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _dayShort(day, l10n),
                      style: MidnightTheme.bodySmall.copyWith(
                        color:      isSelected ? MidnightTheme.textOnAccent : MidnightTheme.textSecondary,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                        fontSize:   11,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: MidnightTheme.lg),

        // Time for selected days
        _TimePickerRow(
          label: 'Time',
          time:  state.scheduledTimes.isNotEmpty ? state.scheduledTimes.first : '09:00',
          onTap: () async {
            final parts = (state.scheduledTimes.isNotEmpty
                    ? state.scheduledTimes.first
                    : '09:00')
                .split(':');
            final picked = await showTimePicker(
              context:     context,
              initialTime: TimeOfDay(
                hour:   int.parse(parts[0]),
                minute: int.parse(parts[1]),
              ),
            );
            if (picked != null) {
              notifier.setTime(
                0,
                '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}',
              );
            }
          },
        ),
      ],
    );
  }

  String _dayShort(String day, AppLocalizations l10n) => switch (day) {
    'monday'    => l10n.dayMonShort,
    'tuesday'   => l10n.dayTueShort,
    'wednesday' => l10n.dayWedShort,
    'thursday'  => l10n.dayThuShort,
    'friday'    => l10n.dayFriShort,
    'saturday'  => l10n.daySatShort,
    'sunday'    => l10n.daySunShort,
    _           => day.substring(0, 3),
  };
}

// ── Monthly section ───────────────────────────────────────────────────────────

class _MonthlySection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const _MonthlySection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(scheduleFormProvider(args));
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final l10n     = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tabs: First/Last Day | Specific Date
        _SegmentedTabs(
          options: [
            _TabOption(label: l10n.repeatMonthlyTabFirstLast, value: MonthlyOption.firstDay),
            _TabOption(label: l10n.repeatMonthlyTabDate,      value: MonthlyOption.specificDate),
          ],
          selected: state.monthlyOption == MonthlyOption.specificDate
              ? MonthlyOption.specificDate
              : MonthlyOption.firstDay,
          onSelect: (v) => notifier.setMonthlyOption(v),
        ),

        const SizedBox(height: MidnightTheme.lg),

        if (state.monthlyOption == MonthlyOption.specificDate ||
            state.monthlyOption == MonthlyOption.firstDay) ...[

          if (state.monthlyOption == MonthlyOption.firstDay)
            _FirstLastDaySelector(
              selected: state.monthlyOption,
              onSelect: notifier.setMonthlyOption,
              l10n:     l10n,
            )
          else
            _SpecificDateChip(
              selectedDates: state.selectedDates,
              onTap:         () => _pickDate(context, notifier),
            ),

          const SizedBox(height: MidnightTheme.lg),

          _TimePickerRow(
            label: 'Time',
            time:  state.scheduledTimes.isNotEmpty ? state.scheduledTimes.first : '09:00',
            onTap: () => _pickMonthlyTime(context, state, notifier),
          ),
        ],
      ],
    );
  }

  Future<void> _pickDate(BuildContext ctx, ScheduleFormNotifier notifier) async {
    final picked = await showDatePicker(
      context:      ctx,
      initialDate:  DateTime.now(),
      firstDate:    DateTime.now(),
      lastDate:     DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      notifier.setSelectedDate(
        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}',
      );
    }
  }

  Future<void> _pickMonthlyTime(
    BuildContext ctx,
    ScheduleFormState state,
    ScheduleFormNotifier notifier,
  ) async {
    final parts = (state.scheduledTimes.isNotEmpty
            ? state.scheduledTimes.first
            : '09:00')
        .split(':');
    final picked = await showTimePicker(
      context:     ctx,
      initialTime: TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
    );
    if (picked != null) {
      notifier.setTime(
        0,
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}',
      );
    }
  }
}

// ── Yearly section ─────────────────────────────────────────────────────────────

class _YearlySection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const _YearlySection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state      = ref.watch(scheduleFormProvider(args));
    final notifier   = ref.read(scheduleFormProvider(args).notifier);
    final isSingle   = notifier.isYearlySingleDateOnly;
    final maxDates   = notifier.yearlyMaxDateSelections;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Helper text
        Text(
          isSingle
              ? 'Select the date (once a year)'
              : 'Select up to $maxDates dates per year',
          style: MidnightTheme.bodySmall,
        ),
        const SizedBox(height: 12),

        // Selected dates display
        if (state.selectedDates.isEmpty)
          _AddTimeButton(
            label: '+ Select date',
            onTap: () => _pickDate(context, notifier, isSingle, state),
          )
        else ...[
          ...state.selectedDates.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _DateChip(
                date:     d,
                onRemove: () => notifier.setSelectedDate(d),
              ),
            ),
          ),
          if (!isSingle && state.selectedDates.length < maxDates)
            _AddTimeButton(
              label: '+ Add another date',
              onTap: () => _pickDate(context, notifier, isSingle, state),
            ),
        ],

        if (state.selectedDates.isNotEmpty) ...[
          const SizedBox(height: MidnightTheme.lg),
          _TimePickerRow(
            label: 'Time',
            time:  state.scheduledTimes.isNotEmpty ? state.scheduledTimes.first : '09:00',
            onTap: () => _pickTime(context, state, notifier),
          ),
        ],
      ],
    );
  }

  Future<void> _pickDate(
    BuildContext ctx,
    ScheduleFormNotifier notifier,
    bool isSingle,
    ScheduleFormState state,
  ) async {
    final picked = await showDatePicker(
      context:     ctx,
      initialDate: DateTime.now(),
      firstDate:   DateTime.now(),
      lastDate:    DateTime(DateTime.now().year + 2),
    );
    if (picked != null) {
      if (isSingle && state.selectedDates.isNotEmpty) {
        // Replace existing for single-date tasks (MOT, road tax)
        notifier.setSelectedDate(state.selectedDates.first); // deselect
      }
      notifier.setSelectedDate(
        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}',
      );
    }
  }

  Future<void> _pickTime(
    BuildContext ctx,
    ScheduleFormState state,
    ScheduleFormNotifier notifier,
  ) async {
    final parts = (state.scheduledTimes.isNotEmpty
            ? state.scheduledTimes.first
            : '09:00')
        .split(':');
    final picked = await showTimePicker(
      context:     ctx,
      initialTime: TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
    );
    if (picked != null) {
      notifier.setTime(
        0,
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}',
      );
    }
  }
}

// ── Shared sub-widgets ─────────────────────────────────────────────────────────

class _TimePickerRow extends StatelessWidget {
  final String label;
  final String time;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const _TimePickerRow({
    required this.label,
    required this.time,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color:        MidnightTheme.surface2,
                borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
                border:       Border.all(color: MidnightTheme.border),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule,
                      color: MidnightTheme.textMuted, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: MidnightTheme.bodySmall.copyWith(
                      color: MidnightTheme.textMuted,
                    ),
                  ),
                  const Spacer(),
                  Text(time, style: MidnightTheme.taskTime.copyWith(
                    color: MidnightTheme.primary,
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ),
          ),
        ),
        if (onRemove != null) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline,
                color: MidnightTheme.textMuted, size: 20),
            onPressed: onRemove,
            padding: EdgeInsets.zero,
          ),
        ],
      ],
    );
  }
}

class _AddTimeButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AddTimeButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: MidnightTheme.bodyMedium.copyWith(
            color: MidnightTheme.primary,
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String date;
  final VoidCallback onRemove;

  const _DateChip({required this.date, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color:        MidnightTheme.surface2,
        borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
        border:       Border.all(color: MidnightTheme.primary.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(date, style: MidnightTheme.mono.copyWith(
            color: MidnightTheme.primary,
          )),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close,
                color: MidnightTheme.textMuted, size: 16),
          ),
        ],
      ),
    );
  }
}

class _SpecificDateChip extends StatelessWidget {
  final List<String> selectedDates;
  final VoidCallback onTap;

  const _SpecificDateChip({
    required this.selectedDates,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:        MidnightTheme.surface2,
          borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
          border:       Border.all(color: MidnightTheme.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today,
                color: MidnightTheme.textMuted, size: 18),
            const SizedBox(width: 10),
            Text(
              selectedDates.isEmpty
                  ? 'Select date'
                  : selectedDates.first,
              style: MidnightTheme.bodyMedium.copyWith(
                color: selectedDates.isEmpty
                    ? MidnightTheme.textMuted
                    : MidnightTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstLastDaySelector extends StatelessWidget {
  final MonthlyOption selected;
  final ValueChanged<MonthlyOption> onSelect;
  final AppLocalizations l10n;

  const _FirstLastDaySelector({
    required this.selected,
    required this.onSelect,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _OptionChip(
          label:      l10n.repeatMonthlyFirstDay,
          isSelected: selected == MonthlyOption.firstDay,
          onTap:      () => onSelect(MonthlyOption.firstDay),
        ),
        const SizedBox(width: 8),
        _OptionChip(
          label:      l10n.repeatMonthlyLastDay,
          isSelected: selected == MonthlyOption.lastDay,
          onTap:      () => onSelect(MonthlyOption.lastDay),
        ),
      ],
    );
  }
}

class _OptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:        isSelected
              ? MidnightTheme.primary.withOpacity(0.15)
              : MidnightTheme.surface2,
          borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
          border:       Border.all(
            color: isSelected ? MidnightTheme.primary : MidnightTheme.border,
          ),
        ),
        child: Text(
          label,
          style: MidnightTheme.bodySmall.copyWith(
            color:      isSelected ? MidnightTheme.primary : MidnightTheme.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _SegmentedTabs<T> extends StatelessWidget {
  final List<_TabOption<T>> options;
  final T selected;
  final ValueChanged<T> onSelect;

  const _SegmentedTabs({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:        MidnightTheme.surface2,
        borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
      ),
      child: Row(
        children: options.map((option) {
          final isActive = option.value == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(option.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:        isActive ? MidnightTheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(MidnightTheme.radiusSm),
                ),
                alignment: Alignment.center,
                child: Text(
                  option.label,
                  style: MidnightTheme.bodySmall.copyWith(
                    color:      isActive ? MidnightTheme.textPrimary : MidnightTheme.textMuted,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TabOption<T> {
  final String label;
  final T value;
  const _TabOption({required this.label, required this.value});
}
