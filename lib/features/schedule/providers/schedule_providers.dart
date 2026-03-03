// schedule_providers.dart
// This file is intentionally minimal — all providers now live next to their
// classes using @riverpod annotations (riverpod_generator).
//
// The old isar-based providers that were here have been removed.
// Re-exports the generated providers for convenient imports:

export '../../../core/commands/command.dart'      show commandDispatcherProvider;
export '../../../core/config/config_loader.dart'  show configLoaderProvider, categoryRegistryProvider, categoryConfigProvider;
export '../../../core/config/config_resolver.dart' show configResolverProvider;
export '../../../core/data/repositories/task_repository.dart' show taskRepositoryProvider;
export '../../../core/data/repositories/preferences_repository.dart' show preferencesRepositoryProvider, userPreferencesProvider;
export '../notifiers/schedule_notifier.dart'      show scheduleFormNotifierProvider, ScheduleFormState, ScheduleFormNotifier;
