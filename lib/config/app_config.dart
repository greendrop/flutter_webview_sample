import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

class AppConfig {
  factory AppConfig() => _instance;
  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();

  String env = 'local';
  bool displayEnv = false;
  String baseUrl = 'https://distracted-bassi-9dc276.netlify.app';

  Future<void> load() async {
    await dot_env.load(fileName: '.env');

    env = '';
    env = dot_env.env['ENV'].toString();
    displayEnv = env != 'prod';

    switch (env) {
      case 'prod':
        baseUrl = 'https://distracted-bassi-9dc276.netlify.app';
        break;
    }
  }
}
