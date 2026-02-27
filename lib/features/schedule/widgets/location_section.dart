import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/midnight_theme.dart';
import '../models/schedule_form_state.dart';
import '../providers/schedule_providers.dart';
import '../notifiers/schedule_notifier.dart';

// ─────────────────────────────────────────────────────────────────────────────
// LocationSection
// ─────────────────────────────────────────────────────────────────────────────

class LocationSection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const LocationSection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final taskConf = notifier.taskConfig;

    // Hide section entirely if task has no location config
    if (taskConf?.locations == null || taskConf!.locations!.enabled == false) {
      return const SizedBox.shrink();
    }

    final state            = ref.watch(scheduleFormProvider(args));
    final l10n             = AppLocalizations.of(context)!;
    final locationsAsync   = ref.watch(resolvedLocationsProvider(args.taskConfigId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: l10n.locationSectionTitle),
        const SizedBox(height: 10),

        locationsAsync.when(
          loading: () => const LinearProgressIndicator(
            color: MidnightTheme.primary,
          ),
          error: (_, __) => const SizedBox.shrink(),
          data: (locations) => _LocationPicker(
            locations:   locations,
            selected:    state.locationKey,
            onSelect:    notifier.setLocation,
            l10n:        l10n,
            onAddCustom: () => _showAddCustomDialog(context, ref, l10n),
          ),
        ),

        const SizedBox(height: MidnightTheme.xxl),
        const Divider(color: MidnightTheme.divider),
        const SizedBox(height: MidnightTheme.xxl),
      ],
    );
  }

  Future<void> _showAddCustomDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MidnightTheme.surface,
        title: Text(l10n.locationAddCustom,
            style: MidnightTheme.headlineMedium),
        content: TextField(
          controller:  controller,
          autofocus:   true,
          maxLength:   40,
          style:       MidnightTheme.bodyMedium,
          decoration:  InputDecoration(
            hintText: l10n.locationCustomPlaceholder,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.commonCancel,
                style: const TextStyle(color: MidnightTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(l10n.commonAdd),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      // Save custom location to preferences
      final prefsRepo = ref.read(preferencesRepositoryProvider);
      await prefsRepo.addCustomLocation(result);
      // Select it immediately
      ref.read(scheduleFormProvider(args).notifier).setLocation(result);
    }
  }
}

class _LocationPicker extends StatelessWidget {
  final List<String> locations;
  final String? selected;
  final ValueChanged<String?> onSelect;
  final AppLocalizations l10n;
  final VoidCallback onAddCustom;

  const _LocationPicker({
    required this.locations,
    required this.selected,
    required this.onSelect,
    required this.l10n,
    required this.onAddCustom,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Whole home / no location option
        _LocationChip(
          label:      l10n.locationWholeHome,
          isSelected: selected == null,
          onTap:      () => onSelect(null),
        ),

        // Location options
        ...locations.map((locKey) => _LocationChip(
          label:      _resolveLabel(l10n, locKey),
          isSelected: selected == locKey,
          onTap:      () => onSelect(selected == locKey ? null : locKey),
        )),

        // Add custom
        _AddLocationChip(
          label: l10n.locationAddCustom,
          onTap: onAddCustom,
        ),
      ],
    );
  }

  String _resolveLabel(AppLocalizations l10n, String key) => switch (key) {
    'location.living_room'    => l10n.locationLivingRoom,
    'location.bedroom'        => l10n.locationBedroom,
    'location.second_bedroom' => l10n.locationSecondBedroom,
    'location.third_bedroom'  => l10n.locationThirdBedroom,
    'location.bathroom'       => l10n.locationBathroom,
    'location.ensuite'        => l10n.locationEnsuite,
    'location.kitchen'        => l10n.locationKitchen,
    'location.dining_room'    => l10n.locationDiningRoom,
    'location.hallway'        => l10n.locationHallway,
    'location.landing'        => l10n.locationLanding,
    'location.stairs'         => l10n.locationStairs,
    'location.home_office'    => l10n.locationHomeOffice,
    'location.utility_room'   => l10n.locationUtilityRoom,
    'location.conservatory'   => l10n.locationConservatory,
    'location.garage'         => l10n.locationGarage,
    'location.garden'         => l10n.locationGarden,
    'location.shed'           => l10n.locationShed,
    'location.driveway'       => l10n.locationDriveway,
    'location.loft'           => l10n.locationLoft,
    'location.cellar'         => l10n.locationCellar,
    'location.porch'          => l10n.locationPorch,
    _                         => key, // Custom location — raw string
  };
}

