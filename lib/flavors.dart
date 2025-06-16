enum Flavor { dev, staging, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  /// Returns true if the current flavor is [Flavor.dev].
  static bool get isDev => appFlavor == Flavor.dev;

  /// Returns true if the current flavor is [Flavor.staging].
  static bool get isStaging => appFlavor == Flavor.staging;

  /// Returns true if the current flavor is [Flavor.prod].
  static bool get isProduction => appFlavor == Flavor.prod;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '[DEV] News App';
      case Flavor.staging:
        return '[STG] News App';
      case Flavor.prod:
        return 'News App';
    }
  }
}
