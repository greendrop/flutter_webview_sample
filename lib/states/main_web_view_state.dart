import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'main_web_view_state.freezed.dart';

@freezed
class MainWebViewState with _$MainWebViewState {
  factory MainWebViewState({WebViewController? controller}) = _MainWebViewState;
  const MainWebViewState._();
}

class MainWebViewStateNotifier extends StateNotifier<MainWebViewState> {
  MainWebViewStateNotifier(this.read) : super(MainWebViewState());

  final Reader read;

  void setController(WebViewController? controller) {
    state = state.copyWith(controller: controller);
  }
}
