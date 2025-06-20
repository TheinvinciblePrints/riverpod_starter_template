import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  final TextStyle onboardingTitle;
  final TextStyle onboardingDescription;
  final TextStyle appStartUpErrorTitle;
  final TextStyle appStartUpErrorSubTitle;
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle displayLargeBold;
  final TextStyle displayMediumBold;
  final TextStyle displaySmallBold;
  final TextStyle textLarge;
  final TextStyle textMedium;
  final TextStyle textSmall;
  final TextStyle textXSmall;
  final TextStyle linkLarge;
  final TextStyle linkMedium;
  final TextStyle linkSmall;
  final TextStyle linkXSmall;
  final TextStyle errorText;

  const AppTextThemeExtension({
    required this.onboardingTitle,
    required this.onboardingDescription,
    required this.appStartUpErrorTitle,
    required this.appStartUpErrorSubTitle,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.displayLargeBold,
    required this.displayMediumBold,
    required this.displaySmallBold,
    required this.textLarge,
    required this.textMedium,
    required this.textSmall,
    required this.textXSmall,
    required this.linkLarge,
    required this.linkMedium,
    required this.linkSmall,
    required this.linkXSmall,
    required this.errorText,
  });

  @override
  AppTextThemeExtension copyWith({
    TextStyle? onboardingTitle,
    TextStyle? onboardingDescription,
    TextStyle? appStartUpErrorTitle,
    TextStyle? appStartUpErrorSubTitle,
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? displayLargeBold,
    TextStyle? displayMediumBold,
    TextStyle? displaySmallBold,
    TextStyle? textLarge,
    TextStyle? textMedium,
    TextStyle? textSmall,
    TextStyle? textXSmall,
    TextStyle? linkLarge,
    TextStyle? linkMedium,
    TextStyle? linkSmall,
    TextStyle? linkXSmall,
    TextStyle? errorText,
  }) {
    return AppTextThemeExtension(
      onboardingTitle: onboardingTitle ?? this.onboardingTitle,
      onboardingDescription:
          onboardingDescription ?? this.onboardingDescription,
      appStartUpErrorTitle: appStartUpErrorTitle ?? this.appStartUpErrorTitle,
      appStartUpErrorSubTitle:
          appStartUpErrorSubTitle ?? this.appStartUpErrorSubTitle,
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      displayLargeBold: displayLargeBold ?? this.displayLargeBold,
      displayMediumBold: displayMediumBold ?? this.displayMediumBold,
      displaySmallBold: displaySmallBold ?? this.displaySmallBold,
      textLarge: textLarge ?? this.textLarge,
      textMedium: textMedium ?? this.textMedium,
      textSmall: textSmall ?? this.textSmall,
      textXSmall: textXSmall ?? this.textXSmall,
      linkLarge: linkLarge ?? this.linkLarge,
      linkMedium: linkMedium ?? this.linkMedium,
      linkSmall: linkSmall ?? this.linkSmall,
      linkXSmall: linkXSmall ?? this.linkXSmall,
      errorText: errorText ?? this.errorText,
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
      appStartUpErrorSubTitle:
          TextStyle.lerp(
            appStartUpErrorSubTitle,
            other.appStartUpErrorSubTitle,
            t,
          )!,
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      displayLargeBold:
          TextStyle.lerp(displayLargeBold, other.displayLargeBold, t)!,
      displayMediumBold:
          TextStyle.lerp(displayMediumBold, other.displayMediumBold, t)!,
      displaySmallBold:
          TextStyle.lerp(displaySmallBold, other.displaySmallBold, t)!,
      textLarge: TextStyle.lerp(textLarge, other.textLarge, t)!,
      textMedium: TextStyle.lerp(textMedium, other.textMedium, t)!,
      textSmall: TextStyle.lerp(textSmall, other.textSmall, t)!,
      textXSmall: TextStyle.lerp(textXSmall, other.textXSmall, t)!,
      linkLarge: TextStyle.lerp(linkLarge, other.linkLarge, t)!,
      linkMedium: TextStyle.lerp(linkMedium, other.linkMedium, t)!,
      linkSmall: TextStyle.lerp(linkSmall, other.linkSmall, t)!,
      linkXSmall: TextStyle.lerp(linkXSmall, other.linkXSmall, t)!,
      errorText: TextStyle.lerp(errorText, other.errorText, t)!,
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
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    displayLargeBold: AppTextStyles.displayLargeBold.copyWith(
      color: AppColors.titleActive,
    ),
    displayMediumBold: AppTextStyles.displayMediumBold,
    displaySmallBold: AppTextStyles.displaySmallBold,
    textLarge: AppTextStyles.textLarge.copyWith(color: AppColors.bodyText),
    textMedium: AppTextStyles.textMedium,
    textSmall: AppTextStyles.textSmall.copyWith(color: AppColors.bodyText),
    textXSmall: AppTextStyles.textXSmall,
    linkLarge: AppTextStyles.linkLarge.copyWith(color: AppColors.primary),
    linkMedium: AppTextStyles.linkMedium.copyWith(color: AppColors.bodyText),
    linkSmall: AppTextStyles.linkSmall.copyWith(color: AppColors.primary),
    linkXSmall: AppTextStyles.linkXSmall.copyWith(color: AppColors.primary),
    errorText: AppTextStyles.textSmall.copyWith(
      color: AppColors.errorDark,
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
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    displayLargeBold: AppTextStyles.displayLargeBold.copyWith(
      color: AppColors.darkTitle,
    ),
    displayMediumBold: AppTextStyles.displayMediumBold,
    displaySmallBold: AppTextStyles.displaySmallBold,
    textLarge: AppTextStyles.textLarge.copyWith(color: AppColors.darkBody),
    textMedium: AppTextStyles.textMedium,
    textSmall: AppTextStyles.textSmall.copyWith(color: AppColors.darkBody),
    textXSmall: AppTextStyles.textXSmall,
    linkLarge: AppTextStyles.linkLarge.copyWith(color: AppColors.primary),
    linkMedium: AppTextStyles.linkMedium.copyWith(color: AppColors.bodyText),
    linkSmall: AppTextStyles.linkSmall.copyWith(color: AppColors.primary),
    linkXSmall: AppTextStyles.linkXSmall.copyWith(color: AppColors.primary),
    errorText: AppTextStyles.textSmall.copyWith(
      color: AppColors.errorDarkMode,
    ),
  );
}
