import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_database.dart';
import '../models/saved_task.dart';

part 'task_repository.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TaskRepository — all CRUD operations for SavedTask
// ─────────────────────────────────────────────────────────────────────────────

class TaskRepository {
  TaskRepository(this._db);

  final AppDatabase _db;

  // ── Create ────────────────────────────────────────────────────────────────

  Future<SavedTask> createTask(SavedTask task) async {
    final id = await _db.into(_db.savedTasksTable).insert(task.toCompanion());
    return task..id == id; // return with assigned id
  }

  Future<List<SavedTask>> createTasks(List<SavedTask> tasks) async {
    await _db.batch((b) {
      for (final t in tasks) {
        b.insert(_db.savedTasksTable, t.toCompanion());
      }
    });
    return tasks;
  }

  // ── Read ──────────────────────────────────────────────────────────────────

  Future<SavedTask?> getById(int id) async {
    final row = await (_db.select(_db.savedTasksTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? SavedTask.fromRow(row) : null;
  }

  Future<SavedTask?> getByConfigId(String taskConfigId) async {
    final row = await (_db.select(_db.savedTasksTable)
          ..where((t) =>
              t.taskConfigId.equals(taskConfigId) &
              t.isArchived.equals(false)))
        .getSingleOrNull();
    return row != null ? SavedTask.fromRow(row) : null;
  }

  Future<List<SavedTask>> getByCategory(String categoryId) async {
    final rows = await (_db.select(_db.savedTasksTable)
          ..where((t) =>
              t.categoryId.equals(categoryId) &
              t.isArchived.equals(false)))
        .get();
    return rows.map(SavedTask.fromRow).toList();
  }

  Future<List<SavedTask>> getAllActive() async {
    final rows = await (_db.select(_db.savedTasksTable)
          ..where((t) => t.isArchived.equals(false)))
        .get();
    return rows.map(SavedTask.fromRow).toList();
  }

  /// Reactive stream — used by dashboard StreamProvider
  Stream<List<SavedTask>> watchAllActive() {
    return (_db.select(_db.savedTasksTable)
          ..where((t) => t.isArchived.equals(false)))
        .watch()
        .map((rows) => rows.map(SavedTask.fromRow).toList());
  }

  Stream<List<SavedTask>> watchByCategory(String categoryId) {
    return (_db.select(_db.savedTasksTable)
          ..where((t) =>
              t.categoryId.equals(categoryId) &
              t.isArchived.equals(false)))
        .watch()
        .map((rows) => rows.map(SavedTask.fromRow).toList());
  }

  // ── Update ────────────────────────────────────────────────────────────────

  Future<SavedTask> updateTask(SavedTask task) async {
    task.updatedAt = DateTime.now();
    await (_db.update(_db.savedTasksTable)
          ..where((t) => t.id.equals(task.id!)))
        .write(task.toUpdateCompanion());
    return task;
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  Future<void> archiveTask(int id) async {
    await (_db.update(_db.savedTasksTable)
          ..where((t) => t.id.equals(id)))
        .write(SavedTasksTableCompanion(
          isArchived: const Value(true),
          updatedAt:  Value(DateTime.now()),
        ));
  }

  Future<void> deleteTask(int id) async {
    await (_db.delete(_db.savedTasksTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<void> archiveGroup(String groupId) async {
    await (_db.update(_db.savedTasksTable)
          ..where((t) => t.groupId.equals(groupId)))
        .write(SavedTasksTableCompanion(
          isArchived: const Value(true),
          updatedAt:  Value(DateTime.now()),
        ));
  }

  // ── Existence check ───────────────────────────────────────────────────────

  Future<bool> isTaskScheduled(String taskConfigId) async {
    final count = await (_db.select(_db.savedTasksTable)
          ..where((t) =>
              t.taskConfigId.equals(taskConfigId) &
              t.isArchived.equals(false)))
        .get();
    return count.isNotEmpty;
  }
}

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  return TaskRepository(ref.watch(databaseProvider));
}
