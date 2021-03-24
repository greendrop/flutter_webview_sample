import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webview_sample/components/organisms/drawer_content.dart';
import 'package:flutter_webview_sample/components/organisms/navigation_controls.dart';
import 'package:flutter_webview_sample/components/organisms/notification_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends HookWidget {
  static const webViewIndex = 0;
  static const progressIndex = 1;

  @override
  Widget build(BuildContext context) {
    final mainWebViewController = useState<WebViewController>(null);
    final mainWebViewControllerCompleter =
        useState(Completer<WebViewController>());
    final index = useState(webViewIndex);

    useEffect(() {
      if (Platform.isAndroid) {
        WebView.platform = SurfaceAndroidWebView();
      }

      return () {};
    }, const []);

    return WillPopScope(
      onWillPop: () async {
        if (mainWebViewController.value != null &&
            await mainWebViewController.value.canGoBack()) {
          await mainWebViewController.value.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(title: Text('WebView Sample'), actions: <Widget>[
            NavigationControls(mainWebViewControllerCompleter.value.future),
            NotificationControls(mainWebViewControllerCompleter.value.future),
          ]),
          drawer: DrawerContent(),
          body: IndexedStack(index: index.value, children: <Widget>[
            WebView(
                initialUrl: 'https://www.yahoo.co.jp',
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  index.value = progressIndex;
                  mainWebViewController.value = webViewController;
                  mainWebViewControllerCompleter.value
                      .complete(webViewController);
                },
                onPageStarted: (String url) {
                  index.value = progressIndex;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(url),
                  ));
                },
                onPageFinished: (String url) {
                  index.value = webViewIndex;
                }),
            Container(child: Center(child: CircularProgressIndicator())),
          ])),
    );
  }
}
