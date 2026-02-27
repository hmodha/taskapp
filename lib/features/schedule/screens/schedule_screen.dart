import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config_models.dart';
import '../../../core/data/models/saved_task.dart';
import '../../../core/theme/midnight_focus_theme.dart';
import '../notifiers/schedule_notifier.dart';
import '../widgets/repeat_section.dart';
import '../widgets/schedule_sections.dart';

@RoutePage()
class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({
    super.key,
    required this.categoryId,
    required this.taskConfig,
    this.existingTask,
  });

  final String categoryId;
  final TaskConfig taskConfig;
  final SavedTask? existingTask;

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final _scrollController = ScrollController();
  final _customTitleCtrl  = TextEditingController();
  final _taskNameCtrl     = TextEditingController();
  bool _showSaveConfirmation = false;

  @override
  void initState() {
    super.initState();
    final task = widget.existingTask;
    if (task != null) {
      _customTitleCtrl.text = task.customTitle ?? '';
      _taskNameCtrl.text    = task.taskNameOverride ?? '';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _customTitleCtrl.dispose();
    _taskNameCtrl.dispose();
    super.dispose();
  }

  bool get _isCustomTask => widget.taskConfig.id == 'custom';

  @override
  Widget build(BuildContext context) {
    final form     = ref.watch(scheduleFormNotifierProvider(widget.taskConfig));
    final notifier = ref.read(scheduleFormNotifierProvider(widget.taskConfig).notifier);
    final isEditing = widget.existingTask != null;

    return Scaffold(
      backgroundColor: MidnightFocusTheme.background,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Schedule Task'),
        backgroundColor: MidnightFocusTheme.surface,
        leading: const AutoLeadingButton(),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: MidnightFocusTheme.error),
              onPressed: _confirmDelete,
            ),
        ],
      ),

      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([

                    // ── Task name (custom tasks only) ──────────────────────
                    if (_isCustomTask) ...[
                      _buildCustomTaskNameField(notifier),
                      const SizedBox(height: 16),
                    ],

                    // ── Task header (pre-defined tasks) ────────────────────
                    if (!_isCustomTask)
                      _TaskHeader(taskConfig: widget.taskConfig),
                    if (!_isCustomTask) const SizedBox(height: 20),

                    // ── Custom title ───────────────────────────────────────
                    if (widget.taskConfig.encourgeCustomTitle || _isCustomTask) ...[
                      _buildCustomTitleField(notifier),
                      const SizedBox(height: 16),
                    ],

                    // ── Repeat + time section ──────────────────────────────
                    RepeatSection(
                      taskConfig:      widget.taskConfig,
                      notifierParams:  (
                        categoryId:   widget.categoryId,
                        taskConfigId: widget.taskConfig.id,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Location section (if task supports it) ─────────────
                    if (widget.taskConfig.locations?.enabled == true) ...[
                      LocationSection(taskConfig: widget.taskConfig),
                      const SizedBox(height: 16),
                    ],

                    // ── Reminder section ───────────────────────────────────
                    ReminderSection(taskConfig: widget.taskConfig),
                    const SizedBox(height: 16),

                    // ── Notification channels ──────────────────────────────
                    NotificationChannelSection(taskConfig: widget.taskConfig),
                    const SizedBox(height: 16),

                    // ── Summary ────────────────────────────────────────────
                    SummarySection(taskConfig: widget.taskConfig),
                    const SizedBox(height: 8),

                    // ── Paired task notice ─────────────────────────────────
                    if (widget.taskConfig.linkedTask?.autoCreatePaired == true)
                      _PairedTaskNotice(taskConfig: widget.taskConfig),

                    // ── Save error ─────────────────────────────────────────
                    if (form.saveError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _ErrorBanner(message: form.saveError!),
                      ),
                  ]),
                ),
              ),
            ],
          ),

          // ── Save button (pinned to bottom) ───────────────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _SaveBar(
              isSaving:  form.isSaving,
              isValid:   notifier.isValid,
              isEditing: isEditing,
              onSave:    () => _save(notifier),
            ),
          ),

          // ── Save confirmation overlay ─────────────────────────────────────
          if (_showSaveConfirmation)
            _SaveConfirmationOverlay(
              onDone: () {
                setState(() => _showSaveConfirmation = false);
                context.router.popUntilRoot();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCustomTaskNameField(ScheduleFormNotifier notifier) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:        MidnightFocusTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border:       Border.all(color: MidnightFocusTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TASK NAME',
            style: TextStyle(
              fontFamily:    'Sora',
              fontSize:      11,
              fontWeight:    FontWeight.w600,
              color:         MidnightFocusTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller:    _taskNameCtrl,
            style:         const TextStyle(fontFamily: 'Sora', fontSize: 15, color: MidnightFocusTheme.textPrimary),
            maxLength:     60,
            decoration:    const InputDecoration(
              hintText:    'What do you want to be reminded about?',
              counterText: '',
            ),
            onChanged: notifier.setTaskName,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTitleField(ScheduleFormNotifier notifier) {
    final hintKey = widget.taskConfig.customTitleHintKey;
    final hint    = _resolveHint(hintKey) ?? 'Give this task a personal name';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:        MidnightFocusTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border:       Border.all(color: MidnightFocusTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CUSTOM TITLE',
            style: TextStyle(
              fontFamily:    'Sora',
              fontSize:      11,
              fontWeight:    FontWeight.w600,
              color:         MidnightFocusTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hint,
            style: const TextStyle(fontFamily: 'Sora', fontSize: 12, color: MidnightFocusTheme.textSecondary),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _customTitleCtrl,
            style:      const TextStyle(fontFamily: 'Sora', fontSize: 15, color: MidnightFocusTheme.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Optional',
            ),
            onChanged: notifier.setCustomTitle,
          ),
        ],
      ),
    );
  }

  String? _resolveHint(String? key) {
    const hints = {
      'task.vehicle.car_mot.custom_title_hint':       'e.g. Ford MOT, Honda MOT',
      'task.health.medication.custom_title_hint':     'e.g. Vitamin D, Blood Pressure Tablet',
      'task.home_cleaning.hoovering.custom_title_hint': 'e.g. Downstairs Hoover, Living Room Hoover',
    };
    return key != null ? hints[key] : null;
  }

  Future<void> _save(ScheduleFormNotifier notifier) async {
    final success = await notifier.save(
      ref:          ref,
      categoryId:   widget.categoryId,
      homeTimezone: 'Europe/London', // TODO: resolve from user preferences
      existingTask: widget.existingTask,
    );

    if (success && mounted) {
      setState(() => _showSaveConfirmation = true);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: MidnightFocusTheme.surfaceCard,
        title: const Text('Delete task?', style: TextStyle(fontFamily: 'Sora', color: MidnightFocusTheme.textPrimary)),
        content: const Text(
          'This task and all its reminders will be removed.',
          style: TextStyle(fontFamily: 'Sora', color: MidnightFocusTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: MidnightFocusTheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // TODO: dispatch DeleteTaskCommand
      if (mounted) context.router.popUntilRoot();
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Task header — shows task name and description for pre-defined tasks
// ─────────────────────────────────────────────────────────────────────────────

class _TaskHeader extends StatelessWidget {
  const _TaskHeader({required this.taskConfig});
  final TaskConfig taskConfig;

  @override
  Widget build(BuildContext context) {
    final name = _resolveName(taskConfig.nameKey);
    final desc = taskConfig.descriptionKey != null
        ? _resolveDesc(taskConfig.descriptionKey!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily:  'Sora',
            fontSize:    22,
            fontWeight:  FontWeight.w700,
            color:       MidnightFocusTheme.textPrimary,
          ),
        ),
        if (desc != null) ...[
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(
              fontFamily: 'Sora',
              fontSize:   14,
              color:      MidnightFocusTheme.textSecondary,
              height:     1.4,
            ),
          ),
        ],
      ],
    );
  }

  String _resolveName(String key) {
    const names = {
      'task.vehicle.car_mot.name':          'Car MOT',
      'task.vehicle.road_tax.name':         'Road Tax',
      'task.health.medication.name':        'Medication',
      'task.home_cleaning.hoovering.name':  'Hoovering',
      'task.bin_collection.bin_out.name':   'Bin Out',
      'task.bin_collection.bin_in.name':    'Bin In',
    };
    return names[key] ?? key;
  }

  String? _resolveDesc(String key) {
    const descs = {
      'task.vehicle.car_mot.description':          "Keep on top of your MOT so you're never caught out.",
      'task.vehicle.road_tax.description':          'Never forget to renew your road tax.',
      'task.health.medication.description':         "Never miss a dose. Set your medication times and we'll remind you every day.",
      'task.home_cleaning.hoovering.description':   'Keep on top of the hoovering room by room.',
      'task.bin_collection.bin_out.description':    'Put the bin out the night before collection so you never miss it.',
      'task.bin_collection.bin_in.description':     'Bring the bin back in after collection.',
    };
    return descs[key];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Paired task notice
// ─────────────────────────────────────────────────────────────────────────────

class _PairedTaskNotice extends StatelessWidget {
  const _PairedTaskNotice({required this.taskConfig});
  final TaskConfig taskConfig;

  @override
  Widget build(BuildContext context) {
    final linkedId = taskConfig.linkedTask?.linkedTaskId ?? '';
    final taskName = linkedId.contains('bin_in') ? 'Bin In' : 'the paired task';

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:        MidnightFocusTheme.accentDim.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border:       Border.all(color: MidnightFocusTheme.accent.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.link, color: MidnightFocusTheme.accent, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Saving will also suggest creating "$taskName" automatically.',
                style: const TextStyle(
                  fontFamily: 'Sora',
                  fontSize:   12,
                  color:      MidnightFocusTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Save bar (pinned bottom button)
// ─────────────────────────────────────────────────────────────────────────────

class _SaveBar extends StatelessWidget {
  const _SaveBar({
    required this.isSaving,
    required this.isValid,
    required this.isEditing,
    required this.onSave,
  });
  final bool isSaving;
  final bool isValid;
  final bool isEditing;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color:  MidnightFocusTheme.surface,
        border: const Border(top: BorderSide(color: MidnightFocusTheme.border)),
      ),
      child: SizedBox(
        width:  double.infinity,
        height: 52,
        child:  ElevatedButton(
          onPressed: isValid && !isSaving ? onSave : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ? MidnightFocusTheme.primary : MidnightFocusTheme.surfaceElevated,
            disabledBackgroundColor: MidnightFocusTheme.surfaceElevated,
          ),
          child: isSaving
              ? const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white,
                  ),
                )
              : Text(
                  isEditing ? 'Save Changes' : 'Schedule Task',
                  style: TextStyle(
                    fontFamily:  'Sora',
                    fontSize:    15,
                    fontWeight:  FontWeight.w600,
                    color:       isValid ? Colors.white : MidnightFocusTheme.textDisabled,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Save confirmation overlay
// ─────────────────────────────────────────────────────────────────────────────

class _SaveConfirmationOverlay extends StatelessWidget {
  const _SaveConfirmationOverlay({required this.onDone});
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDone,
      child: Container(
        color: MidnightFocusTheme.background.withOpacity(0.92),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  color:  MidnightFocusTheme.success.withOpacity(0.15),
                  shape:  BoxShape.circle,
                  border: Border.all(color: MidnightFocusTheme.success, width: 2),
                ),
                child: const Icon(Icons.check, color: MidnightFocusTheme.success, size: 36),
              ),
              const SizedBox(height: 20),
              const Text(
                'Scheduled!',
                style: TextStyle(
                  fontFamily:  'Sora',
                  fontSize:    24,
                  fontWeight:  FontWeight.w700,
                  color:       MidnightFocusTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your task has been saved and reminders set.',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize:   14,
                  color:      MidnightFocusTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: onDone,
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontFamily:  'Sora',
                    fontSize:    16,
                    fontWeight:  FontWeight.w600,
                    color:       MidnightFocusTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Error banner
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:        MidnightFocusTheme.error.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border:       Border.all(color: MidnightFocusTheme.error.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: MidnightFocusTheme.error, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontFamily: 'Sora', fontSize: 13, color: MidnightFocusTheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
