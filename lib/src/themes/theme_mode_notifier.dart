import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/global_providers.dart';
import '../storage/storage.dart';

part 'theme_mode_notifier.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  late IPreferenceStorage _prefs;

  @override
  FutureOr<ThemeMode> build() async {
    _prefs = await ref.watch(preferenceStorageServiceProvider.future);
    final modeStr = _prefs.getThemeMode();

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
    await _prefs.setThemeMode(newMode.name);
  }
}
