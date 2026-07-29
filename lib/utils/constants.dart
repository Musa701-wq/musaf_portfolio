import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color border = Color(0xFFE2E8F0);
  static const Color primary = Color(0xFF10B981); // Emerald Green
  static const Color primaryLight = Color(0xFF34D399); // Soft Emerald Green
  static const Color primaryDark = Color(0xFF047857); // Deep Green
  static const Color accent = Color(0xFF10B981);
  static const Color accentGreen = Color(0xFF059669);
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color greenTint = Color(0xFFECFDF5); // Emerald 50
  static const Color terminalGreen = Color(0xFF10B981);
}

class LightColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color primary = Color(0xFF10B981);
  static const Color primaryLight = Color(0xFF34D399);
  static const Color accent = Color(0xFF059669);
  static const Color accentGreen = Color(0xFF059669);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color greenTint = Color(0xFFECFDF5);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors.background,
    primaryColor: LightColors.primary,
    colorScheme: const ColorScheme.light(
      primary: LightColors.primary,
      secondary: LightColors.accent,
      surface: LightColors.surface,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: LightColors.textPrimary,
      displayColor: LightColors.textPrimary,
    ),
  );
}

