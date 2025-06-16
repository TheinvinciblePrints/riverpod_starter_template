import 'package:flutter/material.dart';

abstract final class AppColors {
  // Success
  static const Color success = Color(0xFF00BA88);
  static const Color successDark = Color(0xFF00966D);
  static const Color successLight = Color(0xFFF2FFFB);
  static const Color successDarkMode = Color(0xFF34EAB9);

  // Error
  static const Color error = Color(0xFFED2E7E);
  static const Color errorDark = Color(0xFFC30052);
  static const Color errorDarkMode = Color(0xFFFF84B7);
  static const Color errorLight = Color(0xFFFFF3F8);

  // Warning
  static const Color warning = Color(0xFFF4B740);
  static const Color warningDark = Color(0xFF946200);
  static const Color warningDarkMode = Color(0xFFFFD789);

  // Primary
  static const Color primary = Color(0xFF1877F2);

  // Grayscale
  static const Color white = Color(0xFFFFFFFF);
  static const Color titleActive = Color(0xFF050505);
  static const Color disableInput = Color(0xFFEEF1F4);
  static const Color bodyText = Color(0xFF4E4B66);
  static const Color placeholder = Color(0xFFA0A3BD);
  static const Color secondaryButton = Color(0xFFEEF1F4);
  static const Color buttonText = Color(0xFF667080);

  // Darkmode specific
  static const Color darkBackground = Color(0xFF1C1E21);
  static const Color darkTitle = Color(0xFFE4E6EB);
  static const Color darkBody = Color(0xFFB0B3B8);
  static const Color darkInputBackground = Color(0xFF3A3B3C);
}
