import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'storage_providers.dart';

part 'theme_mode_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  FutureOr<ThemeMode> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final modeStr = prefs.getString('theme_mode') ?? 'system';

    return ThemeMode.values.firstWhere(
      (m) => m.name == modeStr,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> toggleTheme() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);

    final newMode = switch (await future) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      _ => ThemeMode.light,
    };

    state = AsyncValue.data(newMode);
    await prefs.setString('theme_mode', newMode.name);
  }
}
