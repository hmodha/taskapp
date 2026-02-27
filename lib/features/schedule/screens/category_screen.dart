import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/midnight_theme.dart';
import '../models/task_config_model.dart';
import '../providers/schedule_providers.dart';
import '../../../router/app_router.dart';

@RoutePage()
class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final categoriesAsync = ref.watch(categoryRegistryProvider);

    return Scaffold(
      backgroundColor: MidnightTheme.background,
      appBar: AppBar(
        title: Text(
          l10n.categoryScreenTitle,
          style: MidnightTheme.headlineLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(
              left: MidnightTheme.screenH,
              bottom: 12,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.categoryScreenSubtitle,
                style: MidnightTheme.bodyMedium.copyWith(
                  color: MidnightTheme.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: categoriesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MidnightTheme.primary),
        ),
        error: (e, _) => _ErrorState(message: e.toString()),
        data: (categories) => _CategoryGrid(categories: categories),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MidnightTheme.fabBg,
        foregroundColor: MidnightTheme.fabIcon,
        onPressed: () => context.pushRoute(
          ScheduleRoute(
            categoryId:   'custom',
            taskConfigId: 'custom.new',
          ),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

// ── Category grid ─────────────────────────────────────────────────────────────

class _CategoryGrid extends StatelessWidget {
  final List<CategoryRegistryEntry> categories;

  const _CategoryGrid({required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(MidnightTheme.screenH),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:   2,
        crossAxisSpacing: 12,
        mainAxisSpacing:  12,
        childAspectRatio: 1.1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, i) => _CategoryCard(entry: categories[i]),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final CategoryRegistryEntry entry;

  const _CategoryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(entry.colorHex) ?? MidnightTheme.primary;
    final label = _resolveLabel(context, entry.labelKey);

    return GestureDetector(
      onTap: () => context.pushRoute(TaskListRoute(categoryId: entry.categoryId)),
      child: Container(
        decoration: BoxDecoration(
          color:        MidnightTheme.surface,
          borderRadius: BorderRadius.circular(MidnightTheme.radiusCard),
          border:       Border.all(color: MidnightTheme.border),
        ),
        padding: const EdgeInsets.all(MidnightTheme.cardPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon circle
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color:  color.withOpacity(0.12),
                shape:  BoxShape.circle,
              ),
              child: Icon(
                _resolveIcon(entry.icon),
                color: color,
                size: 22,
              ),
            ),
            const Spacer(),
            Text(label, style: MidnightTheme.labelLarge),
            const SizedBox(height: 2),
            // Accent dot
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                color:        color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveLabel(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    // Map i18n key → AppLocalizations field
    return switch (key) {
      'category.vehicle.label'        => l10n.categoryVehicleLabel,
      'category.health.label'         => l10n.categoryHealthLabel,
      'category.home_cleaning.label'  => l10n.categoryHomeCleaningLabel,
      'category.bin_collection.label' => l10n.categoryBinCollectionLabel,
      'category.custom.label'         => l10n.categoryCustomLabel,
      _                               => key,
    };
  }

  Color? _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    try {
      final clean = hex.replaceAll('#', '');
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return null;
    }
  }

  IconData _resolveIcon(String name) {
    return switch (name) {
      'directions_car'    => Icons.directions_car,
      'medication'        => Icons.medication,
      'cleaning_services' => Icons.cleaning_services,
      'delete_outline'    => Icons.delete_outline,
      'pets'              => Icons.pets,
      _                   => Icons.task_alt,
    };
  }
}

// ── Error state ────────────────────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                color: MidnightTheme.error, size: 48),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.commonError,
              style: MidnightTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: MidnightTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
