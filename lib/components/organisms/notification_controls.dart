import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_sample/config/app_config.dart';

enum Answers {
  // ignore: constant_identifier_names
  CLOSE,
}

class NotificationControls extends HookWidget {
  const NotificationControls(this._mainWebViewControllerFuture);

  final Future<InAppWebViewController> _mainWebViewControllerFuture;

  static const webViewIndex = 0;
  static const progressIndex = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InAppWebViewController>(
        future: _mainWebViewControllerFuture,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> snapshot) {
          final webViewKey = GlobalKey();
          final options = InAppWebViewGroupOptions(
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
          final appConfig = AppConfig();
          final initialUrl =
              '${appConfig.envConfig.baseUrl}/notifications/index.html';
          final mainWebViewReady =
              snapshot.connectionState == ConnectionState.done;
          final mainWebViewController = snapshot.data;

          return Row(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: !mainWebViewReady
                      ? null
                      : () {
                          showDialog<Answers>(
                            context: context,
                            builder: (BuildContext context) {
                              var index = 0;

                              return AlertDialog(
                                title: const Text('Notification'),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                      child:
                                          IndexedStack(index: index, children: <
                                              Widget>[
                                    InAppWebView(
                                        key: webViewKey,
                                        initialUrlRequest: URLRequest(
                                            url: Uri.parse(initialUrl)),
                                        initialOptions: options,
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
                                        androidOnPermissionRequest: (controller,
                                            origin, resources) async {
                                          return PermissionRequestResponse(
                                              resources: resources,
                                              action:
                                                  // ignore: lines_longer_than_80_chars
                                                  PermissionRequestResponseAction
                                                      .GRANT);
                                        },
                                        shouldOverrideUrlLoading: (controller,
                                            navigationAction) async {
                                          final url = navigationAction
                                              .request.url!
                                              .toString();
                                          if (url == initialUrl) {
                                            return NavigationActionPolicy.ALLOW;
                                          }
                                          await mainWebViewController!.loadUrl(
                                              urlRequest: URLRequest(
                                                  url: Uri.parse(url)));
                                          Navigator.pop(context, Answers.CLOSE);
                                          return NavigationActionPolicy.CANCEL;
                                        },
                                        onProgressChanged:
                                            (controller, progress) {
                                          if (progress == 100) {
                                            setState(() {
                                              index = webViewIndex;
                                            });
                                          }
                                        },
                                        onConsoleMessage:
                                            (controller, consoleMessage) {
                                          print(consoleMessage);
                                        }),
                                    Container(
                                        child: const Center(
                                            child:
                                                // ignore: lines_longer_than_80_chars
                                                CircularProgressIndicator())),
                                  ]));
                                }),
                                actions: <Widget>[
                                  TextButton(
                                    // ignore: lines_longer_than_80_chars
                                    onPressed: () =>
                                        Navigator.pop(context, Answers.CLOSE),
                                    child: const Text('CLOSE'),
                                  ),
                                ],
                                contentPadding: const EdgeInsets.all(0),
                              );
                            },
                          );
                        }),
            ],
          );
        });
  }
}
