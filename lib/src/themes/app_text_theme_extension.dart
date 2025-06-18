import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import 'app_colors.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  final TextStyle onboardingTitle;
  final TextStyle onboardingDescription;

  const AppTextThemeExtension({
    required this.onboardingTitle,
    required this.onboardingDescription,
  });

  @override
  AppTextThemeExtension copyWith({
    TextStyle? onboardingTitle,
    TextStyle? onboardingDescription,
  }) {
    return AppTextThemeExtension(
      onboardingTitle: onboardingTitle ?? this.onboardingTitle,
      onboardingDescription: onboardingDescription ?? this.onboardingDescription,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) return this;
    return AppTextThemeExtension(
      onboardingTitle: TextStyle.lerp(onboardingTitle, other.onboardingTitle, t)!,
      onboardingDescription: TextStyle.lerp(onboardingDescription, other.onboardingDescription, t)!,
    );
  }

  static final light = AppTextThemeExtension(
    onboardingTitle: AppTextStyles.displaySmallBold.copyWith(color: Colors.black),
    onboardingDescription: AppTextStyles.textMedium.copyWith(color: AppColors.bodyText),
  );

  static final dark = AppTextThemeExtension(
    onboardingTitle: AppTextStyles.displaySmallBold.copyWith(color: AppColors.white),
    onboardingDescription: AppTextStyles.textMedium.copyWith(color: AppColors.darkBody),
  );
}
