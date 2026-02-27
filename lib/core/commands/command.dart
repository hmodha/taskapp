import 'package:flutter/foundation.dart';

// ── Command base ───────────────────────────────────────────────────────────────

/// Base class for all commands in the app.
///
/// Every user action that mutates state is implemented as a Command.
/// This architecture enables:
///   - Future voice input: voice constructs and dispatches the same Commands
///   - Logging: every mutation is logged in one place (CommandDispatcher)
///   - Undo: Commands can store pre-state for future undo support
///   - Testability: commands are plain Dart objects, easy to unit test
abstract class Command {
  /// Human-readable command name for logging.
  String get name;

  /// Execute the command. Returns a [CommandResult].
  Future<CommandResult> execute();
}

// ── CommandResult ──────────────────────────────────────────────────────────────

sealed class CommandResult {
  const CommandResult();
}

class CommandSuccess extends CommandResult {
  final dynamic data;
  const CommandSuccess([this.data]);
}

class CommandFailure extends CommandResult {
  final String message;
  final Object? error;
  const CommandFailure(this.message, {this.error});
}

// ── CommandDispatcher ──────────────────────────────────────────────────────────

/// Dispatches commands and handles logging, error reporting.
///
/// All UI interactions that change state must go through this dispatcher.
/// Direct repository calls from UI are forbidden.
class CommandDispatcher {
  final bool enableLogging;

  const CommandDispatcher({this.enableLogging = false});

  /// Dispatches a command and returns its result.
  ///
  /// Handles:
  ///   - Logging (if enabled in app-global-config.json)
  ///   - Error wrapping — unhandled exceptions become CommandFailure
  ///   - Future: undo stack, analytics events
  Future<CommandResult> dispatch(Command command) async {
    if (enableLogging) {
      debugPrint('[Command] → ${command.name}');
    }

    try {
      final result = await command.execute();

      if (enableLogging) {
        if (result is CommandSuccess) {
          debugPrint('[Command] ✓ ${command.name}');
        } else if (result is CommandFailure) {
          debugPrint('[Command] ✗ ${command.name}: ${result.message}');
        }
      }

      return result;

    } catch (e, stack) {
      debugPrint('[Command] ✗ ${command.name} threw: $e\n$stack');
      return CommandFailure(
        'Unexpected error in ${command.name}',
        error: e,
      );
    }
  }
}
