import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/global_providers.dart';
import 'routing/routing.dart';
import 'themes/themes.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeNotifierProvider);
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeAsync.when(
        data: (themeMode) => themeMode,
        loading: () => ThemeMode.system,
        error: (err, stack) => ThemeMode.system,
      ),
      builder: (context, child) {
        return Scaffold(body: Center(child: Text('Hello World!')));
      },
    );
  }
}
