import 'package:flutter/material.dart';

/// Midnight Focus theme — the primary dark theme for TaskApp.
/// All colours, typography, and component styles defined here.
/// Widgets reference Theme.of(context) — no hardcoded colours in widget files.
class MidnightFocusTheme {
  MidnightFocusTheme._();

  // ── Palette ──────────────────────────────────────────────────────────────
  static const Color background      = Color(0xFF0D0D0F);
  static const Color surface         = Color(0xFF16161A);
  static const Color surfaceElevated = Color(0xFF1E1E24);
  static const Color surfaceCard     = Color(0xFF1A1A20);
  static const Color border          = Color(0xFF2A2A35);
  static const Color borderFaint     = Color(0xFF1F1F28);

  static const Color primary         = Color(0xFF7C6AF7); // violet
  static const Color primaryDim      = Color(0xFF4A3FA0);
  static const Color accent          = Color(0xFF4FC3A1); // teal
  static const Color accentDim       = Color(0xFF2A7A65);

  static const Color textPrimary     = Color(0xFFF0F0F5);
  static const Color textSecondary   = Color(0xFF9090A8);
  static const Color textDisabled    = Color(0xFF50505F);
  static const Color textOnPrimary   = Color(0xFFFFFFFF);

  static const Color success         = Color(0xFF4CAF88);
  static const Color warning         = Color(0xFFF5A623);
  static const Color error           = Color(0xFFE05C5C);
  static const Color info            = Color(0xFF5B9BD5);

  // Category colours
  static const Color categoryVehicle     = Color(0xFF1565C0);
  static const Color categoryHealth      = Color(0xFFC62828);
  static const Color categoryHomeCleaning = Color(0xFF2E7D32);
  static const Color categoryBin         = Color(0xFF6A1E55);
  static const Color categoryCustom      = Color(0xFF4A3FA0);

  // ── Typography ───────────────────────────────────────────────────────────
  /// Using 'Sora' as display + UI font — geometric, modern, distinctive.
  /// Falls back to sans-serif. Add google_fonts or bundle the font file.
  static const String _fontFamily = 'Sora';

  static const TextTheme textTheme = TextTheme(
    // Large screen titles
    displayLarge:  TextStyle(fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700, color: textPrimary, letterSpacing: -0.5),
    displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 26, fontWeight: FontWeight.w600, color: textPrimary, letterSpacing: -0.3),
    displaySmall:  TextStyle(fontFamily: _fontFamily, fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary),

    // Section headers
    headlineLarge:  TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
    headlineMedium: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
    headlineSmall:  TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),

    // Body
    bodyLarge:  TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: textPrimary, height: 1.5),
    bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: textPrimary, height: 1.5),
    bodySmall:  TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: textSecondary, height: 1.4),

    // Labels / chips
    labelLarge:  TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary, letterSpacing: 0.1),
    labelMedium: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: textSecondary, letterSpacing: 0.2),
    labelSmall:  TextStyle(fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w500, color: textDisabled, letterSpacing: 0.3),

    // Title (AppBar etc.)
    titleLarge:  TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
    titleMedium: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
    titleSmall:  TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: textSecondary),
  );

  // ── ThemeData ─────────────────────────────────────────────────────────────
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    textTheme: textTheme,

    colorScheme: const ColorScheme.dark(
      background:       background,
      surface:          surface,
      primary:          primary,
      onPrimary:        textOnPrimary,
      secondary:        accent,
      onSecondary:      textOnPrimary,
      error:            error,
      onError:          textOnPrimary,
      onBackground:     textPrimary,
      onSurface:        textPrimary,
      surfaceVariant:   surfaceElevated,
      outline:          border,
    ),

    scaffoldBackgroundColor: background,

    appBarTheme: const AppBarTheme(
      backgroundColor:  surface,
      foregroundColor:  textPrimary,
      elevation:        0,
      surfaceTintColor: Colors.transparent,
      centerTitle:      false,
      titleTextStyle: TextStyle(
        fontFamily:  _fontFamily,
        fontSize:    18,
        fontWeight:  FontWeight.w700,
        color:       textPrimary,
      ),
      iconTheme: IconThemeData(color: textSecondary),
    ),

    cardTheme: CardTheme(
      color:        surfaceCard,
      elevation:    0,
      shape:        RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side:         const BorderSide(color: border, width: 1),
      ),
      margin: EdgeInsets.zero,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled:            true,
      fillColor:         surfaceElevated,
      contentPadding:    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:   const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:   const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:   const BorderSide(color: primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:   const BorderSide(color: error),
      ),
      hintStyle:  const TextStyle(fontFamily: _fontFamily, color: textDisabled, fontSize: 14),
      labelStyle: const TextStyle(fontFamily: _fontFamily, color: textSecondary, fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:   primary,
        foregroundColor:   textOnPrimary,
        elevation:         0,
        padding:           const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape:             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle:         const TextStyle(fontFamily: _fontFamily, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side:            const BorderSide(color: primary),
        padding:         const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape:           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle:       const TextStyle(fontFamily: _fontFamily, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor:    surfaceElevated,
      selectedColor:      primaryDim,
      side:               const BorderSide(color: border),
      labelStyle:         const TextStyle(fontFamily: _fontFamily, fontSize: 13, color: textPrimary),
      padding:            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape:              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      showCheckmark:      false,
    ),

    dividerTheme: const DividerThemeData(
      color:     border,
      thickness: 1,
      space:     1,
    ),

    switchTheme: SwitchThemeData(
      thumbColor:  MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected) ? primary : textSecondary),
      trackColor:  MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected) ? primaryDim : surfaceElevated),
    ),

    listTileTheme: const ListTileThemeData(
      tileColor:       Colors.transparent,
      iconColor:       textSecondary,
      textColor:       textPrimary,
      contentPadding:  EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor:      surfaceCard,
      surfaceTintColor:     Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceElevated,
      contentTextStyle: const TextStyle(fontFamily: _fontFamily, color: textPrimary, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// Convenient extension on BuildContext for quick theme access
extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme  get text  => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  // Direct access to Midnight Focus palette
  Color get mfPrimary         => MidnightFocusTheme.primary;
  Color get mfAccent          => MidnightFocusTheme.accent;
  Color get mfSurface         => MidnightFocusTheme.surface;
  Color get mfSurfaceElevated => MidnightFocusTheme.surfaceElevated;
  Color get mfBorder          => MidnightFocusTheme.border;
  Color get mfTextSecondary   => MidnightFocusTheme.textSecondary;
  Color get mfTextDisabled    => MidnightFocusTheme.textDisabled;
  Color get mfError           => MidnightFocusTheme.error;
  Color get mfSuccess         => MidnightFocusTheme.success;
  Color get mfWarning         => MidnightFocusTheme.warning;
}
