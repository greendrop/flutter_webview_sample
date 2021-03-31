import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NavigationControls extends HookWidget {
  const NavigationControls(this._mainWebViewControllerFuture);

  final Future<InAppWebViewController> _mainWebViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InAppWebViewController>(
      future: _mainWebViewControllerFuture,
      builder: (BuildContext context,
          AsyncSnapshot<InAppWebViewController> snapshot) {
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
