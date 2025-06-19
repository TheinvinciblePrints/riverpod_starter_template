import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import 'app_colors.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  final TextStyle onboardingTitle;
  final TextStyle onboardingDescription;
  final TextStyle appStartUpErrorTitle;
  final TextStyle appStartUpErrorSubTitle;

  const AppTextThemeExtension( {
    required this.onboardingTitle,
    required this.onboardingDescription,
    required this.appStartUpErrorTitle,
    required this.appStartUpErrorSubTitle,
  });

  @override
  AppTextThemeExtension copyWith({
    TextStyle? onboardingTitle,
    TextStyle? onboardingDescription,
    TextStyle? appStartUpErrorTitle,
    TextStyle? appStartUpErrorSubTitle,
  }) {
    return AppTextThemeExtension(
      onboardingTitle: onboardingTitle ?? this.onboardingTitle,
      onboardingDescription:
          onboardingDescription ?? this.onboardingDescription,
      appStartUpErrorTitle: appStartUpErrorTitle ?? this.appStartUpErrorTitle,
      appStartUpErrorSubTitle:
          appStartUpErrorSubTitle ?? this.appStartUpErrorSubTitle,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) return this;
    return AppTextThemeExtension(
      onboardingTitle:
          TextStyle.lerp(onboardingTitle, other.onboardingTitle, t)!,
      onboardingDescription:
          TextStyle.lerp(
            onboardingDescription,
            other.onboardingDescription,
            t,
          )!,
      appStartUpErrorTitle:
          TextStyle.lerp(appStartUpErrorTitle, other.appStartUpErrorTitle, t)!,
      appStartUpErrorSubTitle: TextStyle.lerp(
        appStartUpErrorSubTitle,
        other.appStartUpErrorSubTitle,
        t,
      )!,
    );
  }

  static final light = AppTextThemeExtension(
    onboardingTitle: AppTextStyles.displaySmallBold.copyWith(
      color: Colors.black,
    ),
    onboardingDescription: AppTextStyles.textMedium.copyWith(
      color: AppColors.bodyText,
    ),
    appStartUpErrorTitle: AppTextStyles.displayMediumBold.copyWith(
      color: AppColors.bodyText,
    ),
    appStartUpErrorSubTitle: AppTextStyles.textMedium.copyWith(
      color: AppColors.bodyText,
    ),
  );

  static final dark = AppTextThemeExtension(
    onboardingTitle: AppTextStyles.displaySmallBold.copyWith(
      color: AppColors.white,
    ),
    onboardingDescription: AppTextStyles.textMedium.copyWith(
      color: AppColors.darkBody,
    ),
    appStartUpErrorTitle: AppTextStyles.displayMediumBold.copyWith(
      color: AppColors.white,
    ),
    appStartUpErrorSubTitle: AppTextStyles.textMedium.copyWith(
      color: AppColors.darkBody,
    ),
  );
}
