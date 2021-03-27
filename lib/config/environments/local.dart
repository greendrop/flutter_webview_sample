import 'package:flutter_webview_sample/config/app_config.dart';

class EnvConfigLocal implements EnvConfig {
  @override
  String env = 'local';
  @override
  bool displayEnv = true;
  @override
  String baseUrl = 'https://distracted-bassi-9dc276.netlify.app';
}
