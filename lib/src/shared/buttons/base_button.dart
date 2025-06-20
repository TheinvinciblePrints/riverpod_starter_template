import 'package:flutter/material.dart';

/// BaseButton - An abstract customizable button that supports styling and reuse.
///
/// ✅ Follows SOLID principles:
/// - SRP: `BaseButton` handles layout logic only; each subclass handles its own visual identity.
/// - OCP: You can extend it with new buttons (PrimaryButton, SecondaryButton, etc.) without modifying this class.
///
/// Usage: Extend this class to create custom button types with consistent behavior.
abstract class BaseButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;

  const BaseButton({super.key, required this.label, required this.onPressed});

  Widget buildButton(BuildContext context); // Abstract method

  @override
  Widget build(BuildContext context) {
    return buildButton(context);
  }
}
