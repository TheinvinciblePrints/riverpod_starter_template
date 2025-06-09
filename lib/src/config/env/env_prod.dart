import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(name: 'ProdEnv', path: '.env.prod', obfuscate: true,useConstantCase: true,)
abstract class ProdEnv {
  @EnviedField(varName: 'API_URL')
  static final String apiUrl = _ProdEnv.apiUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _ProdEnv.apiKey;
}
