import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/themes/app_colors.dart';

class AppColorThemeExtension extends ThemeExtension<AppColorThemeExtension> {
  final Color dotActiveColor;
  final Color dotInactiveColor;
  final Color searchIconColor;
  final Color? searchLabelColor;

  const AppColorThemeExtension({
    required this.dotActiveColor,
    required this.dotInactiveColor,
    required this.searchIconColor,
    required this.searchLabelColor,
  });

  @override
  AppColorThemeExtension copyWith({
    Color? dotActiveColor,
    Color? dotInactiveColor,
    Color? searchIconColor,
    Color? searchLabelColor,
  }) {
    return AppColorThemeExtension(
      dotActiveColor: dotActiveColor ?? this.dotActiveColor,
      dotInactiveColor: dotInactiveColor ?? this.dotInactiveColor,
      searchIconColor: searchIconColor ?? this.searchIconColor,
      searchLabelColor: searchLabelColor ?? this.searchLabelColor,
    );
  }

  @override
  ThemeExtension<AppColorThemeExtension> lerp(
    covariant ThemeExtension<AppColorThemeExtension>? other,
    double t,
  ) {
    if (other is! AppColorThemeExtension) return this;
    return AppColorThemeExtension(
      dotActiveColor: Color.lerp(dotActiveColor, other.dotActiveColor, t)!,
      dotInactiveColor:
          Color.lerp(dotInactiveColor, other.dotInactiveColor, t)!,
      searchIconColor: Color.lerp(searchIconColor, other.searchIconColor, t)!,
      searchLabelColor:
          Color.lerp(searchLabelColor, other.searchLabelColor, t)!,
    );
  }

  static final light = AppColorThemeExtension(
    dotActiveColor: AppColors.primary,
    dotInactiveColor: AppColors.placeholder,
    searchIconColor: AppColors.bodyText,
    searchLabelColor: AppColors.placeholder,
  );

  static final dark = AppColorThemeExtension(
    dotActiveColor: AppColors.primary,
    dotInactiveColor: AppColors.placeholder,
    searchIconColor: AppColors.darkBody,
    searchLabelColor: AppColors.white,
  );
}
