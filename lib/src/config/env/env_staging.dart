import 'package:envied/envied.dart';

part 'env_staging.g.dart';

@Envied(
  name: 'StagingEnv',
  path: '.env.staging',
  obfuscate: true,
  useConstantCase: true,
)
abstract class StagingEnv {
  @EnviedField(varName: 'DUMMY_JSON_API_URL')
  static final String dummyJsonApiUrl = _StagingEnv.dummyJsonApiUrl;
  @EnviedField(varName: 'NEWS_API_URL')
  static final String newsApiUrl = _StagingEnv.newsApiUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _StagingEnv.apiKey;
}
