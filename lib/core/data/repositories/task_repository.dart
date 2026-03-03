import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_database.dart';
import '../models/saved_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'task_repository.g.dart';

class TaskRepository {
  TaskRepository(this._db);
  final AppDatabase _db;

  Future<SavedTask> createTask(SavedTask task) async {
    final insertedId = await _db
        .into(_db.savedTasksTable)
        .insert(task.toCompanion());
    return SavedTask(
      id: insertedId,
      taskConfigId: task.taskConfigId,
      categoryId: task.categoryId,
      source: task.source,
      taskNameKey: task.taskNameKey,
      taskNameOverride: task.taskNameOverride,
      customTitle: task.customTitle,
      repeatOption: task.repeatOption,
      scheduledTimes: task.scheduledTimes,
      scheduledWeekdays: task.scheduledWeekdays,
      scheduledYearlyDateMs: task.scheduledYearlyDateMs,
      scheduledYearlyDatesMs: task.scheduledYearlyDatesMs,
      monthlyMode: task.monthlyMode,
      monthlySpecificDate: task.monthlySpecificDate,
      monthlyShortMonthFallback: task.monthlyShortMonthFallback,
      reminderMinutes: task.reminderMinutes,
      channelApp: task.channelApp,
      channelAlarm: task.channelAlarm,
      channelEmail: task.channelEmail,
      channelWhatsApp: task.channelWhatsApp,
      locationKey: task.locationKey,
      customLocationName: task.customLocationName,
      linkedTaskConfigId: task.linkedTaskConfigId,
      groupId: task.groupId,
      pointsPerCompletion: task.pointsPerCompletion,
      homeTimezone: task.homeTimezone,
      systemTimezoneAtCreation: task.systemTimezoneAtCreation,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      isArchived: task.isArchived,
      apiResponseJson: task.apiResponseJson,
    );
  }

  Future<List<SavedTask>> createTasks(List<SavedTask> tasks) async {
    await _db.batch((b) {
      for (final t in tasks) {
        b.insert(_db.savedTasksTable, t.toCompanion());
      }
    });
    return tasks;
  }

  Future<SavedTask?> getById(int id) async {
    final row = await (_db.select(
      _db.savedTasksTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? SavedTask.fromRow(row) : null;
  }

  Future<SavedTask?> getByConfigId(String taskConfigId) async {
    final row =
        await (_db.select(_db.savedTasksTable)..where(
              (t) =>
                  t.taskConfigId.equals(taskConfigId) &
                  t.isArchived.equals(false),
            ))
            .getSingleOrNull();
    return row != null ? SavedTask.fromRow(row) : null;
  }

  Future<List<SavedTask>> getByCategory(String categoryId) async {
    final rows =
        await (_db.select(_db.savedTasksTable)..where(
              (t) =>
                  t.categoryId.equals(categoryId) & t.isArchived.equals(false),
            ))
            .get();
    return rows.map(SavedTask.fromRow).toList();
  }

  Future<List<SavedTask>> getAllActive() async {
    final rows = await (_db.select(
      _db.savedTasksTable,
    )..where((t) => t.isArchived.equals(false))).get();
    return rows.map(SavedTask.fromRow).toList();
  }

  Stream<List<SavedTask>> watchAllActive() {
    return (_db.select(_db.savedTasksTable)
          ..where((t) => t.isArchived.equals(false)))
        .watch()
        .map((rows) => rows.map(SavedTask.fromRow).toList());
  }

  Stream<List<SavedTask>> watchByCategory(String categoryId) {
    return (_db.select(_db.savedTasksTable)..where(
          (t) => t.categoryId.equals(categoryId) & t.isArchived.equals(false),
        ))
        .watch()
        .map((rows) => rows.map(SavedTask.fromRow).toList());
  }

  Future<SavedTask> updateTask(SavedTask task) async {
    task.updatedAt = DateTime.now();
    await (_db.update(
      _db.savedTasksTable,
    )..where((t) => t.id.equals(task.id!))).write(task.toUpdateCompanion());
    return task;
  }

  Future<void> archiveTask(int id) async {
    await (_db.update(
      _db.savedTasksTable,
    )..where((t) => t.id.equals(id))).write(
      SavedTasksTableCompanion(
        isArchived: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteTask(int id) async {
    await (_db.delete(_db.savedTasksTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> archiveGroup(String groupId) async {
    await (_db.update(
      _db.savedTasksTable,
    )..where((t) => t.groupId.equals(groupId))).write(
      SavedTasksTableCompanion(
        isArchived: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> isTaskScheduled(String taskConfigId) async {
    final count =
        await (_db.select(_db.savedTasksTable)..where(
              (t) =>
                  t.taskConfigId.equals(taskConfigId) &
                  t.isArchived.equals(false),
            ))
            .get();
    return count.isNotEmpty;
  }
}

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepository(ref.watch(databaseProvider));
}
