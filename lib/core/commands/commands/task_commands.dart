import '../command.dart';
import '../../data/models/saved_task.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/preferences_repository.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

// ── CreateTaskCommand ──────────────────────────────────────────────────────────

/// Creates a new task in Isar.
///
/// Captures home_timezone and system_timezone at creation time.
/// Returns the new task's Isar ID as CommandSuccess.data.
class CreateTaskCommand extends Command {
  final TaskRepository _taskRepo;
  final PreferencesRepository _prefsRepo;
  final SavedTask task;

  CreateTaskCommand({
    required TaskRepository taskRepo,
    required PreferencesRepository prefsRepo,
    required this.task,
  })  : _taskRepo = taskRepo,
        _prefsRepo = prefsRepo;

  @override
  String get name => 'CreateTaskCommand';

  @override
  Future<CommandResult> execute() async {
    // Capture timezone at creation time
    final prefs = await _prefsRepo.get();
    task.homeTimezone = prefs.homeTimezone;
    task.systemTimezone = await _getCurrentSystemTimezone();

    // Enforce subscription task limit for guest users
    if (prefs.subscriptionTier == 'guest') {
      final all = await _taskRepo.getAll();
      const guestLimit = 5; // sourced from app-global-config at runtime
      if (all.length >= guestLimit) {
        return const CommandFailure(
          'guest_task_limit_reached',
        );
      }
    }

    final id = await _taskRepo.create(task);
    return CommandSuccess(id);
  }

  Future<String> _getCurrentSystemTimezone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (_) {
      return 'Europe/London';
    }
  }
}

// ── EditTaskCommand ────────────────────────────────────────────────────────────

/// Updates an existing task in Isar.
class EditTaskCommand extends Command {
  final TaskRepository _taskRepo;
  final SavedTask updatedTask;

  EditTaskCommand({
    required TaskRepository taskRepo,
    required this.updatedTask,
  }) : _taskRepo = taskRepo;

  @override
  String get name => 'EditTaskCommand';

  @override
  Future<CommandResult> execute() async {
    // Ensure the task exists before updating
    final existing = await _taskRepo.getById(updatedTask.id);
    if (existing == null) {
      return const CommandFailure('Task not found for editing');
    }

    // Preserve creation timestamp and source
    updatedTask.createdAt = existing.createdAt;
    updatedTask.source = existing.source;

    await _taskRepo.update(updatedTask);
    return const CommandSuccess();
  }
}

// ── DeleteTaskCommand ──────────────────────────────────────────────────────────

/// Soft-deletes a task (sets isActive = false).
///
/// If the task has a paired task (e.g. Bin Out ↔ Bin In),
/// prompts via result data — does NOT auto-delete the pair.
/// The UI handles the pair deletion prompt using [shouldPromptPairDeletion].
class DeleteTaskCommand extends Command {
  final TaskRepository _taskRepo;
  final int taskId;

  DeleteTaskCommand({
    required TaskRepository taskRepo,
    required this.taskId,
  }) : _taskRepo = taskRepo;

  @override
  String get name => 'DeleteTaskCommand';

  @override
  Future<CommandResult> execute() async {
    final task = await _taskRepo.getById(taskId);
    if (task == null) {
      return const CommandFailure('Task not found for deletion');
    }

    await _taskRepo.delete(taskId);

    // Signal to UI if paired task exists so it can offer to delete the pair
    if (task.pairedTaskId != null) {
      return CommandSuccess({
        'shouldPromptPairDeletion': true,
        'pairedTaskId': task.pairedTaskId,
      });
    }

    return const CommandSuccess();
  }
}

// ── CreatePairedTasksCommand ───────────────────────────────────────────────────

/// Creates two linked tasks (e.g. Bin Out + Bin In) atomically.
/// Links them via pairedTaskId after both are created.
class CreatePairedTasksCommand extends Command {
  final TaskRepository _taskRepo;
  final PreferencesRepository _prefsRepo;
  final SavedTask primaryTask;
  final SavedTask pairedTask;

  CreatePairedTasksCommand({
    required TaskRepository taskRepo,
    required PreferencesRepository prefsRepo,
    required this.primaryTask,
    required this.pairedTask,
  })  : _taskRepo = taskRepo,
        _prefsRepo = prefsRepo;

  @override
  String get name => 'CreatePairedTasksCommand';

  @override
  Future<CommandResult> execute() async {
    // Create primary
    final createPrimary = CreateTaskCommand(
      taskRepo: _taskRepo,
      prefsRepo: _prefsRepo,
      task: primaryTask,
    );
    final primaryResult = await createPrimary.execute();
    if (primaryResult is CommandFailure) return primaryResult;
    final primaryId = (primaryResult as CommandSuccess).data as int;

    // Create paired
    final createPaired = CreateTaskCommand(
      taskRepo: _taskRepo,
      prefsRepo: _prefsRepo,
      task: pairedTask,
    );
    final pairedResult = await createPaired.execute();
    if (pairedResult is CommandFailure) {
      // Roll back primary if paired creation fails
      await _taskRepo.delete(primaryId);
      return pairedResult;
    }
    final pairedId = (pairedResult as CommandSuccess).data as int;

    // Link the pair
    await _taskRepo.linkPair(primaryId, pairedId);

    return CommandSuccess({'primaryId': primaryId, 'pairedId': pairedId});
  }
}
