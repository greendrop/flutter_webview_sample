import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationControls extends HookWidget {
  const NotificationControls(this._mainWebViewControllerFuture)
      : assert(_mainWebViewControllerFuture != null);

  final Future<WebViewController> _mainWebViewControllerFuture;

  static const webViewIndex = 0;
  static const progressIndex = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _mainWebViewControllerFuture,
        builder:
            (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
          final bool mainWebViewReady =
              snapshot.connectionState == ConnectionState.done;
          final WebViewController mainWebViewController = snapshot.data;

          return Row(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: !mainWebViewReady
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              num index = 0;

                              return AlertDialog(
                                title: Text("Notification"),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                      child: IndexedStack(
                                          index: index,
                                          children: <Widget>[
                                        WebView(
                                          initialUrl:
                                              'https://news.google.com/',
                                          javascriptMode:
                                              JavascriptMode.unrestricted,
                                          gestureNavigationEnabled: true,
                                          navigationDelegate:
                                              (NavigationRequest request) {
                                            return NavigationDecision.navigate;
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
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator())),
                                      ]));
                                }),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("CLOSE"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                                contentPadding: EdgeInsets.all(0.0),
                              );
                            },
                          );
                        }),
            ],
          );
        });
  }
}
