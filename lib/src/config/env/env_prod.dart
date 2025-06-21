import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(
  name: 'ProdEnv',
  path: '.env.prod',
  obfuscate: true,
  useConstantCase: true,
)
abstract class ProdEnv {
  @EnviedField(varName: 'DUMMY_JSON_API_URL')
  static final String dummyJsonApiUrl = _ProdEnv.dummyJsonApiUrl;
  @EnviedField(varName: 'NEWS_API_URL')
  static final String newsApiUrl = _ProdEnv.newsApiUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _ProdEnv.apiKey;
}
