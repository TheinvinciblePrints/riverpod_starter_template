import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'flavors.dart';
import 'src/app.dart';
import 'src/config/config.dart';
import 'src/localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Initialize environment configuration
  _initializeAppFlavor();

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();

  // * Initialize Firebase
  // * Uncomment the following lines if you are using Firebase
  // * Make sure to add the necessary Firebase dependencies in your pubspec.yaml
  // * and configure your Firebase project correctly.
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver()],
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
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  Env.setEnv(F.name); // Maps enum name to env string
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