class _LocationChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LocationChip({
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? MidnightTheme.primary.withOpacity(0.15)
              : MidnightTheme.surface2,
          borderRadius: BorderRadius.circular(MidnightTheme.radiusPill),
          border: Border.all(
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

class _AddLocationChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AddLocationChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:        Colors.transparent,
          borderRadius: BorderRadius.circular(MidnightTheme.radiusPill),
          border:       Border.all(
            color: MidnightTheme.primary.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: MidnightTheme.primary, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: MidnightTheme.bodySmall.copyWith(
                color: MidnightTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ReminderSection
// ─────────────────────────────────────────────────────────────────────────────

class ReminderSection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const ReminderSection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(scheduleFormProvider(args));
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final l10n     = AppLocalizations.of(context)!;

    // Resolve which reminder options to show
    // For yearly/quarterly: show extended options (1 day, 1 week, 1 month)
    final isExtended = state.repeatFrequency == RepeatFrequency.yearly ||
        state.repeatFrequency == RepeatFrequency.quarterly;

    final taskReminderOptions = notifier.taskConfig?.reminderOptions?.optionsMinutes;
    final options = taskReminderOptions ?? (isExtended
        ? [1440, 10080, 43200]
        : [2, 5, 10, 15, 30, 60]);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((minutes) {
        final isSelected = state.reminderMinutes.contains(minutes);
        return GestureDetector(
          onTap: () => notifier.toggleReminder(minutes),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? MidnightTheme.primary.withOpacity(0.15)
                  : MidnightTheme.surface2,
              borderRadius: BorderRadius.circular(MidnightTheme.radiusPill),
              border: Border.all(
                color: isSelected ? MidnightTheme.primary : MidnightTheme.border,
              ),
            ),
            child: Text(
              _formatReminder(minutes, l10n),
              style: MidnightTheme.bodySmall.copyWith(
                color: isSelected
                    ? MidnightTheme.primary
                    : MidnightTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatReminder(int minutes, AppLocalizations l10n) => switch (minutes) {
    2     => l10n.reminder2m,
    5     => l10n.reminder5m,
    10    => l10n.reminder10m,
    15    => l10n.reminder15m,
    30    => l10n.reminder30m,
    60    => l10n.reminder1h,
    1440  => l10n.reminder1day,
    10080 => l10n.reminder1week,
    43200 => l10n.reminder1month,
    _     => '$minutes min',
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// NotificationChannelSection
// ─────────────────────────────────────────────────────────────────────────────

class NotificationChannelSection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const NotificationChannelSection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(scheduleFormProvider(args));
    final notifier = ref.read(scheduleFormProvider(args).notifier);
    final l10n     = AppLocalizations.of(context)!;

    return Column(
      children: [
        _ChannelToggle(
          icon:     Icons.notifications_outlined,
          label:    l10n.notificationChannelApp,
          value:    state.notifyViaApp,
          onToggle: notifier.setNotifyViaApp,
        ),
        _ChannelToggle(
          icon:     Icons.alarm,
          label:    l10n.notificationChannelAlarm,
          value:    state.notifyViaAlarm,
          onToggle: notifier.setNotifyViaAlarm,
          subtitle: _alarmSubtitle(context, l10n),
        ),
        _ChannelToggle(
          icon:     Icons.email_outlined,
          label:    l10n.notificationChannelEmail,
          value:    state.notifyViaEmail,
          onToggle: notifier.setNotifyViaEmail,
        ),
        _ChannelToggle(
          icon:     Icons.chat_outlined,
          label:    l10n.notificationChannelWhatsapp,
          value:    state.notifyViaWhatsapp,
          onToggle: notifier.setNotifyViaWhatsapp,
        ),
      ],
    );
  }

  String? _alarmSubtitle(BuildContext ctx, AppLocalizations l10n) {
    // On iOS show limitation note
    final platform = Theme.of(ctx).platform;
    if (platform == TargetPlatform.iOS) {
      return l10n.alarmIosNotSupported;
    }
    return null;
  }
}

class _ChannelToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onToggle;

  const _ChannelToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onToggle,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, color: MidnightTheme.textMuted, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: MidnightTheme.bodyMedium),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: MidnightTheme.bodySmall.copyWith(
                        color: MidnightTheme.warning,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value:     value,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SummarySection
// ─────────────────────────────────────────────────────────────────────────────

class SummarySection extends ConsumerWidget {
  final ScheduleFormArgs args;
  const SummarySection({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleFormProvider(args));
    final l10n  = AppLocalizations.of(context)!;
    final text  = _buildSummaryText(state, l10n);

    if (text == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(MidnightTheme.cardPad),
      decoration: BoxDecoration(
        color:        MidnightTheme.surface2,
        borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
        border:       Border.all(
          color: MidnightTheme.primary.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline,
              color: MidnightTheme.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: MidnightTheme.bodySmall.copyWith(
                color:      MidnightTheme.textSecondary,
                height:     1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _buildSummaryText(ScheduleFormState s, AppLocalizations l10n) {
    final time  = s.scheduledTimes.isNotEmpty ? s.scheduledTimes.first : '—';
    final times = s.scheduledTimes.join(', ');

    return switch (s.repeatFrequency) {
      RepeatFrequency.never     => null,
      RepeatFrequency.daily     => l10n.scheduleSummaryDaily
          .replaceFirst('{times}', times),
      RepeatFrequency.weekly    => s.selectedDays.isEmpty ? null
          : l10n.scheduleSummaryWeekly
              .replaceFirst('{days}', _formatDays(s.selectedDays, l10n))
              .replaceFirst('{time}', time),
      RepeatFrequency.biweekly  => s.selectedDays.isEmpty ? null
          : l10n.scheduleSummaryBiweekly
              .replaceFirst('{days}', _formatDays(s.selectedDays, l10n))
              .replaceFirst('{time}', time),
      RepeatFrequency.monthly ||
      RepeatFrequency.quarterly => l10n.scheduleSummaryMonthly
          .replaceFirst('{date}', s.monthlyOption == MonthlyOption.firstDay
              ? 'first day'
              : s.monthlyOption == MonthlyOption.lastDay
                  ? 'last day'
                  : s.selectedDates.isNotEmpty ? s.selectedDates.first : '—')
          .replaceFirst('{time}', time),
      RepeatFrequency.yearly    => s.selectedDates.isEmpty ? null
          : l10n.scheduleSummaryYearly
              .replaceFirst('{date}', s.selectedDates.join(' & '))
              .replaceFirst('{time}', time),
    };
  }

  String _formatDays(List<String> days, AppLocalizations l10n) {
    final labels = days.map((d) => switch (d) {
      'monday'    => l10n.dayMonShort,
      'tuesday'   => l10n.dayTueShort,
      'wednesday' => l10n.dayWedShort,
      'thursday'  => l10n.dayThuShort,
      'friday'    => l10n.dayFriShort,
      'saturday'  => l10n.daySatShort,
      'sunday'    => l10n.daySunShort,
      _           => d,
    }).toList();

    if (labels.length == 1) return labels.first;
    if (labels.length == 2) return '${labels[0]} & ${labels[1]}';
    return '${labels.sublist(0, labels.length - 1).join(', ')} & ${labels.last}';
  }
}

// ── Shared ────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: MidnightTheme.sectionHeader,
    );
  }
}
