import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends HookWidget {
  const NavigationControls(this._mainWebViewControllerFuture);

  final Future<WebViewController> _mainWebViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _mainWebViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final mainWebViewReady =
            snapshot.connectionState == ConnectionState.done;
        final controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !mainWebViewReady ? null : controller!.reload,
            ),
          ],
        );
      },
    );
  }
}
