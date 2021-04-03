import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NavigationControls extends HookWidget {
  const NavigationControls(this._mainWebViewControllerFuture);

  final Future<InAppWebViewController> _mainWebViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(_mainWebViewControllerFuture, initialData: null);
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: !snapshot.hasData
              ? null
              : () {
                  final controller = snapshot.data;
                  controller!.reload();
                },
        ),
      ],
    );
  }
}
