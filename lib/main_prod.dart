import 'package:flutter/material.dart';
import 'package:flutter_webview_sample/app_root.dart';
import 'package:flutter_webview_sample/config/app_config.dart';
import 'package:flutter_webview_sample/config/environments/local.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  final _ = AppConfig()..envConfig = EnvConfigLocal();
  runApp(ProviderScope(child: AppRoot()));
}
