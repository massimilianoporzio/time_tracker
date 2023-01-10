import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'MY_API', obfuscate: true)
  static final myAPI = _Env.myAPI;
}
