import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webview_sample/components/pages/main_page.dart';
import 'package:flutter_webview_sample/config/app_config.dart';
import 'package:routemaster/routemaster.dart';

class AppRoot extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    if (!appConfig.displayEnv) {
      return AppRootMain();
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
          color: Colors.red,
          message: appConfig.env.toUpperCase(),
          location: BannerLocation.topStart,
          child: AppRootMain()),
    );
  }
}

class AppRootMain extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'WebView Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routeInformationParser: const RoutemasterParser(),
        routerDelegate: RoutemasterDelegate(
            routesBuilder: (context) => RouteMap(routes: {
                  '/': (_) => MaterialPage<Widget>(child: MainPage())
                })));
  }
}
