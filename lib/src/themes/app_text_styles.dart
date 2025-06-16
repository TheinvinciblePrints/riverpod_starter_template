import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const String _fontFamily = 'Poppins';

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 72 / 48,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 48 / 32,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 36 / 24,
  );

  static const TextStyle displayLargeBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.12,
    height: 72 / 48,
  );

  static const TextStyle displayMediumBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.12,
    height: 48 / 32,
  );

  static const TextStyle displaySmallBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.12,
    height: 36 / 24,
  );

  // Text
  static const TextStyle textLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 30 / 20,
  );

  static const TextStyle textMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 24 / 16,
  );

  static const TextStyle textSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 21 / 14,
  );

  static const TextStyle textXSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 19.5 / 13,
  );

  // Link
  static const TextStyle linkLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.12,
    height: 30 / 20,
  );

  static const TextStyle linkMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.12,
    height: 24 / 16,
  );

  static const TextStyle linkSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.12,
    height: 21 / 14,
  );

  static const TextStyle linkXSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.12,
    height: 19.5 / 13,
  );
}
