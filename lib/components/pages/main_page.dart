import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webview_sample/components/organisms/drawer_content.dart';
import 'package:flutter_webview_sample/components/organisms/navigation_controls.dart';
import 'package:flutter_webview_sample/components/organisms/notification_controls.dart';
import 'package:flutter_webview_sample/config/app_config.dart';
import 'package:flutter_webview_sample/states/main_app_bar_state.dart';
import 'package:flutter_webview_sample/states/state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends HookWidget {
  static const webViewIndex = 0;
  static const progressIndex = 1;

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    final mainWebViewStateNotifier = useProvider(mainWebViewStateProvider);
    final mainWebViewState = useProvider(mainWebViewStateProvider.state);
    final mainAppBarStateNotifier = useProvider(mainAppBarStateProvider);
    final mainAppBarState = useProvider(mainAppBarStateProvider.state);
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
        if (mainWebViewState.controller != null &&
            await mainWebViewState.controller!.canGoBack()) {
          await mainWebViewState.controller!.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  if (!mainAppBarState.leadingEnabled) {
                    return Container();
                  }

                  return IconButton(
                    icon: Icon(mainAppBarState.backEnabled
                        ? Icons.arrow_back
                        : Icons.menu),
                    onPressed: () async {
                      if (mainAppBarState.backEnabled) {
                        final ref = mainAppBarState.backRef;
                        final url = ref.startsWith('/')
                            ? appConfig.envConfig.baseUrl + ref
                            : ref;
                        if (ref.startsWith('javascript:history.back()')) {
                          if (await mainWebViewState.controller!.canGoBack()) {
                            await mainWebViewState.controller!.goBack();
                          }
                        } else {
                          await mainWebViewState.controller!.loadUrl(url);
                        }
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                  );
                },
              ),
              title: Text(mainAppBarState.title),
              actions: <Widget>[
                NavigationControls(mainWebViewControllerCompleter.value.future),
                NotificationControls(
                    mainWebViewControllerCompleter.value.future),
              ]),
          drawer: DrawerContent(),
          body: IndexedStack(index: index.value, children: <Widget>[
            WebView(
                initialUrl: appConfig.envConfig.baseUrl,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                navigationDelegate: (NavigationRequest request) {
                  if (!request.url.startsWith(appConfig.envConfig.baseUrl)) {
                    _launchURL(request.url);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _clearAppBarState(mainAppBarStateNotifier);
                  index.value = progressIndex;
                  mainWebViewStateNotifier.setController(webViewController);
                  mainWebViewControllerCompleter.value
                      .complete(webViewController);
                },
                onPageStarted: (String url) {
                  _clearAppBarState(mainAppBarStateNotifier);
                  index.value = progressIndex;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(url),
                  ));
                },
                onPageFinished: (String url) async {
                  await _getAppBarState(
                      mainAppBarStateNotifier, mainWebViewState.controller!);
                  index.value = webViewIndex;
                }),
            Container(child: const Center(child: CircularProgressIndicator())),
          ])),
    );
  }

  void _clearAppBarState(MainAppBarStateNotifier stateNotifier) {
    stateNotifier
      ..setLeadingEnabled(false)
      ..setTitle('')
      ..setBackEnabled(false)
      ..setBackRef('');
  }

  Future<void> _getAppBarState(MainAppBarStateNotifier stateNotifier,
      WebViewController controller) async {
    var javascript = '';
    var result = '';

    javascript = "document.querySelector('.js-app-title').value";
    result = await controller.evaluateJavascript(javascript);
    stateNotifier.setTitle(result);

    javascript = "document.querySelector('.js-app-back-enabled').value";
    result = await controller.evaluateJavascript(javascript);
    stateNotifier
      ..setBackEnabled(result == 'true')
      ..setLeadingEnabled(true);

    javascript = "document.querySelector('.js-app-back-ref').value";
    result = await controller.evaluateJavascript(javascript);
    stateNotifier.setBackRef(result);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
