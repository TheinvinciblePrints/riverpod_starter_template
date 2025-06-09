abstract class Env {
  static  String envName = String.fromEnvironment('ENV');

  static bool get isDev => envName == 'dev';
  static bool get isStaging => envName == 'staging';
  static bool get isProd => envName == 'prod';
}
