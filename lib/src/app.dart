import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/constants.dart';
import 'providers/storage_providers.dart';
import 'routing/routing.dart';
import 'themes/themes.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check and clear secure storage on reinstall
    // This should happen only once per fresh install
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearSecureStorageOnReinstall(ref);
    });

    final themeModeAsync = ref.watch(themeModeNotifierProvider);
    final goRouter = ref.watch(goRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeModeAsync.when(
            data: (themeMode) => themeMode,
            loading: () => ThemeMode.system,
            error: (err, stack) => ThemeMode.system,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // If you do not need to track screen views or analytics, you can remove GoRouterDelegateListener and use the child widget directly.
          builder:
              (context, child) => GoRouterDelegateListener(
                child: child ?? const AppStartupLoadingWidget(),
              ),
        );
      },
    );
  }

  /// Clears secure storage on app reinstallation to prevent stale credentials
  /// Uses provider-based services to maintain consistency with the app architecture
  Future<void> clearSecureStorageOnReinstall(WidgetRef ref) async {
    // Get preferences and secure storage from providers
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final secureStorage = ref.read(secureStorageServiceProvider);

    // Check if app has run before
    final bool isRunBefore =
        prefs.getBool(ConstantStrings.storageHasRunBefore) ?? false;

    if (!isRunBefore) {
      // Clear all secure storage to prevent stale credentials
      await secureStorage.clearAll();
      // Mark the app as having run before
      await prefs.setBool(ConstantStrings.storageHasRunBefore, true);
    }
  }
}
