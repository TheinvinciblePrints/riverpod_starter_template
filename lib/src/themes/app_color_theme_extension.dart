import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/themes/app_colors.dart';

class AppColorThemeExtension extends ThemeExtension<AppColorThemeExtension> {

  final Color dotActiveColor;
  final Color dotInactiveColor;

  const AppColorThemeExtension({
    required this.dotActiveColor,
    required this.dotInactiveColor,
  });

  @override
  AppColorThemeExtension copyWith({
    Color? dotActiveColor,
    Color? dotInactiveColor,
  }) {
    return AppColorThemeExtension(
      dotActiveColor: dotActiveColor ?? this.dotActiveColor,
      dotInactiveColor: dotInactiveColor ?? this.dotInactiveColor,
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
      dotInactiveColor: Color.lerp(dotInactiveColor, other.dotInactiveColor, t)!,
    );    
  }   

  static final light = AppColorThemeExtension(
    dotActiveColor: AppColors.primary,
    dotInactiveColor: AppColors.placeholder,
  );

  static final dark = AppColorThemeExtension(
    dotActiveColor: AppColors.primary,
    dotInactiveColor: AppColors.placeholder,
  );
  
}
