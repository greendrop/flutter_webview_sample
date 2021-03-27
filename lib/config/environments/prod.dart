import 'package:flutter_webview_sample/config/app_config.dart';

class EnvConfigProd implements EnvConfig {
  @override
  String env = 'prod';
  @override
  bool displayEnv = false;
  @override
  String baseUrl = 'https://distracted-bassi-9dc276.netlify.app';
}
