import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/presentation/widgets/auth_social_button.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/presentation/widgets/text_field_title_text.dart';
import 'package:flutter_riverpod_starter_template/src/gen/assets.gen.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';
import 'package:flutter_riverpod_starter_template/src/shared/buttons/primary_button.dart';
import 'package:flutter_riverpod_starter_template/src/shared/form_loader.dart';
import 'package:flutter_riverpod_starter_template/src/utils/another_snackbar.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';

import '../../../shared/gap.dart';
import '../../../shared/textfields/custom_text_field.dart';
import '../../../shared/textfields/password_text_field.dart';
import '../../../themes/themes.dart';
import 'authentication_controller.dart';
import 'authentication_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthenticationState? _previousState;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with values from current state if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(authenticationNotifierProvider.notifier);
      _usernameController.addListener(() {
        notifier.setUsername(_usernameController.text);
      });
      _passwordController.addListener(() {
        notifier.setPassword(_passwordController.text);
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authenticationNotifierProvider);
    final notifier = ref.read(authenticationNotifierProvider.notifier);
    final isLoading = state is AuthenticationLoading;
    final errorText =
        state is AuthenticationUnauthenticated ? state.errorMessage : null;

    // Listen for state changes to show snackbars for errors
    ref.listen<AuthenticationState>(authenticationNotifierProvider, (
      previous,
      current,
    ) {
      // Store previous state to avoid duplicate messages
      if (_previousState == current) return;
      _previousState = current;

      // Show error messages in a snackbar
      if (current is AuthenticationUnauthenticated &&
          current.errorMessage != null &&
          current.errorMessage != LocaleKeys.auth_invalideUsername.tr() &&
          current.errorMessage != LocaleKeys.auth_invalidPassword.tr()) {
        AnotherSnackbar.showError(context, message: current.errorMessage!);
      }

      // Show success message when authenticated
      if (current is AuthenticationAuthenticated) {
        AnotherSnackbar.showSuccess(context, message: 'Successfully logged in');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Text(
                  context.tr(LocaleKeys.auth_hello),
                  style: context.textTheme.displayLargeBold,
                ),
                Transform.translate(
                  offset: const Offset(0, -8),
                  child: Text(
                    context.tr(LocaleKeys.auth_again),
                    style: context.textTheme.displayLargeBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),

                SizedBox(
                  width: 222,
                  child: Text(
                    context.tr(LocaleKeys.auth_welcomeBack),
                    style: context.textTheme.textLarge,
                  ),
                ),
                const Gap(32),
                _UsernameInput(
                  controller: _usernameController,
                  errorText: errorText,
                  onChanged: notifier.setUsername,
                ),
                const Gap(20),
                _PasswordInput(
                  controller: _passwordController,
                  errorText: errorText,
                  onChanged: notifier.setPassword,
                ),

                _ForgotPasswordButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                ),
                const Gap(10),
                PrimaryButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            // Trim input values to ensure no extra whitespace
                            notifier.setUsername(
                              _usernameController.text.trim(),
                            );
                            notifier.setPassword(
                              _passwordController.text.trim(),
                            );

                            // Unfocus the keyboard before login
                            FocusScope.of(context).unfocus();

                            // Perform login
                            notifier.login();
                          },
                  child:
                      isLoading
                          ? const FormLoader()
                          : Text(
                            context.tr(LocaleKeys.auth_login),
                            style: AppTextStyles.linkMedium.copyWith(
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                ),
                // We're now using snackbars for error messages instead of inline text
                const Gap(16),
                Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      context.tr(LocaleKeys.auth_continueWith),
                      style: context.textTheme.textSmall,
                    ),
                  ),
                ),
                const Gap(16),
                Row(
                  children: [
                    Expanded(
                      child: AuthSocialButton(
                        icon: AppAssets.icons.facebookIcon.svg(),
                        label: LocaleKeys.auth_facebook,
                        onPressed: () {},
                      ),
                    ),
                    const Gap(31),
                    Expanded(
                      child: AuthSocialButton(
                        icon: AppAssets.icons.googleIcon.svg(),
                        label: LocaleKeys.auth_google,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr(LocaleKeys.auth_dontHaveAnAccount),
                      style: context.textTheme.textSmall,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        context.tr(LocaleKeys.auth_signUp),
                        style: context.textTheme.linkSmall,
                      ),
                    ),
                  ],
                ),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends ConsumerWidget {
  const _UsernameInput({
    required this.controller,
    required this.errorText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authenticationNotifierProvider);
    final isLoading = state is AuthenticationLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitleText(title: LocaleKeys.auth_username, isRequired: true),
        CustomTextField(
          enabled: !isLoading,
          controller: controller,
          errorText:
              errorText == LocaleKeys.auth_invalideUsername.tr()
                  ? LocaleKeys.auth_pleaseEnterValidUsername.tr()
                  : null,
          state:
              errorText == LocaleKeys.auth_invalideUsername.tr()
                  ? CustomTextFieldState.error
                  : CustomTextFieldState.initial,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _PasswordInput extends ConsumerWidget {
  const _PasswordInput({
    required this.controller,
    required this.errorText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authenticationNotifierProvider);
    final isLoading = state is AuthenticationLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitleText(title: LocaleKeys.auth_password, isRequired: true),
        PasswordTextField(
          enabled: !isLoading,
          controller: controller,
          errorText:
              errorText == LocaleKeys.auth_invalidPassword.tr()
                  ? LocaleKeys.auth_pleaseEnterValidPassword.tr()
                  : null,
          state:
              errorText == LocaleKeys.auth_invalidPassword.tr()
                  ? CustomTextFieldState.error
                  : CustomTextFieldState.initial,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          overlayColor: Colors.transparent,
        ),
        child: Text(
          context.tr(LocaleKeys.auth_forgotPassword),
          style: context.textTheme.textSmall.copyWith(
            color: AppColors.forgotPassword,
          ),
        ),
      ),
    );
  }
}
