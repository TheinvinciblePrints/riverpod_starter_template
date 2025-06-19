import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/themes/themes.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    // textTheme: AppTextTheme.lightTextTheme,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.placeholder,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: AppTextStyles.textXSmall.copyWith(
        color: AppColors.primary,
      ),
      unselectedLabelStyle: AppTextStyles.textXSmall.copyWith(
        color: AppColors.bodyText,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      DesignSystemExtension.light,
      AppTextThemeExtension.light,
      AppColorThemeExtension.light,
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    // textTheme: AppTextTheme.darkTextTheme,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkBody,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: AppTextStyles.textXSmall.copyWith(
        color: AppColors.primary,
      ),
      unselectedLabelStyle: AppTextStyles.textXSmall.copyWith(
        color: AppColors.darkBody,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      DesignSystemExtension.dark,
      AppTextThemeExtension.dark,
      AppColorThemeExtension.dark,
    ],
  );
}
