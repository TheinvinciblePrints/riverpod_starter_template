import 'package:flutter/material.dart';

import 'app_shadows.dart';

class DesignSystemExtension extends ThemeExtension<DesignSystemExtension> {
  final List<BoxShadow> cardShadow;
  final List<BoxShadow> mobileShadow;
  final List<BoxShadow> barShadow;

  const DesignSystemExtension({
    required this.cardShadow,
    required this.mobileShadow,
    required this.barShadow,
  });

  @override
  DesignSystemExtension copyWith({
    List<BoxShadow>? cardShadow,
    List<BoxShadow>? mobileShadow,
    List<BoxShadow>? barShadow,
  }) {
    return DesignSystemExtension(
      cardShadow: cardShadow ?? this.cardShadow,
      mobileShadow: mobileShadow ?? this.mobileShadow,
      barShadow: barShadow ?? this.barShadow,
    );
  }

  @override
  ThemeExtension<DesignSystemExtension> lerp(
    covariant ThemeExtension<DesignSystemExtension>? other,
    double t,
  ) {
    if (other is! DesignSystemExtension) return this;
    return DesignSystemExtension(
      cardShadow: other.cardShadow,
      mobileShadow: other.mobileShadow,
      barShadow: other.barShadow,
    );
  }

  static const light = DesignSystemExtension(
    cardShadow: AppShadows.cardShadow,
    mobileShadow: AppShadows.mobileShadow,
    barShadow: AppShadows.barShadow,
  );

  static const dark = DesignSystemExtension(
    cardShadow: AppShadows.cardShadow, 
    mobileShadow: AppShadows.mobileShadow,
    barShadow: AppShadows.barShadow,
  );
}
