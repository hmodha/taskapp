import 'package:isar/isar.dart';
import '../models/saved_task.dart';

/// Repository for all SavedTask Isar operations.
///
/// All mutations go through Commands — never write to Isar directly from UI.
/// Reads can be called directly from Riverpod providers via watchStream.
class TaskRepository {
  final Isar _isar;

  TaskRepository(this._isar);

  // ── Writes ─────────────────────────────────────────────────────────────────

  /// Creates a new task. Returns the assigned Isar ID.
  Future<int> create(SavedTask task) async {
    return _isar.writeTxn(() async {
      task.createdAt = DateTime.now();
      task.updatedAt = DateTime.now();
      return _isar.savedTasks.put(task);
    });
  }

  /// Updates an existing task (full replace).
  Future<void> update(SavedTask task) async {
    await _isar.writeTxn(() async {
      task.updatedAt = DateTime.now();
      await _isar.savedTasks.put(task);
    });
  }

  /// Soft-deletes a task by setting isActive = false.
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final task = await _isar.savedTasks.get(id);
      if (task != null) {
        task.isActive = false;
        task.updatedAt = DateTime.now();
        await _isar.savedTasks.put(task);
      }
    });
  }

  /// Hard-deletes a task. Use only for GDPR erasure.
  Future<void> hardDelete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.savedTasks.delete(id);
    });
  }

  /// Links two tasks as a pair (e.g. Bin Out ↔ Bin In).
  Future<void> linkPair(int taskIdA, int taskIdB) async {
    await _isar.writeTxn(() async {
      final a = await _isar.savedTasks.get(taskIdA);
      final b = await _isar.savedTasks.get(taskIdB);
      if (a != null && b != null) {
        a.pairedTaskId = taskIdB;
        b.pairedTaskId = taskIdA;
        a.updatedAt = DateTime.now();
        b.updatedAt = DateTime.now();
        await _isar.savedTasks.putAll([a, b]);
      }
    });
  }

  // ── Reads ──────────────────────────────────────────────────────────────────

  Future<SavedTask?> getById(int id) =>
      _isar.savedTasks.get(id);

  Future<List<SavedTask>> getByCategory(String categoryId) =>
      _isar.savedTasks
          .filter()
          .categoryIdEqualTo(categoryId)
          .isActiveEqualTo(true)
          .findAll();

  Future<List<SavedTask>> getAll() =>
      _isar.savedTasks
          .filter()
          .isActiveEqualTo(true)
          .findAll();

  Future<List<SavedTask>> getBySource(String source) =>
      _isar.savedTasks
          .filter()
          .sourceEqualTo(source)
          .isActiveEqualTo(true)
          .findAll();

  // ── Reactive streams ───────────────────────────────────────────────────────

  /// Stream of all active tasks — rebuilds when any task changes.
  Stream<List<SavedTask>> watchAll() =>
      _isar.savedTasks
          .filter()
          .isActiveEqualTo(true)
          .watch(fireImmediately: true);

  /// Stream of tasks for a specific category.
  Stream<List<SavedTask>> watchByCategory(String categoryId) =>
      _isar.savedTasks
          .filter()
          .categoryIdEqualTo(categoryId)
          .isActiveEqualTo(true)
          .watch(fireImmediately: true);

  // ── Existence checks ───────────────────────────────────────────────────────

  /// Returns true if a task with this config ID already exists.
  /// Used to prevent duplicate API-created tasks.
  Future<bool> existsByConfigId(String taskConfigId) async {
    final count = await _isar.savedTasks
        .filter()
        .taskConfigIdEqualTo(taskConfigId)
        .isActiveEqualTo(true)
        .count();
    return count > 0;
  }
}
