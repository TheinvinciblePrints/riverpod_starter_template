import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/gen/assets.gen.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';

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
  bool _rememberMe = false;

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

    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('Hello', style: context.textTheme.displayLargeBold),
                Transform.translate(
                  offset: const Offset(0, -8),
                  child: Text(
                    'Again!',
                    style: context.textTheme.displayLargeBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),

                SizedBox(
                  width: 222,
                  child: Text(
                    "Welcome back you've been missed",
                    style: context.textTheme.textLarge,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username*',
                  errorText:
                      errorText == 'Invalid Username'
                          ? 'Please enter a valid username'
                          : null,
                  state:
                      errorText == 'Invalid Username'
                          ? CustomTextFieldState.error
                          : CustomTextFieldState.initial,
                  onChanged: notifier.setUsername,
                ),
                const SizedBox(height: 20),
                PasswordTextField(
                  controller: _passwordController,
                  labelText: 'Password*',
                  errorText:
                      errorText == 'Invalid Password'
                          ? 'Please enter a valid password'
                          : null,
                  state:
                      errorText == 'Invalid Password'
                          ? CustomTextFieldState.error
                          : CustomTextFieldState.initial,
                  onChanged: notifier.setPassword,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged:
                          (v) => setState(() => _rememberMe = v ?? false),
                      activeColor: Colors.blue,
                    ),
                    const Text('Remember me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        'Forgot the password ?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              await notifier.login();
                            },
                    child:
                        isLoading
                            ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                ),
                if (errorText != null &&
                    errorText != 'Invalid Username' &&
                    errorText != 'Invalid Password')
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.secondaryButton,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: AppAssets.icons.facebookIcon.svg(),
                        label: const Text(
                          'Facebook',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.secondaryButton,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: AppAssets.icons.googleIcon.svg(),
                        label: const Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("don't have an account ? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
