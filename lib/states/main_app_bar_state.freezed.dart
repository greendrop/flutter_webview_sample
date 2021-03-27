// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'main_app_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MainAppBarStateTearOff {
  const _$MainAppBarStateTearOff();

  _MainAppBarState call(
      {String title = '', bool backEnabled = false, String backRef = ''}) {
    return _MainAppBarState(
      title: title,
      backEnabled: backEnabled,
      backRef: backRef,
    );
  }
}

/// @nodoc
const $MainAppBarState = _$MainAppBarStateTearOff();

/// @nodoc
mixin _$MainAppBarState {
  String get title => throw _privateConstructorUsedError;
  bool get backEnabled => throw _privateConstructorUsedError;
  String get backRef => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainAppBarStateCopyWith<MainAppBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainAppBarStateCopyWith<$Res> {
  factory $MainAppBarStateCopyWith(
          MainAppBarState value, $Res Function(MainAppBarState) then) =
      _$MainAppBarStateCopyWithImpl<$Res>;
  $Res call({String title, bool backEnabled, String backRef});
}

/// @nodoc
class _$MainAppBarStateCopyWithImpl<$Res>
    implements $MainAppBarStateCopyWith<$Res> {
  _$MainAppBarStateCopyWithImpl(this._value, this._then);

  final MainAppBarState _value;
  // ignore: unused_field
  final $Res Function(MainAppBarState) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? backEnabled = freezed,
    Object? backRef = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      backEnabled: backEnabled == freezed
          ? _value.backEnabled
          : backEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      backRef: backRef == freezed
          ? _value.backRef
          : backRef // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MainAppBarStateCopyWith<$Res>
    implements $MainAppBarStateCopyWith<$Res> {
  factory _$MainAppBarStateCopyWith(
          _MainAppBarState value, $Res Function(_MainAppBarState) then) =
      __$MainAppBarStateCopyWithImpl<$Res>;
  @override
  $Res call({String title, bool backEnabled, String backRef});
}

/// @nodoc
class __$MainAppBarStateCopyWithImpl<$Res>
    extends _$MainAppBarStateCopyWithImpl<$Res>
    implements _$MainAppBarStateCopyWith<$Res> {
  __$MainAppBarStateCopyWithImpl(
      _MainAppBarState _value, $Res Function(_MainAppBarState) _then)
      : super(_value, (v) => _then(v as _MainAppBarState));

  @override
  _MainAppBarState get _value => super._value as _MainAppBarState;

  @override
  $Res call({
    Object? title = freezed,
    Object? backEnabled = freezed,
    Object? backRef = freezed,
  }) {
    return _then(_MainAppBarState(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      backEnabled: backEnabled == freezed
          ? _value.backEnabled
          : backEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      backRef: backRef == freezed
          ? _value.backRef
          : backRef // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_MainAppBarState extends _MainAppBarState {
  _$_MainAppBarState(
      {this.title = '', this.backEnabled = false, this.backRef = ''})
      : super._();

  @JsonKey(defaultValue: '')
  @override
  final String title;
  @JsonKey(defaultValue: false)
  @override
  final bool backEnabled;
  @JsonKey(defaultValue: '')
  @override
  final String backRef;

  @override
  String toString() {
    return 'MainAppBarState(title: $title, backEnabled: $backEnabled, backRef: $backRef)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MainAppBarState &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.backEnabled, backEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.backEnabled, backEnabled)) &&
            (identical(other.backRef, backRef) ||
                const DeepCollectionEquality().equals(other.backRef, backRef)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(backEnabled) ^
      const DeepCollectionEquality().hash(backRef);

  @JsonKey(ignore: true)
  @override
  _$MainAppBarStateCopyWith<_MainAppBarState> get copyWith =>
      __$MainAppBarStateCopyWithImpl<_MainAppBarState>(this, _$identity);
}

abstract class _MainAppBarState extends MainAppBarState {
  factory _MainAppBarState({String title, bool backEnabled, String backRef}) =
      _$_MainAppBarState;
  _MainAppBarState._() : super._();

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  bool get backEnabled => throw _privateConstructorUsedError;
  @override
  String get backRef => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MainAppBarStateCopyWith<_MainAppBarState> get copyWith =>
      throw _privateConstructorUsedError;
}
