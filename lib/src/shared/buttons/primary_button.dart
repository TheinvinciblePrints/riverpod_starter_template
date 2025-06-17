import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/themes/themes.dart';

import 'base_button.dart';

class PrimaryButton extends BaseButton {
  const PrimaryButton({
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
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
          child:
              child ??
              Text(
                context.tr(label),
                style: AppTextStyles.linkMedium.copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }
}
