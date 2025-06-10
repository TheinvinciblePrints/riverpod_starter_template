// lib/core/config/flavor_config.dart

import 'env/env.dart';
import 'env/env_dev.dart';
import 'env/env_prod.dart';
import 'env/env_staging.dart';

enum Flavor { dev, staging, prod }

class FlavorConfig {
  static late Flavor _flavor;
  static late String _apiUrl;

  static void initialize(Flavor flavor) {
    _flavor = flavor;

    switch (flavor) {
      case Flavor.dev:
        Env.envName = 'dev';
        _apiUrl = DevEnv.apiUrl;
        break;
      case Flavor.staging:
        Env.envName = 'staging';
        _apiUrl = StagingEnv.apiUrl;
        break;
      case Flavor.prod:
        Env.envName = 'prod';
        _apiUrl = ProdEnv.apiUrl;
        break;
    }
  }

  static Flavor get flavor => _flavor;
  static String get apiUrl => _apiUrl;

  static bool get isDev => _flavor == Flavor.dev;
  static bool get isStaging => _flavor == Flavor.staging;
  static bool get isProduction => _flavor == Flavor.prod;
}
