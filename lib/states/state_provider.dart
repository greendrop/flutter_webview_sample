import 'package:flutter_webview_sample/states/main_app_bar_state.dart';
import 'package:flutter_webview_sample/states/main_web_view_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainWebViewStateProvider =
    StateNotifierProvider((ref) => MainWebViewStateNotifier(ref.read));
final mainAppBarStateProvider =
    StateNotifierProvider((ref) => MainAppBarStateNotifier(ref.read));
