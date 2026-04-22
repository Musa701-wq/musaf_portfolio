import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color card = Color(0xFF1C2333);
  static const Color cardBorder = Color(0xFF30363D);
  static const Color border = Color(0xFF30363D);
  static const Color primary = Color(0xFF58A6FF);
  static const Color primaryLight = Color(0xFF79BEFF);
  static const Color accent = Color(0xFF3FB950);
  static const Color accentGreen = Color(0xFF3FB950);
  static const Color textPrimary = Color(0xFFE6EDF3);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF484F58);
  static const Color terminalGreen = Color(0xFF39D353);
}

class LightColors {
  static const Color background = Color(0xFFF6F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFD0D7DE);
  static const Color primary = Color(0xFF0969DA);
  static const Color primaryLight = Color(0xFF218BFF);
  static const Color accent = Color(0xFF1A7F37);
  static const Color accentGreen = Color(0xFF1A7F37);
  static const Color textPrimary = Color(0xFF1F2328);
  static const Color textSecondary = Color(0xFF656D76);
  static const Color textMuted = Color(0xFF9198A1);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
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
