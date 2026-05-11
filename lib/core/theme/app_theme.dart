import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        background: AppColors.backgroundLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.w700, color: AppColors.textLight),
        displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.w700, color: AppColors.textLight),
        headlineLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.textLight),
        titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.textLight),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark,
        error: AppColors.accent,
        background: AppColors.backgroundDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.w700, color: AppColors.textDark),
        displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.w700, color: AppColors.textDark),
        headlineLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.textDark),
        titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.textDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF2C2C35), width: 1),
        ),
      ),
    );
  }
}
