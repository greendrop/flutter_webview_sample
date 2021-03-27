import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'main_app_bar_state.freezed.dart';

@freezed
class MainAppBarState with _$MainAppBarState {
  factory MainAppBarState(
      {@Default(false) bool leadingEnabled,
      @Default('') String title,
      @Default(false) bool backEnabled,
      @Default('') String backRef}) = _MainAppBarState;
  const MainAppBarState._();
}

class MainAppBarStateNotifier extends StateNotifier<MainAppBarState> {
  MainAppBarStateNotifier(this.read) : super(MainAppBarState());

  final Reader read;

  // ignore: avoid_positional_boolean_parameters
  void setLeadingEnabled(bool leadingEnabled) {
    state = state.copyWith(leadingEnabled: leadingEnabled);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  // ignore: avoid_positional_boolean_parameters
  void setBackEnabled(bool backEnabled) {
    state = state.copyWith(backEnabled: backEnabled);
  }

  void setBackRef(String backRef) {
    state = state.copyWith(backRef: backRef);
  }
}
