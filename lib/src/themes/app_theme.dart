import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';
import 'design_system_extension.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    textTheme: AppTextTheme.lightTextTheme,
    extensions: const <ThemeExtension<dynamic>>[DesignSystemExtension.light],
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.white,
      secondary: AppColors.secondaryButton,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.disableInput,
      hintStyle: TextStyle(color: AppColors.placeholder),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppTextTheme.darkTextTheme,
    extensions: const <ThemeExtension<dynamic>>[DesignSystemExtension.dark],
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primary,
      error: AppColors.errorDarkMode,
      surface: AppColors.darkBackground,
      secondary: AppColors.darkInputBackground,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputBackground,
      hintStyle: TextStyle(color: AppColors.placeholder),
    ),
  );
}
