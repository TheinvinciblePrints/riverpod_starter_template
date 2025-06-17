import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final bool enabled;
  final CustomTextFieldState state;
  final ValueChanged<String>? onChanged;
  final bool isDarkMode;

  const PasswordTextField({
    super.key,
    this.controller,
    this.labelText,
    this.errorText,
    this.enabled = true,
    this.state = CustomTextFieldState.initial,
    this.onChanged,
    this.isDarkMode = false,
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
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureNotifier,
      builder: (context, obscure, _) {
        return CustomTextField(
          controller: widget.controller,
          labelText: widget.labelText ?? 'Password',
          errorText: widget.errorText,
          enabled: widget.enabled,
          obscureText: obscure,
          state: widget.state,
          isDarkMode: widget.isDarkMode,
          onChanged: widget.onChanged,
          type: CustomTextFieldType.primary,
          icon: null,
          onClear: null,
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: widget.isDarkMode ? Colors.white70 : Colors.grey,
            ),
            onPressed: () => _obscureNotifier.value = !obscure,
          ),
        );
      },
    );
  }
}
