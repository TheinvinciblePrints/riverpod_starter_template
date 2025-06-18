import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';

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
        color: isActive ? context.colorTheme.dotActiveColor : context.colorTheme.dotInactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
