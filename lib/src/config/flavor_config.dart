import 'env/env.dart';

/// Defines the different environments (flavors) the app can run in.
enum Flavor { dev, staging, prod }

/// A configuration class that handles the initialization and state
/// management of the current environment (flavor) the app is using.
///
/// This class should be called during app startup to set the active flavor.
/// It internally delegates environment-specific configuration to [Env].
class FlavorConfig {
  static late Flavor _flavor;

  /// Initializes the current flavor and sets up corresponding environment variables.
  ///
  /// This method should be called once at the application startup.
  /// 
  /// Example:
  /// ```dart
  /// FlavorConfig.initialize(Flavor.dev);
  /// ```
  static void initialize(Flavor flavor) {
    _flavor = flavor;
    Env.setEnv(flavor.name); // Maps enum name to env string
  }

  /// Returns the currently active flavor.
  static Flavor get flavor => _flavor;

  /// Returns true if the current flavor is [Flavor.dev].
  static bool get isDev => _flavor == Flavor.dev;

  /// Returns true if the current flavor is [Flavor.staging].
  static bool get isStaging => _flavor == Flavor.staging;

  /// Returns true if the current flavor is [Flavor.prod].
  static bool get isProduction => _flavor == Flavor.prod;
}
