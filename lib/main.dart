import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/config/config_loader.dart';
import 'core/data/models/saved_task.dart';
import 'core/data/models/user_preferences.dart';
import 'core/theme/midnight_theme.dart';
import 'features/schedule/providers/schedule_providers.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait — landscape not supported in v1
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Status bar styling for Midnight Focus
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:            Colors.transparent,
    statusBarIconBrightness:   Brightness.light,
    systemNavigationBarColor:  MidnightTheme.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialise Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      SavedTaskSchema,
      UserPreferencesSchema,
      TaskLogSchema,
      PointsTransactionSchema,
    ],
    directory: dir.path,
  );

  // Pre-load startup configs into ConfigLoader cache
  final configLoader = ConfigLoader();
  await configLoader.preloadStartupConfigs();

  runApp(
    ProviderScope(
      overrides: [
        // Inject the initialised Isar instance into the provider tree
        isarProvider.overrideWithValue(isar),
      ],
      child: const TaskApp(),
    ),
  );
}

class TaskApp extends ConsumerWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppRouter();

    return MaterialApp.router(
      title: 'TaskApp',
      debugShowCheckedModeBanner: false,

      // Phase 1: Midnight Focus hard-coded
      // Phase 2: Replace with ConfigResolver-driven theme
      theme: MidnightTheme.themeData,
      darkTheme: MidnightTheme.themeData,
      themeMode: ThemeMode.dark,

      // Localisation
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pl'),
        Locale('ro'),
        Locale('ur'),
        Locale('hi'),
        Locale('gu'),
        Locale('pa'),
      ],

      // AutoRoute
      routerConfig: router.config(),
    );
  }
}
