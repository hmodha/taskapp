import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'command.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Command base class
// ─────────────────────────────────────────────────────────────────────────────

abstract class Command<T> {
  const Command();
  Future<T> execute(Ref ref);
  String get description;
}

// ─────────────────────────────────────────────────────────────────────────────
// CommandResult
// ─────────────────────────────────────────────────────────────────────────────

class CommandResult<T> {
  const CommandResult.success(this.data)
      : error = null,
        isSuccess = true;

  const CommandResult.failure(this.error)
      : data = null,
        isSuccess = false;

  final T?      data;
  final Object? error;
  final bool    isSuccess;
  bool get isFailure => !isSuccess;
}

// ─────────────────────────────────────────────────────────────────────────────
// CommandDispatcher
// ─────────────────────────────────────────────────────────────────────────────

class CommandDispatcher {
  CommandDispatcher(this._ref);
  final Ref _ref;

  Future<CommandResult<T>> dispatch<T>(Command<T> command) async {
    try {
      final result = await command.execute(_ref);
      return CommandResult.success(result);
    } catch (e) {
      return CommandResult.failure(e);
    }
  }
}

@riverpod
CommandDispatcher commandDispatcher(Ref ref) {
  return CommandDispatcher(ref);
}
