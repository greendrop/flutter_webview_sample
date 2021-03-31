import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'main_web_view_state.freezed.dart';

@freezed
class MainWebViewState with _$MainWebViewState {
  factory MainWebViewState({InAppWebViewController? controller}) =
      _MainWebViewState;
  const MainWebViewState._();
}

class MainWebViewStateNotifier extends StateNotifier<MainWebViewState> {
  MainWebViewStateNotifier(this.read) : super(MainWebViewState());

  final Reader read;

  void setController(InAppWebViewController? controller) {
    state = state.copyWith(controller: controller);
  }
}
