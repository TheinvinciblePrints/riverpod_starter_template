import 'package:envied/envied.dart';

part 'env_staging.g.dart';

@Envied(
  name: 'StagingEnv',
  path: '.env.staging',
  obfuscate: true,
  useConstantCase: true,
)
abstract class StagingEnv {
  @EnviedField(varName: 'API_URL')
  static final String apiUrl = _StagingEnv.apiUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _StagingEnv.apiKey;
}
