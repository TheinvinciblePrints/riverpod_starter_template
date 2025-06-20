import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/shared/gap.dart';

import 'buttons/primary_button.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends ConsumerWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Gap(32),
            PrimaryButton(
              onPressed: () {
                // final isLoggedIn =
                //     ref.watch(authRepositoryProvider).currentUser != null;
                // context.goNamed(
                //     isLoggedIn ? AppRoute.jobs.name : AppRoute.signIn.name);
              },
              label: 'Go Home',
            ),
          ],
        ),
      ),
    );
  }
}
