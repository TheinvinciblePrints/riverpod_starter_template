import 'package:flutter/material.dart';

import '../shared/tag_chip.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static TextTheme get _textTheme => TextTheme(
    headlineLarge: AppTextStyles.headlineLarge,
    headlineSmall: AppTextStyles.headlineSmall,
    titleMedium: AppTextStyles.titleMedium,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall(AppColors.grey3),
    labelSmall: AppTextStyles.labelSmall(AppColors.grey3),
    labelLarge: AppTextStyles.labelLarge(AppColors.grey3),
  );

  static InputDecorationTheme get _inputDecorationTheme =>
      InputDecorationTheme(hintStyle: AppTextStyles.hintStyle(AppColors.grey3));

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [
      TagChipTheme(
        chipColor: AppColors.whiteTransparent,
        onChipColor: Colors.white,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [
      TagChipTheme(
        chipColor: AppColors.blackTransparent,
        onChipColor: Colors.white,
      ),
    ],
  );
}
