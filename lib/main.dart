import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flavors.dart';
import 'src/app.dart';
import 'src/config/config.dart';
import 'src/localization/localization.dart';
import 'src/providers/riverpod_logger_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  _initializeAppFlavor();
  registerErrorHandlers();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      observers: [
        // Create a custom LoggerProviderObserver that will get the logger from the provider
        RiverpodLoggerObserver(),
      ],
      child: EasyLocalization(
        supportedLocales: supportedLocales.keys.toList(),
        path: 'assets/translations',
        fallbackLocale: englishUs,
        useFallbackTranslations: true,
        child: const MyApp(),
      ),
    ),
  );
}

void _initializeAppFlavor() {
  // Default to dev flavor if not specified
  const String defaultFlavor = 'dev';
  const String appFlavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: defaultFlavor,
  );

  FlavorConfig.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.dev, // Default to dev if not found
  );

  // Maps enum name to env string
  Env.setEnv(FlavorConfig.name);
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
