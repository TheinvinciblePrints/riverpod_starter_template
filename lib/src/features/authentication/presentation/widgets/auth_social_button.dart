import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';

import '../../../../themes/themes.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({super.key, this.icon, this.label, this.onPressed});
  final Widget? icon;
  final String? label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.secondaryButton,
        overlayColor: Colors.transparent,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      icon: icon,
      label: Text(context.tr(label ?? ''), style: context.textTheme.linkMedium),
      onPressed: () {},
    );
  }
}
