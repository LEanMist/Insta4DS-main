import 'package:flutter/material.dart';

class AppColors {
  static const Color purple = Color(0xFF6C3CE7);
  static const Color purpleDark = Color(0xFF4527A0);
  static const Color coral = Color(0xFFFF6B6B);
  static const Color coralLight = Color(0xFFFFE1E1);
  static const Color blue = Color(0xFF2F80ED);
  static const Color navy = Color(0xFF17213A);
  static const Color cream = Color(0xFFF8F7FC);
  static const Color ink = Color(0xFF25233A);
  static const Color muted = Color(0xFF77758A);
  static const Color white = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      brightness: Brightness.light,
      primary: AppColors.purple,
      secondary: AppColors.coral,
      surface: AppColors.cream,
    );

    return _theme(colorScheme, Brightness.light);
  }

  static ThemeData _theme(ColorScheme colorScheme, Brightness brightness) {
    final isLight = brightness == Brightness.light;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isLight ? AppColors.cream : AppColors.navy,
      canvasColor: AppColors.cream,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        indicatorColor: AppColors.purple.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE7E3F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.purple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: Size.fromHeight(52),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.purple,
          side: const BorderSide(color: AppColors.purple, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: Size.fromHeight(48),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w800),
        headlineMedium: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w800),
        titleLarge: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700),
        bodyMedium: const TextStyle(color: AppColors.muted, height: 1.5),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.navy,
        contentTextStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
    );
  }
}
