import 'package:flutter/material.dart';

import '../../themes/themes.dart';

extension DesignSystemContextExtension on BuildContext {
  DesignSystemExtension get ds =>
      Theme.of(this).extension<DesignSystemExtension>()!;
}

extension AppTextThemeX on BuildContext {
  AppTextThemeExtension get textTheme =>
      Theme.of(this).extension<AppTextThemeExtension>()!;

  AppColorThemeExtension get colorTheme =>
      Theme.of(this).extension<AppColorThemeExtension>()!;
}

extension ThemeModeContext on BuildContext {
  bool get isDarkMode => ThemeModeExtension.of(this).isDarkMode;
}

extension ScreenDimensions on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
