import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/data/app_database.dart';
import '../core/theme/midnight_focus_theme.dart';
import '../router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await initDatabase();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const TaskApp(),
    ),
  );
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TaskApp',
      debugShowCheckedModeBanner: false,
      theme: MidnightFocusTheme.themeData,
      routerConfig: appRouter, // go_router instance
      supportedLocales: const [Locale('en')],
      locale: const Locale('en'),
    );
  }
}
