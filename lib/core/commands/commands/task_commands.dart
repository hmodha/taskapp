import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/saved_task.dart';
import '../data/repositories/task_repository.dart';
import 'command.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CreateTaskCommand
// ─────────────────────────────────────────────────────────────────────────────

class CreateTaskCommand extends Command<SavedTask> {
  const CreateTaskCommand(this.task);

  final SavedTask task;

  @override
  String get description => 'Create task: ${task.displayName}';

  @override
  Future<SavedTask> execute(Ref ref) async {
    final repo = ref.read(taskRepositoryProvider);
    return repo.createTask(task);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CreatePairedTasksCommand
// Creates two linked tasks in a single transaction (e.g. Bin Out + Bin In)
// ─────────────────────────────────────────────────────────────────────────────

class CreatePairedTasksCommand extends Command<List<SavedTask>> {
  const CreatePairedTasksCommand(this.tasks);

  final List<SavedTask> tasks;

  @override
  String get description => 'Create paired tasks: ${tasks.map((t) => t.displayName).join(' + ')}';

  @override
  Future<List<SavedTask>> execute(Ref ref) async {
    final repo = ref.read(taskRepositoryProvider);
    return repo.createTasks(tasks);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EditTaskCommand
// ─────────────────────────────────────────────────────────────────────────────

class EditTaskCommand extends Command<SavedTask> {
  const EditTaskCommand(this.task);

  final SavedTask task;

  @override
  String get description => 'Edit task: ${task.displayName}';

  @override
  Future<SavedTask> execute(Ref ref) async {
    final repo = ref.read(taskRepositoryProvider);
    return repo.updateTask(task);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DeleteTaskCommand
// ─────────────────────────────────────────────────────────────────────────────

class DeleteTaskCommand extends Command<void> {
  const DeleteTaskCommand(this.taskId, {this.groupId});

  final int taskId;

  /// If set, all tasks in this group are archived together
  final String? groupId;

  @override
  String get description => 'Delete task id: $taskId';

  @override
  Future<void> execute(Ref ref) async {
    final repo = ref.read(taskRepositoryProvider);
    if (groupId != null) {
      await repo.archiveGroup(groupId!);
    } else {
      await repo.archiveTask(taskId);
    }
  }
}
