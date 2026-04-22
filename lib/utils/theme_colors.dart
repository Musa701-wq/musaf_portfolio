import 'package:flutter/material.dart';
import 'constants.dart';

class AppThemeColors {
  final Color background;
  final Color surface;
  final Color card;
  final Color cardBorder;
  final Color primary;
  final Color primaryLight;
  final Color accentGreen;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final bool isDark;

  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.card,
    required this.cardBorder,
    required this.primary,
    required this.primaryLight,
    required this.accentGreen,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.isDark,
  });

  static AppThemeColors of(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return dark ? _dark : _light;
  }

  static const _dark = AppThemeColors(
    background: AppColors.background,
    surface: AppColors.surface,
    card: AppColors.card,
    cardBorder: AppColors.cardBorder,
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    accentGreen: AppColors.accentGreen,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textMuted: AppColors.textMuted,
    isDark: true,
  );

  // non-const because LightColors fields are const but class itself isn't const-constructible at compile time in all contexts
  static final _light = AppThemeColors(
    background: LightColors.background,
    surface: LightColors.surface,
    card: LightColors.card,
    cardBorder: LightColors.cardBorder,
    primary: LightColors.primary,
    primaryLight: LightColors.primaryLight,
    accentGreen: LightColors.accentGreen,
    textPrimary: LightColors.textPrimary,
    textSecondary: LightColors.textSecondary,
    textMuted: LightColors.textMuted,
    isDark: false,
  );
}
