# TaskApp — Phase 1: Create Task

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Package decisions — why each library was chosen

### Navigation: go_router (not auto_route)

`auto_route` requires `auto_route_generator` for codegen.  
`auto_route_generator` and `riverpod_generator` both pull in `analyzer` and `macros`  
at incompatible version ranges — pub cannot satisfy both simultaneously.  
`go_router` is maintained by the Flutter team, requires **zero codegen**, and is  
the recommended routing solution in Flutter docs.

### Database: drift (not isar)

`isar_generator 3.x` hard-caps `analyzer <6.0.0`.  
`auto_route_generator` (and eventually `riverpod_generator`) require `analyzer ^6.x+`.  
These are mutually exclusive — no version pinning fixes it.  
`drift` uses modern tooling, has built-in reactive streams (`.watch()`), and is  
actively maintained by the community.

---

## Version rules — read before upgrading any package

| Family | Packages | Rule |
|---|---|---|
| Riverpod | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` | Must be **identical** |
| Drift | `drift`, `drift_dev` | Must be **identical** |
| intl | `intl` | Use `'>=0.17.0 <1.0.0'` — never pin exactly |

---

## Code generation

Only two codegen packages remain — `riverpod_generator` and `drift_dev`.  
These are compatible. After any change to providers or DB tables:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generates: `app_database.g.dart` and all `*.g.dart` provider files.

---

## File structure

```
lib/
├── core/
│   ├── config/
│   │   ├── config_models.dart
│   │   ├── config_loader.dart
│   │   └── config_resolver.dart
│   ├── data/
│   │   ├── app_database.dart         ← drift DB, table definitions, initDatabase()
│   │   ├── models/
│   │   │   ├── saved_task.dart
│   │   │   └── user_preferences.dart
│   │   └── repositories/
│   │       ├── isar_provider.dart    ← re-exports app_database.dart (shim)
│   │       ├── task_repository.dart
│   │       └── preferences_repository.dart
│   ├── commands/
│   │   ├── command.dart
│   │   └── commands/task_commands.dart
│   └── theme/
│       └── midnight_focus_theme.dart
├── features/
│   └── schedule/
│       ├── notifiers/schedule_notifier.dart
│       ├── widgets/
│       │   ├── repeat_section.dart
│       │   └── schedule_sections.dart
│       └── screens/
│           ├── category_screen.dart
│           ├── task_list_screen.dart
│           └── schedule_screen.dart
├── router/
│   └── app_router.dart               ← go_router config, navigation extensions
├── l10n/app_en.arb
└── main.dart

assets/config/
├── category-registry.json
├── schedule-global-config.json
├── ui-global-config.json
└── categories/
    ├── vehicle.json
    ├── health.json
    ├── home_cleaning.json
    └── bin_collection.json
```

## Fonts

The Midnight Focus theme uses **Sora** font.  
Add via `google_fonts` package or bundle `.ttf` files and declare in `pubspec.yaml`.
