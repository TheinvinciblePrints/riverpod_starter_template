import 'package:envied/envied.dart';

part 'env_dev.g.dart';

@Envied(
  name: 'DevEnv',
  path: '.env.dev',
  obfuscate: true,
  useConstantCase: true,
)
abstract class DevEnv {
  @EnviedField(varName: 'DUMMY_JSON_API_URL')
  static final String dummyJsonApiUrl = _DevEnv.dummyJsonApiUrl;
  @EnviedField(varName: 'NEWS_API_URL')
  static final String newsApiUrl = _DevEnv.newsApiUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _DevEnv.apiKey;
}

