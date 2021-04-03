import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_sample/components/organisms/drawer_content.dart';
import 'package:flutter_webview_sample/components/organisms/navigation_controls.dart';
import 'package:flutter_webview_sample/components/organisms/notification_controls.dart';
import 'package:flutter_webview_sample/config/app_config.dart';
import 'package:flutter_webview_sample/states/main_app_bar_state.dart';
import 'package:flutter_webview_sample/states/state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends HookWidget {
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
    final mainWebViewStateNotifier = useProvider(mainWebViewStateProvider);
    final mainWebViewState = useProvider(mainWebViewStateProvider.state);
    final mainAppBarStateNotifier = useProvider(mainAppBarStateProvider);
    final mainAppBarState = useProvider(mainAppBarStateProvider.state);
    final mainWebViewControllerCompleter =
        useState(Completer<InAppWebViewController>());
    final index = useState(webViewIndex);
    final promptTextController = useState(TextEditingController());

    useEffect(() {
      return () {
        promptTextController.value.dispose();
      };
    }, []);

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
                        final url =
                            ref.startsWith('/') ? appConfig.baseUrl + ref : ref;
                        if (ref.startsWith('javascript:history.back()')) {
                          if (await mainWebViewState.controller!.canGoBack()) {
                            await mainWebViewState.controller!.goBack();
                          }
                        } else {
                          await mainWebViewState.controller!.loadUrl(
                              urlRequest: URLRequest(url: Uri.parse(url)));
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
            InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse(appConfig.baseUrl)),
                initialOptions: webViewOptions,
                onWebViewCreated: (controller) {
                  _clearAppBarState(mainAppBarStateNotifier);
                  index.value = progressIndex;
                  mainWebViewStateNotifier.setController(controller);
                  mainWebViewControllerCompleter.value.complete(controller);
                },
                onLoadStart: (controller, url) {
                  _clearAppBarState(mainAppBarStateNotifier);
                  index.value = progressIndex;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(url.toString()),
                  ));
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final url = navigationAction.request.url!.toString();
                  if (!url.startsWith(appConfig.baseUrl)) {
                    await _launchURL(url);
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
                onProgressChanged: (controller, progress) async {
                  if (progress == 100) {
                    await _getAppBarState(mainAppBarStateNotifier, controller);
                    index.value = webViewIndex;
                  }
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
                onJsAlert: (controller, jsAlertRequest) async {
                  final completer = Completer<JsAlertResponse?>();
                  final response = JsAlertResponse();
                  await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(jsAlertRequest.message.toString()),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'CLOSE'),
                              child: const Text('CLOSE'),
                            ),
                          ],
                        );
                      });
                  response.handledByClient = true;
                  completer.complete(response);
                  return completer.future;
                },
                onJsConfirm: (controller, jsConfirmRequest) async {
                  final completer = Completer<JsConfirmResponse>();
                  final response = JsConfirmResponse();
                  final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(jsConfirmRequest.message.toString()),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'CANCEL'),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                  response
                    ..handledByClient = true
                    ..action = result == 'OK'
                        ? JsConfirmResponseAction.CONFIRM
                        : JsConfirmResponseAction.CANCEL;
                  completer.complete(response);
                  return completer.future;
                },
                onJsPrompt: (controller, jsPromptRequest) async {
                  final completer = Completer<JsPromptResponse>();
                  final response = JsPromptResponse();
                  promptTextController.value.text = '';
                  final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: TextField(
                              controller: promptTextController.value,
                              decoration: InputDecoration(
                                hintText: jsPromptRequest.message.toString(),
                              ),
                              autofocus: true),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'CANCEL'),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                  response
                    ..handledByClient = true
                    ..value = promptTextController.value.text
                    ..action = result == 'OK'
                        ? JsPromptResponseAction.CONFIRM
                        : JsPromptResponseAction.CANCEL;
                  completer.complete(response);
                  return completer.future;
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
      InAppWebViewController controller) async {
    var javascript = '';
    dynamic result;

    javascript = "document.querySelector('.js-app-title').value";
    result = await controller.evaluateJavascript(source: javascript);
    stateNotifier.setTitle(result.toString());

    javascript = "document.querySelector('.js-app-back-enabled').value";
    result = await controller.evaluateJavascript(source: javascript);
    stateNotifier
      ..setBackEnabled(result.toString() == 'true')
      ..setLeadingEnabled(true);

    javascript = "document.querySelector('.js-app-back-ref').value";
    result = await controller.evaluateJavascript(source: javascript);
    stateNotifier.setBackRef(result.toString());
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
