import 'env_dev.dart';
import 'env_prod.dart';
import 'env_staging.dart';

/// A base class that provides environment-specific configuration values
/// such as API URLs and feature toggles.
///
/// This class dynamically switches configurations based on the environment
/// name passed via [FlavorConfig.initialize], or from Dart defines.
abstract class Env {
  /// Holds the current environment name (e.g., 'dev', 'staging', or 'prod').
  /// Defaults to the Dart define value from `--dart-define=ENV=dev`, etc.
  static String envName = String.fromEnvironment('ENV');

  /// Returns true if the current environment is development.
  static bool get isDev => envName == 'dev';

  /// Returns true if the current environment is staging.
  static bool get isStaging => envName == 'staging';

  /// Returns true if the current environment is production.
  static bool get isProd => envName == 'prod';

  /// The base API URL for the current environment.
  ///
  /// This value is populated during [setEnv] call, based on the selected flavor.
  static late String dummyJsonApiUrl;
  static late String newsApiUrl;

  /// Sets the current environment and loads the appropriate config values.
  ///
  /// This should be called by [FlavorConfig.initialize].
  ///
  /// Throws an [Exception] if the environment is unknown.
  static void setEnv(String env) {
    envName = env;
    switch (env) {
      case 'dev':
        dummyJsonApiUrl = DevEnv.dummyJsonApiUrl;
        newsApiUrl = DevEnv.newsApiUrl;
        break;
      case 'staging':
        dummyJsonApiUrl = StagingEnv.dummyJsonApiUrl;
        newsApiUrl = StagingEnv.newsApiUrl;
        break;
      case 'prod':
        dummyJsonApiUrl = ProdEnv.dummyJsonApiUrl;
        newsApiUrl = StagingEnv.newsApiUrl;
       
        break;
      default:
        throw Exception('Unknown environment: $env');
    }
  }
}
