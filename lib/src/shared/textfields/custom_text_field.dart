import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';

import '../../themes/themes.dart';

/// CustomTextFieldState defines the visual state of the text field
enum CustomTextFieldState { initial, active, typing, filled, disabled, error }

/// CustomTextFieldType defines the type of text field (primary or with icon)
enum CustomTextFieldType { primary, icon }

/// CustomTextField - supports all states and types as shown in the design
class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? errorText;
  final String? initialValue;
  final bool enabled;
  final bool obscureText;
  final CustomTextFieldState state;
  final CustomTextFieldType type;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Widget? icon;
  final VoidCallback? onClear;
  final Widget? suffixIcon;
  final Color? labelTextColor;

  const CustomTextField({
    super.key,
    this.labelText,
    this.errorText,
    this.initialValue,
    this.enabled = true,
    this.obscureText = false,
    this.state = CustomTextFieldState.initial,
    this.type = CustomTextFieldType.primary,
    this.onChanged,
    this.controller,
    this.icon,
    this.onClear,
    this.suffixIcon,
    this.labelTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    Color backgroundColor() {
      if (!enabled) {
        return isDarkMode
            ? AppColors.darkInputBackground
            : AppColors.disableInput;
      }
      if (state == CustomTextFieldState.error) {
        return AppColors.errorLight;
      }
      return isDarkMode ? AppColors.darkInputBackground : AppColors.white;
    }

    Color borderColor() {
      if (state == CustomTextFieldState.error) {
        return isDarkMode ? AppColors.errorDarkMode : AppColors.error;
      }
      if (!enabled) {
        return isDarkMode
            ? AppColors.darkInputBackground
            : AppColors.disableInput;
      }
      if (state == CustomTextFieldState.active ||
          state == CustomTextFieldState.typing) {
        return AppColors.primary;
      }
      return isDarkMode ? AppColors.darkInputBackground : AppColors.bodyText;
    }

    Color textColor() {
      if (!enabled) {
        return isDarkMode ? AppColors.darkBody : AppColors.placeholder;
      }
      if (state == CustomTextFieldState.error) {
        return isDarkMode ? AppColors.errorDarkMode : AppColors.error;
      }
      return isDarkMode ? AppColors.darkTitle : AppColors.titleActive;
    }

    Color iconColor() {
      if (!enabled) {
        return isDarkMode ? AppColors.darkBody : AppColors.placeholder;
      }
      if (state == CustomTextFieldState.error) {
        return isDarkMode ? AppColors.errorDarkMode : AppColors.error;
      }
      return isDarkMode ? AppColors.darkBody : AppColors.placeholder;
    }

    InputBorder border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: borderColor(), width: 1),
    );

    final showClear =
        (state == CustomTextFieldState.active ||
            state == CustomTextFieldState.typing ||
            state == CustomTextFieldState.error) &&
        enabled &&
        (onClear != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
          child: TextField(
            controller: controller,
            enabled: enabled,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            obscureText: obscureText,
            style: TextStyle(color: textColor(), fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor(),
              labelText: labelText,
              labelStyle: AppTextStyles.textSmall.copyWith(
                color: labelTextColor ?? textColor(),
              ),
              hintText:
                  state == CustomTextFieldState.disabled
                      ? 'Placeholder Text'
                      : null,
              hintStyle: TextStyle(color: iconColor()),
              prefixIcon:
                  type == CustomTextFieldType.icon
                      ? icon ?? Icon(Icons.search, color: iconColor())
                      : null,
              suffixIcon:
                  suffixIcon ??
                  (showClear
                      ? IconButton(
                        icon: Icon(Icons.close, color: iconColor()),
                        onPressed: onClear,
                      )
                      : null),
              enabledBorder: border(),
              focusedBorder: border(),
              disabledBorder: border(),
              errorBorder: border(),
              focusedErrorBorder: border(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        if (state == CustomTextFieldState.error && errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: isDarkMode ? AppColors.errorDarkMode : AppColors.error,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  errorText!,
                  style: context.textTheme.textSmall.copyWith(
                    color:
                        isDarkMode ? AppColors.errorDarkMode : AppColors.error,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
