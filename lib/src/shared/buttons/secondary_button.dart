import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import 'base_button.dart';

class SecondaryButton extends BaseButton {
  const SecondaryButton({
    required super.label,
    required super.onPressed,
    this.child,
    this.width,
    super.key,
  });
  final Widget? child;
  final double? width;

  @override
  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.secondaryButton,
          foregroundColor: AppColors.secondaryButton,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
          child:
              child ??
              Text(
                context.tr(label ?? ''),
                style: AppTextStyles.linkMedium.copyWith(
                  color: AppColors.buttonText,
                ),
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }
}
