import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/global_providers.dart';


part 'theme_mode_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  late SharedPreferences _prefs;

  @override
  FutureOr<ThemeMode> build() async {
    _prefs = await ref.watch(sharedPreferencesProvider.future);
    final modeStr = _prefs.getString('theme_mode') ?? 'system';

    return ThemeMode.values.firstWhere(
      (m) => m.name == modeStr,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> toggleTheme() async {
    final currentMode = state.value ?? ThemeMode.system;

    final newMode = switch (currentMode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      _ => ThemeMode.light,
    };

    state = AsyncValue.data(newMode);
    await _prefs.setString('theme_mode', newMode.name);
  }
}
