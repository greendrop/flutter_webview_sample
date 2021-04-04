import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_sample/config/app_config.dart';

class NotificationDialog extends HookWidget {
  const NotificationDialog(this._mainWebViewController);

  final InAppWebViewController _mainWebViewController;

  static const webViewIndex = 0;
  static const progressIndex = 1;
  static InAppWebViewGroupOptions webViewOptions = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    final initialUrl = '${appConfig.baseUrl}/notifications/index.html';
    var index = progressIndex;

    return AlertDialog(
      title: const Text('Notification'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
            child: IndexedStack(index: index, children: <Widget>[
          InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
              initialOptions: webViewOptions,
              onWebViewCreated: (controller) {
                setState(() {
                  index = progressIndex;
                });
              },
              onLoadStart: (controller, url) {
                setState(() {
                  index = progressIndex;
                });
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final url = navigationAction.request.url!.toString();
                if (url == initialUrl) {
                  return NavigationActionPolicy.ALLOW;
                }
                await _mainWebViewController.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse(url)));
                Navigator.pop(context, 'CLOSE');
                return NavigationActionPolicy.CANCEL;
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  setState(() {
                    index = webViewIndex;
                  });
                }
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              }),
          Container(child: const Center(child: CircularProgressIndicator())),
        ]));
      }),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'CLOSE'),
          child: const Text('CLOSE'),
        ),
      ],
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
