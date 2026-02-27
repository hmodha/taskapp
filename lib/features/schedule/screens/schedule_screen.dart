import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/midnight_theme.dart';
import '../models/schedule_form_state.dart';
import '../providers/schedule_providers.dart';
import '../notifiers/schedule_notifier.dart';
import '../widgets/repeat_section.dart';
import '../widgets/location_section.dart';
import '../widgets/reminder_section.dart';
import '../widgets/notification_channel_section.dart';
import '../widgets/summary_section.dart';

@RoutePage()
class ScheduleScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String taskConfigId;
  final int? existingTaskId;

  const ScheduleScreen({
    super.key,
    @PathParam() required this.categoryId,
    @PathParam() required this.taskConfigId,
    this.existingTaskId,
  });

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  late final ScheduleFormArgs _args;
  final _customTitleController = TextEditingController();
  final _taskNameController    = TextEditingController();

  @override
  void initState() {
    super.initState();
    _args = ScheduleFormArgs(
      categoryId:     widget.categoryId,
      taskConfigId:   widget.taskConfigId,
      existingTaskId: widget.existingTaskId,
    );
  }

  @override
  void dispose() {
    _customTitleController.dispose();
    _taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n       = AppLocalizations.of(context)!;
    final formState  = ref.watch(scheduleFormProvider(_args));
    final notifier   = ref.read(scheduleFormProvider(_args).notifier);
    final isEdit     = widget.existingTaskId != null;
    final isCustom   = widget.categoryId == 'custom';

    // Listen for save success/failure
    ref.listen(scheduleFormProvider(_args), (prev, next) {
      if (next.saveSuccess) {
        _onSaveSuccess(context, l10n, notifier);
      } else if (next.saveError != null) {
        _onSaveError(context, l10n, next.saveError!, notifier);
      }
    });

    return Scaffold(
      backgroundColor: MidnightTheme.background,
      appBar: _buildAppBar(l10n, isEdit),
      body: _buildBody(context, l10n, formState, notifier, isCustom),
      bottomNavigationBar: _buildSaveBar(context, l10n, formState, notifier),
    );
  }

  // ── App bar ───────────────────────────────────────────────────────────────

  AppBar _buildAppBar(AppLocalizations l10n, bool isEdit) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close, color: MidnightTheme.textSecondary),
        onPressed: () => context.popRoute(),
      ),
      title: Text(
        isEdit ? l10n.scheduleScreenEditTitle : l10n.scheduleScreenTitle,
        style: MidnightTheme.headlineMedium,
      ),
    );
  }

  // ── Body ──────────────────────────────────────────────────────────────────

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    ScheduleFormState formState,
    ScheduleFormNotifier notifier,
    bool isCustom,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: MidnightTheme.screenH,
        vertical:   MidnightTheme.screenV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Task name input (custom tasks only)
          if (isCustom) ...[
            _SectionLabel(label: 'Task Name'),
            const SizedBox(height: 8),
            TextField(
              controller: _taskNameController,
              style: MidnightTheme.bodyLarge,
              maxLength: 60,
              decoration: InputDecoration(
                hintText:    l10n.customTaskNamePlaceholder,
                counterText: '',
              ),
              onChanged: (v) => notifier.setCustomTitle(v),
            ),
            const SizedBox(height: MidnightTheme.xxl),
          ],

          // Optional custom title (standard tasks)
          if (!isCustom) ...[
            TextField(
              controller: _customTitleController,
              style: MidnightTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: l10n.scheduleCustomTitlePlaceholder,
              ),
              onChanged: (v) => notifier.setCustomTitle(v),
            ),
            const SizedBox(height: MidnightTheme.xxl),
          ],

          // Sleep window alert
          if (formState.isWithinSleepWindow)
            _SleepWindowAlert(message: l10n.scheduleSleepTimeAlert),

          // ── Repeat section ────────────────────────────────────────────────
          _SectionLabel(label: 'Repeat'),
          const SizedBox(height: 10),
          RepeatSection(args: _args),

          const SizedBox(height: MidnightTheme.xxl),
          const Divider(color: MidnightTheme.divider),
          const SizedBox(height: MidnightTheme.xxl),

          // ── Location section (only if task has locations enabled) ─────────
          LocationSection(args: _args),

          // ── Reminder section ──────────────────────────────────────────────
          _SectionLabel(label: l10n.reminderSectionTitle),
          const SizedBox(height: 10),
          ReminderSection(args: _args),

          const SizedBox(height: MidnightTheme.xxl),
          const Divider(color: MidnightTheme.divider),
          const SizedBox(height: MidnightTheme.xxl),

          // ── Notification channels ─────────────────────────────────────────
          _SectionLabel(label: l10n.notificationChannelSectionTitle),
          const SizedBox(height: 10),
          NotificationChannelSection(args: _args),

          const SizedBox(height: MidnightTheme.xxl),
          const Divider(color: MidnightTheme.divider),
          const SizedBox(height: MidnightTheme.xxl),

          // ── Summary ───────────────────────────────────────────────────────
          SummarySection(args: _args),

          // Bottom padding so content clears the save bar
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // ── Save bar ──────────────────────────────────────────────────────────────

  Widget _buildSaveBar(
    BuildContext context,
    AppLocalizations l10n,
    ScheduleFormState formState,
    ScheduleFormNotifier notifier,
  ) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MidnightTheme.screenH,
          vertical:   16,
        ),
        decoration: const BoxDecoration(
          color: MidnightTheme.background,
          border: Border(top: BorderSide(color: MidnightTheme.border)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: formState.isSaving ? null : notifier.save,
            child: formState.isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: MidnightTheme.textOnAccent,
                    ),
                  )
                : Text(l10n.scheduleSaveButton),
          ),
        ),
      ),
    );
  }

  // ── Callbacks ─────────────────────────────────────────────────────────────

  void _onSaveSuccess(
    BuildContext context,
    AppLocalizations l10n,
    ScheduleFormNotifier notifier,
  ) {
    notifier.resetSaveState();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: MidnightTheme.success),
            const SizedBox(width: 10),
            Text(
              l10n.scheduleSaveSuccess,
              style: MidnightTheme.bodyMedium,
            ),
          ],
        ),
        backgroundColor: MidnightTheme.surface2,
        behavior:        SnackBarBehavior.floating,
        duration:        const Duration(seconds: 2),
      ),
    );
    context.popRoute();
  }

  void _onSaveError(
    BuildContext context,
    AppLocalizations l10n,
    String error,
    ScheduleFormNotifier notifier,
  ) {
    notifier.resetSaveState();

    final message = error == 'guest_task_limit_reached'
        ? 'You\'ve reached the 5-task limit. Sign in to add more.'
        : l10n.commonError;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: MidnightTheme.bodyMedium),
        backgroundColor: MidnightTheme.error,
        behavior:        SnackBarBehavior.floating,
      ),
    );
  }
}

// ── Shared section label ──────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label.toUpperCase(), style: MidnightTheme.sectionHeader);
  }
}

// ── Sleep window alert ────────────────────────────────────────────────────────

class _SleepWindowAlert extends StatelessWidget {
  final String message;
  const _SleepWindowAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: MidnightTheme.lg),
      padding: const EdgeInsets.all(MidnightTheme.md),
      decoration: BoxDecoration(
        color:        MidnightTheme.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
        border:       Border.all(
          color: MidnightTheme.warning.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.bedtime_outlined,
              color: MidnightTheme.warning, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: MidnightTheme.bodySmall.copyWith(
                color: MidnightTheme.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
