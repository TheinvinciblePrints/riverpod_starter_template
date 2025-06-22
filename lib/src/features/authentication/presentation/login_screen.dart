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

import '../../../routing/routing.dart';
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
      if (!mounted) return;

      // Add listeners to the controllers
      _usernameController.addListener(_onUsernameChanged);
      _passwordController.addListener(_onPasswordChanged);

      // Clean up startup providers now that we're on the login screen
      // This prevents provider disposal warnings and memory leaks
      final startupNotifier = ref.read(startupNotifierProvider.notifier);
      startupNotifier.disposeStartupAndDependents(ref);
    });
  }

  // Separate methods to handle text changes
  void _onUsernameChanged() {
    if (!mounted) return;

    // Use ref.read inside the callback to get the latest notifier instance
    ref
        .read(authenticationNotifierProvider.notifier)
        .setUsername(_usernameController.text);
  }

  void _onPasswordChanged() {
    if (!mounted) return;

    // Use ref.read inside the callback to get the latest notifier instance
    ref
        .read(authenticationNotifierProvider.notifier)
        .setPassword(_passwordController.text);
  }

  @override
  void dispose() {
    // Remove listeners before disposing controllers
    _usernameController.removeListener(_onUsernameChanged);
    _passwordController.removeListener(_onPasswordChanged);

    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  } // Helper method to safely perform login

  void _handleLogin() {
    if (!mounted) return;

    // Get the current notifier instance
    final authNotifier = ref.read(authenticationNotifierProvider.notifier);

    // Trim input values to ensure no extra whitespace
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Update the controller with trimmed values
    authNotifier.setUsername(username);
    authNotifier.setPassword(password);

    // Unfocus the keyboard before login
    FocusScope.of(context).unfocus();

    // The AuthenticationController.login() method already handles validation
    // and sets the appropriate error state if validation fails.
    // The authentication state listener will display the appropriate UI for errors.
    authNotifier.login();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authenticationNotifierProvider);
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

      // Show error messages in a snackbar only for non-validation errors
      if (current is AuthenticationUnauthenticated &&
          current.errorMessage != null) {
        // Define validation error messages that should be displayed inline
        final validationErrors = [
          LocaleKeys.auth_usernameEmpty.tr(),
          LocaleKeys.auth_passwordEmpty.tr(),
          LocaleKeys.auth_invalideUsername.tr(),
          LocaleKeys.auth_invalidPassword.tr(),
          LocaleKeys.auth_pleaseEnterValidUsername.tr(),
        ];

        // Only show non-validation errors in snackbar
        if (!validationErrors.contains(current.errorMessage)) {
          AnotherSnackbar.showError(context, message: current.errorMessage!);
        }
        // Validation errors are displayed inline in the form fields
      }

      // Show success message when authenticated
      if (current is AuthenticationAuthenticated) {
        // Update the startup state to reflect successful login
        // This will trigger the GoRouter's redirection logic
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          final startupNotifier = ref.read(startupNotifierProvider.notifier);
          startupNotifier.updateLoginState(true);
        });
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
                  isEnabled: !isLoading, // Disable input when loading
                  onChanged: (value) {
                    if (mounted) {
                      ref
                          .read(authenticationNotifierProvider.notifier)
                          .setUsername(value);
                    }
                  },
                ),
                const Gap(20),
                _PasswordInput(
                  controller: _passwordController,
                  errorText: errorText,
                  isEnabled: !isLoading, // Disable input when loading
                  onChanged: (value) {
                    if (mounted) {
                      ref
                          .read(authenticationNotifierProvider.notifier)
                          .setPassword(value);
                    }
                  },
                ),

                _ForgotPasswordButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                ),
                const Gap(10),
                PrimaryButton(
                  onPressed: isLoading ? null : _handleLogin,
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

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    required this.controller,
    required this.errorText,
    required this.onChanged,
    required this.isEnabled,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitleText(title: LocaleKeys.auth_username, isRequired: true),
        CustomTextField(
          enabled: isEnabled,
          controller: controller,
          errorText: _shouldDisplayUsernameError(errorText) ? errorText : null,
          state:
              _shouldDisplayUsernameError(errorText)
                  ? CustomTextFieldState.error
                  : CustomTextFieldState.initial,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Helper to determine if we should show username validation error
  bool _shouldDisplayUsernameError(String? error) {
    if (error == null) return false;

    // Check if this is a username-related error
    return error.contains('Username') ||
        error == LocaleKeys.auth_invalideUsername.tr() ||
        error == LocaleKeys.auth_pleaseEnterValidUsername.tr();
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    required this.controller,
    required this.errorText,
    required this.onChanged,
    required this.isEnabled,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitleText(title: LocaleKeys.auth_password, isRequired: true),
        PasswordTextField(
          enabled: isEnabled,
          controller: controller,
          errorText: _shouldDisplayPasswordError(errorText) ? errorText : null,
          state:
              _shouldDisplayPasswordError(errorText)
                  ? CustomTextFieldState.error
                  : CustomTextFieldState.initial,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Helper to determine if we should show password validation error
  bool _shouldDisplayPasswordError(String? error) {
    if (error == null) return false;

    // Check if this is a password-related error
    return error.contains('Password') ||
        error == LocaleKeys.auth_invalidPassword.tr();
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
