import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle login logic here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login button pressed')),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
