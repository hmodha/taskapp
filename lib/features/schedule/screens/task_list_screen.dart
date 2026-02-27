import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config_loader.dart';
import '../../../core/config/config_models.dart';
import '../../../core/data/repositories/task_repository.dart';
import '../../../core/theme/midnight_focus_theme.dart';
import '../../../router/app_router.dart';

@RoutePage()
class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({
    super.key,
    @PathParam('categoryId') required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Custom tasks go directly to schedule screen
    if (categoryId == 'custom') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.router.replace(ScheduleRoute(
          categoryId: 'custom',
          taskConfig: _customTaskConfig(),
        ));
      });
      return const SizedBox.shrink();
    }

    final categoryAsync = ref.watch(categoryConfigProvider(categoryId));

    return Scaffold(
      backgroundColor: MidnightFocusTheme.background,
      appBar: AppBar(
        title: Text(_categoryLabel(categoryId)),
        backgroundColor: MidnightFocusTheme.surface,
        leading: const AutoLeadingButton(),
      ),
      body: categoryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MidnightFocusTheme.primary),
        ),
        error: (e, _) => Center(
          child: Text('Failed to load tasks', style: context.text.bodyMedium),
        ),
        data: (category) => _TaskList(category: category),
      ),
    );
  }

  String _categoryLabel(String id) {
    const labels = {
      'vehicle':        'Vehicle',
      'health':         'Health',
      'home_cleaning':  'Home Cleaning',
      'bin_collection': 'Bin Collection',
    };
    return labels[id] ?? id;
  }

  TaskConfig _customTaskConfig() => const TaskConfig(
    id:                   'custom',
    nameKey:              'custom_task.name',
    enabled:              true,
    sortOrder:            0,
    source:               'manual',
    allowedRepeats:       RepeatOption.values,
    alarmEnabledByDefault: false,
    tags:                 [],
    encourgeCustomTitle:  false,
  );
}

class _TaskList extends ConsumerWidget {
  const _TaskList({required this.category});
  final CategoryConfig category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTasks = ref.watch(
      taskRepositoryProvider.select((_) => _), // trigger rebuild on repo changes
    );

    final tasks = category.tasks.where((t) => t.enabled).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    if (tasks.isEmpty) {
      return Center(
        child: Text(
          'No tasks available',
          style: context.text.bodyMedium?.copyWith(
            color: MidnightFocusTheme.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) => _TaskListTile(
        task:       tasks[i],
        categoryId: category.id,
        colorHex:   category.colorHex,
      ),
    );
  }
}

class _TaskListTile extends ConsumerWidget {
  const _TaskListTile({
    required this.task,
    required this.categoryId,
    this.colorHex,
  });

  final TaskConfig task;
  final String categoryId;
  final String? colorHex;

  Color get _accentColor {
    if (colorHex == null) return MidnightFocusTheme.primary;
    try {
      return Color(int.parse('FF${colorHex!.replaceFirst('#', '')}', radix: 16));
    } catch (_) {
      return MidnightFocusTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: ref.read(taskRepositoryProvider).isTaskScheduled(task.id),
      builder: (context, snapshot) {
        final isScheduled = snapshot.data ?? false;

        return GestureDetector(
          onTap: () => context.router.push(ScheduleRoute(
            categoryId: categoryId,
            taskConfig: task,
          )),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color:        MidnightFocusTheme.surfaceCard,
              borderRadius: BorderRadius.circular(14),
              border:       Border.all(
                color: isScheduled
                    ? _accentColor.withOpacity(0.4)
                    : MidnightFocusTheme.border,
              ),
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color:        _accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _iconData(task.icon ?? 'task_alt'),
                    color: _accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),

                // Name + source tag
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _resolveTaskName(task.nameKey),
                        style: const TextStyle(
                          fontFamily:  'Sora',
                          fontSize:    15,
                          fontWeight:  FontWeight.w600,
                          color:       MidnightFocusTheme.textPrimary,
                        ),
                      ),
                      if (task.source != 'manual') ...[
                        const SizedBox(height: 2),
                        Text(
                          _sourceLabel(task.source),
                          style: const TextStyle(
                            fontFamily: 'Sora',
                            fontSize:   11,
                            color:      MidnightFocusTheme.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Scheduled indicator
                if (isScheduled)
                  Icon(Icons.check_circle, color: _accentColor, size: 18)
                else
                  const Icon(
                    Icons.chevron_right,
                    color: MidnightFocusTheme.textDisabled,
                    size: 20,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _resolveTaskName(String key) {
    const names = {
      'task.vehicle.car_mot.name':              'Car MOT',
      'task.vehicle.road_tax.name':             'Road Tax',
      'task.health.medication.name':            'Medication',
      'task.home_cleaning.hoovering.name':      'Hoovering',
      'task.bin_collection.bin_out.name':       'Bin Out',
      'task.bin_collection.bin_in.name':        'Bin In',
    };
    return names[key] ?? key;
  }

  String _sourceLabel(String source) {
    const labels = {
      'dvla_api':       'Via DVLA lookup',
      'bin_api':        'Via bin collection API',
      'setup_wizard':   'From setup',
    };
    return labels[source] ?? source;
  }

  IconData _iconData(String name) {
    const icons = {
      'build_circle':         Icons.build_circle,
      'receipt_long':         Icons.receipt_long,
      'medication':           Icons.medication,
      'cleaning_services':    Icons.cleaning_services,
      'arrow_outward':        Icons.arrow_outward,
      'arrow_inward':         Icons.arrow_back,
      'task_alt':             Icons.task_alt,
    };
    return icons[name] ?? Icons.task_alt;
  }
}
