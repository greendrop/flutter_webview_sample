import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_sample/components/organisms/notification_dialog.dart';

class NotificationControls extends HookWidget {
  const NotificationControls(this._mainWebViewControllerFuture);

  final Future<InAppWebViewController> _mainWebViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(_mainWebViewControllerFuture, initialData: null);

    return Row(
      children: <Widget>[
        IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: !snapshot.hasData
                ? null
                : () {
                    final mainWebViewController = snapshot.data;
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return NotificationDialog(mainWebViewController!);
                      },
                    );
                  }),
      ],
    );
  }
}
