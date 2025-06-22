import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/themes/themes.dart';

import 'custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final bool enabled;
  final CustomTextFieldState state;
  final ValueChanged<String>? onChanged;

  const PasswordTextField({
    super.key,
    this.controller,
    this.labelText,
    this.errorText,
    this.enabled = true,
    this.state = CustomTextFieldState.initial,
    this.onChanged,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late final ValueNotifier<bool> _obscureNotifier;

  @override
  void initState() {
    super.initState();
    _obscureNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureNotifier,
      builder: (context, obscure, _) {
        return CustomTextField(
          controller: widget.controller,
          labelText: widget.labelText,
          errorText: widget.errorText,
          enabled: widget.enabled,
          obscureText: obscure,
          state: widget.state,
          onChanged: widget.onChanged,
          type: CustomTextFieldType.primary,
          icon: null,
          onClear: null,
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: isDarkMode ? AppColors.darkBody : AppColors.bodyText,
            ),
            onPressed: () => _obscureNotifier.value = !obscure,
          ),
        );
      },
    );
  }
}
