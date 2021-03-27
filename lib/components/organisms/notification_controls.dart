import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webview_sample/config/app_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum Answers {
  // ignore: constant_identifier_names
  CLOSE,
}

class NotificationControls extends HookWidget {
  const NotificationControls(this._mainWebViewControllerFuture);

  final Future<WebViewController> _mainWebViewControllerFuture;

  static const webViewIndex = 0;
  static const progressIndex = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _mainWebViewControllerFuture,
        builder:
            (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
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
                                      child: IndexedStack(
                                          index: index,
                                          children: <Widget>[
                                        WebView(
                                          initialUrl: initialUrl,
                                          javascriptMode:
                                              JavascriptMode.unrestricted,
                                          gestureNavigationEnabled: true,
                                          navigationDelegate:
                                              (NavigationRequest request) {
                                            if (request.url == initialUrl) {
                                              return NavigationDecision
                                                  .navigate;
                                            }
                                            mainWebViewController!
                                                .loadUrl(request.url);
                                            Navigator.pop(
                                                context, Answers.CLOSE);
                                            return NavigationDecision.prevent;
                                          },
                                          onWebViewCreated: (WebViewController
                                              webViewController) {
                                            setState(() {
                                              index = progressIndex;
                                            });
                                          },
                                          onPageStarted: (String url) {
                                            setState(() {
                                              index = progressIndex;
                                            });
                                          },
                                          onPageFinished: (String url) {
                                            setState(() {
                                              index = webViewIndex;
                                            });
                                          },
                                        ),
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
