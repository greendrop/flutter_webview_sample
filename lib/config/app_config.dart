class AppConfig {
  factory AppConfig() => _instance;
  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();
  late EnvConfig envConfig;
}

abstract class EnvConfig {
  late String env;
  late bool displayEnv;
  late String baseUrl;
}
