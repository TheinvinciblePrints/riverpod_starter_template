import 'package:flutter/material.dart';
import 'app_text_styles.dart';

class AppTextTheme {
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    titleLarge: AppTextStyles.displayLargeBold,
    titleMedium: AppTextStyles.displayMediumBold,
    titleSmall: AppTextStyles.displaySmallBold,
    bodyLarge: AppTextStyles.textLarge,
    bodyMedium: AppTextStyles.textMedium,
    bodySmall: AppTextStyles.textSmall,
    labelSmall: AppTextStyles.textXSmall,
  );

  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    titleLarge: AppTextStyles.displayLargeBold,
    titleMedium: AppTextStyles.displayMediumBold,
    titleSmall: AppTextStyles.displaySmallBold,
    bodyLarge: AppTextStyles.textLarge,
    bodyMedium: AppTextStyles.textMedium,
    bodySmall: AppTextStyles.textSmall,
    labelSmall: AppTextStyles.textXSmall,
  );
}
