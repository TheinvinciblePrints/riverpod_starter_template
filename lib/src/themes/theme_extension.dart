import 'package:flutter/material.dart';

class ThemeModeExtension extends ThemeExtension<ThemeModeExtension> {
  final bool isDarkMode;

  const ThemeModeExtension({required this.isDarkMode});

  @override
  ThemeModeExtension copyWith({bool? isDarkMode}) {
    return ThemeModeExtension(isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  @override
  ThemeModeExtension lerp(ThemeExtension<ThemeModeExtension>? other, double t) {
    if (other is! ThemeModeExtension) {
      return this;
    }
    return ThemeModeExtension(isDarkMode: t < 0.5 ? isDarkMode : other.isDarkMode);
  }

  static ThemeModeExtension of(BuildContext context) {
    return Theme.of(context).extension<ThemeModeExtension>()!;
  }
}
