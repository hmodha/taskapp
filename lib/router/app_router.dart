import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/config/config_models.dart';
import '../core/data/models/saved_task.dart';
import '../features/schedule/screens/category_screen.dart';
import '../features/schedule/screens/task_list_screen.dart';
import '../features/schedule/screens/schedule_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Route names — use constants to avoid typos
// ─────────────────────────────────────────────────────────────────────────────

class AppRoutes {
  static const categories = '/';
  static const taskList   = '/category/:categoryId';
  static const schedule   = '/schedule';
}

// ─────────────────────────────────────────────────────────────────────────────
// AppRouter — go_router config (no codegen required)
// ─────────────────────────────────────────────────────────────────────────────

final appRouter = GoRouter(
  initialLocation: AppRoutes.categories,
  routes: [

    GoRoute(
      path: AppRoutes.categories,
      name: 'categories',
      builder: (context, state) => const CategoryScreen(),
    ),

    GoRoute(
      path: AppRoutes.taskList,
      name: 'taskList',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        return TaskListScreen(categoryId: categoryId);
      },
    ),

    GoRoute(
      path: AppRoutes.schedule,
      name: 'schedule',
      // Slide-up transition
      pageBuilder: (context, state) {
        final extra      = state.extra! as ScheduleRouteArgs;
        return CustomTransitionPage(
          key:             state.pageKey,
          child:           ScheduleScreen(
            categoryId:   extra.categoryId,
            taskConfig:   extra.taskConfig,
            existingTask: extra.existingTask,
          ),
          transitionsBuilder: (context, animation, _, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end:   Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve:  Curves.easeOutCubic,
              )),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    ),

  ],
);

// ─────────────────────────────────────────────────────────────────────────────
// Route arguments — passed via go_router's extra parameter
// ─────────────────────────────────────────────────────────────────────────────

class ScheduleRouteArgs {
  const ScheduleRouteArgs({
    required this.categoryId,
    required this.taskConfig,
    this.existingTask,
  });

  final String     categoryId;
  final TaskConfig taskConfig;
  final SavedTask? existingTask;
}

// ─────────────────────────────────────────────────────────────────────────────
// Navigation helpers — call these instead of context.go() directly
// ─────────────────────────────────────────────────────────────────────────────

extension AppNavigation on BuildContext {
  void goToCategories() => go(AppRoutes.categories);

  void goToTaskList(String categoryId) =>
      go('/category/$categoryId');

  void pushTaskList(String categoryId) =>
      push('/category/$categoryId');

  void pushSchedule({
    required String categoryId,
    required TaskConfig taskConfig,
    SavedTask? existingTask,
  }) =>
      push(
        AppRoutes.schedule,
        extra: ScheduleRouteArgs(
          categoryId:   categoryId,
          taskConfig:   taskConfig,
          existingTask: existingTask,
        ),
      );
}
