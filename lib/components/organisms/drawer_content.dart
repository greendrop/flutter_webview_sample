import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_sample/config/app_config.dart';
import 'package:flutter_webview_sample/states/state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

class DrawerContent extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    final mainWebViewState = useProvider(mainWebViewStateProvider.state);

    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'WebView Sample',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: mainWebViewState.controller == null
                ? null
                : () {
                    Navigator.pop(context);
                    final url = appConfig.baseUrl;
                    mainWebViewState.controller
                        ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
                  },
          ),
          ListTile(
            title: const Text('Orders'),
            onTap: mainWebViewState.controller == null
                ? null
                : () {
                    Navigator.pop(context);
                    final url = '${appConfig.baseUrl}/orders/index.html';
                    mainWebViewState.controller
                        ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
                  },
          ),
          ListTile(
            title: const Text('News'),
            onTap: mainWebViewState.controller == null
                ? null
                : () {
                    Navigator.pop(context);
                    final url = '${appConfig.baseUrl}/news/index.html';
                    mainWebViewState.controller
                        ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
                  },
          ),
          ListTile(
            title: const Text('Forms'),
            onTap: mainWebViewState.controller == null
                ? null
                : () {
                    Navigator.pop(context);
                    final url = '${appConfig.baseUrl}/forms/index.html';
                    mainWebViewState.controller
                        ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
                  },
          ),
          ListTile(
            title: const Text('Javascript'),
            onTap: mainWebViewState.controller == null
                ? null
                : () {
                    Navigator.pop(context);
                    final url = '${appConfig.baseUrl}/javascript/index.html';
                    mainWebViewState.controller
                        ?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
                  },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () async {
              final packageInfo = await PackageInfo.fromPlatform();
              showAboutDialog(
                context: context,
                applicationVersion: packageInfo.version,
                applicationIcon: AppIcon(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppIcon extends HookWidget {
  static const size = 32.0;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: size,
          height: size,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
