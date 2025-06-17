import 'package:flutter/material.dart';

class OnboardingDot extends StatelessWidget {
  final bool isActive;
  const OnboardingDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1877F2) : const Color(0xFFBFC9DA),
        shape: BoxShape.circle,
      ),
    );
  }
}
