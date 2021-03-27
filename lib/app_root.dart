import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webview_sample/components/pages/main_page.dart';
import 'package:flutter_webview_sample/config/app_config.dart';

class AppRoot extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    if (!appConfig.envConfig.displayEnv) {
      return AppRootChild();
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
          color: Colors.red,
          message: appConfig.envConfig.env.toUpperCase(),
          location: BannerLocation.topStart,
          child: AppRootChild()),
    );
  }
}

class AppRootChild extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}
