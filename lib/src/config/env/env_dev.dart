import 'package:envied/envied.dart';

part 'env_dev.g.dart';

@Envied(
  name: 'DevEnv',
  path: '.env.dev',
  obfuscate: true,
  useConstantCase: true,
)
abstract class DevEnv {
  @EnviedField(varName: 'API_URL')
  static final String apiUrl = _DevEnv.apiUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _DevEnv.apiKey;
}

