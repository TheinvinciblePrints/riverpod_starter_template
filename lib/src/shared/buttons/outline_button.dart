import 'package:flutter/material.dart';

import 'base_button.dart';

class OutlineButtonVariant extends BaseButton {
  const OutlineButtonVariant({
    required super.label,
    required super.onPressed,
    super.key,
  });
  @override
  Widget buildButton(BuildContext context) =>
      OutlinedButton(onPressed: onPressed, child: Text(label));
}
