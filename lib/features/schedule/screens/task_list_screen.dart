import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/midnight_theme.dart';
import '../models/task_config_model.dart';
import '../providers/schedule_providers.dart';
import '../../../router/app_router.dart';

@RoutePage()
class TaskListScreen extends ConsumerWidget {
  final String categoryId;

  const TaskListScreen({super.key, @PathParam() required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final categoryAsync = ref.watch(categoryConfigProvider(categoryId));

    return Scaffold(
      backgroundColor: MidnightTheme.background,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: categoryAsync.when(
          loading: () => const SizedBox.shrink(),
          error:   (_, __) => Text(l10n.taskScreenTitle),
          data:    (c) => Text(
            _resolveCategoryLabel(l10n, c.labelKey),
            style: MidnightTheme.headlineLarge,
          ),
        ),
      ),
      body: categoryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MidnightTheme.primary),
        ),
        error: (e, _) => Center(
          child: Text(e.toString(), style: MidnightTheme.bodySmall),
        ),
        data: (category) => _TaskList(category: category),
      ),
    );
  }

  String _resolveCategoryLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'category.vehicle.label'        => l10n.categoryVehicleLabel,
      'category.health.label'         => l10n.categoryHealthLabel,
      'category.home_cleaning.label'  => l10n.categoryHomeCleaningLabel,
      'category.bin_collection.label' => l10n.categoryBinCollectionLabel,
      _                               => key,
    };
  }
}

// ── Task list ─────────────────────────────────────────────────────────────────

class _TaskList extends StatelessWidget {
  final CategoryConfig category;

  const _TaskList({required this.category});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: MidnightTheme.screenH,
        vertical:   MidnightTheme.screenV,
      ),
      children: [
        ...category.tasks.map(
          (task) => _TaskTile(
            task:       task,
            categoryId: category.id,
          ),
        ),

        const SizedBox(height: 12),

        // Add custom task — shown at bottom of every category
        _AddCustomTile(categoryId: category.id),
      ],
    );
  }
}

// ── Task tile ─────────────────────────────────────────────────────────────────

class _TaskTile extends StatelessWidget {
  final TaskConfig task;
  final String categoryId;

  const _TaskTile({required this.task, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final label    = _resolveTaskLabel(l10n, task.nameKey);
    final subtitle = _resolveTaskSubtitle(l10n, task.descriptionKey);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color:        MidnightTheme.surface,
        borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
        border:       Border.all(color: MidnightTheme.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:  MidnightTheme.surface2,
            shape:  BoxShape.circle,
          ),
          child: Icon(
            _resolveIcon(task.icon),
            color: MidnightTheme.primary,
            size: 20,
          ),
        ),
        title: Text(label, style: MidnightTheme.labelLarge),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  subtitle,
                  style: MidnightTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : null,
        trailing: const Icon(
          Icons.chevron_right,
          color: MidnightTheme.textMuted,
          size: 20,
        ),
        onTap: () => context.pushRoute(
          ScheduleRoute(
            categoryId:   categoryId,
            taskConfigId: task.id,
          ),
        ),
      ),
    );
  }

  String _resolveTaskLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'task.vehicle.car_mot.name'              => l10n.taskVehicleCarMotName,
      'task.vehicle.road_tax.name'             => l10n.taskVehicleRoadTaxName,
      'task.health.medication.name'            => l10n.taskHealthMedicationName,
      'task.home_cleaning.hoovering.name'      => l10n.taskHomeCleaningHooveringName,
      'task.bin_collection.bin_out.name'       => l10n.taskBinCollectionBinOutName,
      'task.bin_collection.bin_in.name'        => l10n.taskBinCollectionBinInName,
      _                                        => key,
    };
  }

  String? _resolveTaskSubtitle(AppLocalizations l10n, String? key) {
    if (key == null) return null;
    return switch (key) {
      'task.vehicle.car_mot.description'         => l10n.taskVehicleCarMotDescription,
      'task.vehicle.road_tax.description'        => l10n.taskVehicleRoadTaxDescription,
      'task.health.medication.description'       => l10n.taskHealthMedicationDescription,
      'task.home_cleaning.hoovering.description' => l10n.taskHomeCleaningHooveringDescription,
      'task.bin_collection.bin_out.description'  => l10n.taskBinCollectionBinOutDescription,
      'task.bin_collection.bin_in.description'   => l10n.taskBinCollectionBinInDescription,
      _                                          => null,
    };
  }

  IconData _resolveIcon(String? name) {
    return switch (name) {
      'build_circle'          => Icons.build_circle,
      'receipt_long'          => Icons.receipt_long,
      'medication'            => Icons.medication,
      'cleaning_services'     => Icons.cleaning_services,
      'arrow_outward'         => Icons.arrow_outward,
      'arrow_inward'          => Icons.move_to_inbox,
      _                       => Icons.task_alt,
    };
  }
}

// ── Add custom task tile ───────────────────────────────────────────────────────

class _AddCustomTile extends StatelessWidget {
  final String categoryId;

  const _AddCustomTile({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => context.pushRoute(
        ScheduleRoute(
          categoryId:   'custom',
          taskConfigId: 'custom.new',
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:        Colors.transparent,
          borderRadius: BorderRadius.circular(MidnightTheme.radiusMd),
          border:       Border.all(
            color: MidnightTheme.border,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: MidnightTheme.primary, size: 20),
            const SizedBox(width: 12),
            Text(
              l10n.taskScreenAddCustom,
              style: MidnightTheme.bodyMedium.copyWith(
                color: MidnightTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
