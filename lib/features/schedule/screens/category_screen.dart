import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/config_loader.dart';
import '../../../core/config/config_models.dart';
import '../../../core/theme/midnight_focus_theme.dart';
import '../../../router/app_router.dart';

@RoutePage()
class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registryAsync = ref.watch(categoryRegistryProvider);

    return Scaffold(
      backgroundColor: MidnightFocusTheme.background,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: MidnightFocusTheme.surface,
      ),
      body: registryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MidnightFocusTheme.primary),
        ),
        error: (e, _) => _ErrorState(error: e.toString()),
        data: (entries) => _CategoryGrid(entries: entries),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.push(
          TaskListRoute(categoryId: 'custom'),
        ),
        backgroundColor: MidnightFocusTheme.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Custom Task',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.entries});

  final List<CategoryRegistryEntry> entries;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:    2,
        crossAxisSpacing:  12,
        mainAxisSpacing:   12,
        childAspectRatio:  1.1,
      ),
      itemCount: entries.length,
      itemBuilder: (context, i) => _CategoryCard(entry: entries[i]),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.entry});

  final CategoryRegistryEntry entry;

  Color get _color {
    if (entry.colorHex == null) return MidnightFocusTheme.primary;
    try {
      return Color(int.parse('FF${entry.colorHex!.replaceFirst('#', '')}', radix: 16));
    } catch (_) {
      return MidnightFocusTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;

    return GestureDetector(
      onTap: () => context.router.push(TaskListRoute(categoryId: entry.categoryId)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color:        MidnightFocusTheme.surfaceCard,
          borderRadius: BorderRadius.circular(18),
          border:       Border.all(color: MidnightFocusTheme.border),
        ),
        child: Stack(
          children: [
            // Subtle colour accent top-right
            Positioned(
              top: -20, right: -20,
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.12),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color:        color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _iconData(entry.icon),
                      color: color,
                      size: 22,
                    ),
                  ),

                  // Label
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _resolveLabel(context, entry.labelKey),
                        style: const TextStyle(
                          fontFamily:  'Sora',
                          fontSize:    14,
                          fontWeight:  FontWeight.w600,
                          color:       MidnightFocusTheme.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveLabel(BuildContext context, String key) {
    // i18n key → localised string. In Phase 1 we map directly.
    const labels = {
      'category.vehicle.label':        'Vehicle',
      'category.health.label':         'Health',
      'category.home_cleaning.label':  'Home Cleaning',
      'category.bin_collection.label': 'Bin Collection',
      'category.custom.label':         'My Tasks',
    };
    return labels[key] ?? key;
  }

  IconData _iconData(String name) {
    const icons = {
      'directions_car':    Icons.directions_car,
      'medication':        Icons.medication,
      'cleaning_services': Icons.cleaning_services,
      'delete_outline':    Icons.delete_outline,
      'task_alt':          Icons.task_alt,
    };
    return icons[name] ?? Icons.category;
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: MidnightFocusTheme.error, size: 48),
            const SizedBox(height: 16),
            Text(
              'Failed to load categories',
              style: context.text.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(error, style: context.text.bodySmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
