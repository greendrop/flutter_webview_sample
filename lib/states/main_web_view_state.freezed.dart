// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'main_web_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MainWebViewStateTearOff {
  const _$MainWebViewStateTearOff();

  _MainWebViewState call({WebViewController? controller}) {
    return _MainWebViewState(
      controller: controller,
    );
  }
}

/// @nodoc
const $MainWebViewState = _$MainWebViewStateTearOff();

/// @nodoc
mixin _$MainWebViewState {
  WebViewController? get controller => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainWebViewStateCopyWith<MainWebViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainWebViewStateCopyWith<$Res> {
  factory $MainWebViewStateCopyWith(
          MainWebViewState value, $Res Function(MainWebViewState) then) =
      _$MainWebViewStateCopyWithImpl<$Res>;
  $Res call({WebViewController? controller});
}

/// @nodoc
class _$MainWebViewStateCopyWithImpl<$Res>
    implements $MainWebViewStateCopyWith<$Res> {
  _$MainWebViewStateCopyWithImpl(this._value, this._then);

  final MainWebViewState _value;
  // ignore: unused_field
  final $Res Function(MainWebViewState) _then;

  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as WebViewController?,
    ));
  }
}

/// @nodoc
abstract class _$MainWebViewStateCopyWith<$Res>
    implements $MainWebViewStateCopyWith<$Res> {
  factory _$MainWebViewStateCopyWith(
          _MainWebViewState value, $Res Function(_MainWebViewState) then) =
      __$MainWebViewStateCopyWithImpl<$Res>;
  @override
  $Res call({WebViewController? controller});
}

/// @nodoc
class __$MainWebViewStateCopyWithImpl<$Res>
    extends _$MainWebViewStateCopyWithImpl<$Res>
    implements _$MainWebViewStateCopyWith<$Res> {
  __$MainWebViewStateCopyWithImpl(
      _MainWebViewState _value, $Res Function(_MainWebViewState) _then)
      : super(_value, (v) => _then(v as _MainWebViewState));

  @override
  _MainWebViewState get _value => super._value as _MainWebViewState;

  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_MainWebViewState(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as WebViewController?,
    ));
  }
}

/// @nodoc
class _$_MainWebViewState extends _MainWebViewState {
  _$_MainWebViewState({this.controller}) : super._();

  @override
  final WebViewController? controller;

  @override
  String toString() {
    return 'MainWebViewState(controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MainWebViewState &&
            (identical(other.controller, controller) ||
                const DeepCollectionEquality()
                    .equals(other.controller, controller)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(controller);

  @JsonKey(ignore: true)
  @override
  _$MainWebViewStateCopyWith<_MainWebViewState> get copyWith =>
      __$MainWebViewStateCopyWithImpl<_MainWebViewState>(this, _$identity);
}

abstract class _MainWebViewState extends MainWebViewState {
  factory _MainWebViewState({WebViewController? controller}) =
      _$_MainWebViewState;
  _MainWebViewState._() : super._();

  @override
  WebViewController? get controller => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MainWebViewStateCopyWith<_MainWebViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
