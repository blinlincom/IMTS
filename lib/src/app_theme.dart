import 'package:flutter/material.dart';

class AppTheme {
  static const Color ink = Color(0xFF101820);
  static const Color mutedInk = Color(0xFF4F6070);
  static const Color line = Color(0xFFD7E0E8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color canvas = Color(0xFFF3F7F9);
  static const Color fog = Color(0xFFEAF1F4);
  static const Color teal = Color(0xFF0E7C7B);
  static const Color tealSoft = Color(0xFFDFF2EF);
  static const Color coral = Color(0xFFD95F48);
  static const Color coralSoft = Color(0xFFFBE9E4);
  static const Color amber = Color(0xFF9B6A05);
  static const Color amberSoft = Color(0xFFFFF2D4);
  static const Color blue = Color(0xFF315ED8);
  static const Color blueSoft = Color(0xFFE7EDFD);
  static const Color success = Color(0xFF208957);
  static const double radius = 8;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: teal,
      primary: teal,
      secondary: coral,
      tertiary: amber,
      surface: surface,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      visualDensity: VisualDensity.standard,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: surface,
        foregroundColor: ink,
        surfaceTintColor: surface,
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 19,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: const TextStyle(color: mutedInk),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: teal, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: teal,
          foregroundColor: surface,
          minimumSize: const Size(44, 40),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size(44, 40),
          side: const BorderSide(color: line),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: fog,
        selectedColor: tealSoft,
        disabledColor: fog,
        labelStyle: const TextStyle(
          color: ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        secondaryLabelStyle: const TextStyle(
          color: teal,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: tealSoft,
        surfaceTintColor: surface,
        height: 70,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? teal : mutedInk,
            size: 23,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            color: states.contains(WidgetState.selected) ? teal : mutedInk,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w500,
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: teal,
        textColor: ink,
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        subtitleTextStyle: TextStyle(
          color: mutedInk,
          fontSize: 13,
          height: 1.35,
        ),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: teal,
        collapsedIconColor: mutedInk,
        textColor: ink,
        collapsedTextColor: ink,
        childrenPadding: EdgeInsets.only(bottom: 8),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? teal
              : const Color(0xFF9AA8B5),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? tealSoft : fog,
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: ink,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          height: 1.12,
        ),
        titleLarge: TextStyle(
          color: ink,
          fontSize: 19,
          fontWeight: FontWeight.w800,
          height: 1.22,
        ),
        titleMedium: TextStyle(
          color: ink,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          height: 1.25,
        ),
        bodyMedium: TextStyle(color: ink, fontSize: 14, height: 1.45),
        labelMedium: TextStyle(
          color: mutedInk,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
