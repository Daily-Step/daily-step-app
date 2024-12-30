// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MyPageModel user) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MyPageModel user)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MyPageModel user)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyPageStateInitial value) initial,
    required TResult Function(MyPageStateLoading value) loading,
    required TResult Function(MyPageStateLoaded value) loaded,
    required TResult Function(MyPageStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyPageStateInitial value)? initial,
    TResult? Function(MyPageStateLoading value)? loading,
    TResult? Function(MyPageStateLoaded value)? loaded,
    TResult? Function(MyPageStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyPageStateInitial value)? initial,
    TResult Function(MyPageStateLoading value)? loading,
    TResult Function(MyPageStateLoaded value)? loaded,
    TResult Function(MyPageStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPageStateCopyWith<$Res> {
  factory $MyPageStateCopyWith(
          MyPageState value, $Res Function(MyPageState) then) =
      _$MyPageStateCopyWithImpl<$Res, MyPageState>;
}

/// @nodoc
class _$MyPageStateCopyWithImpl<$Res, $Val extends MyPageState>
    implements $MyPageStateCopyWith<$Res> {
  _$MyPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MyPageStateInitialImplCopyWith<$Res> {
  factory _$$MyPageStateInitialImplCopyWith(_$MyPageStateInitialImpl value,
          $Res Function(_$MyPageStateInitialImpl) then) =
      __$$MyPageStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyPageStateInitialImplCopyWithImpl<$Res>
    extends _$MyPageStateCopyWithImpl<$Res, _$MyPageStateInitialImpl>
    implements _$$MyPageStateInitialImplCopyWith<$Res> {
  __$$MyPageStateInitialImplCopyWithImpl(_$MyPageStateInitialImpl _value,
      $Res Function(_$MyPageStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MyPageStateInitialImpl implements MyPageStateInitial {
  const _$MyPageStateInitialImpl();

  @override
  String toString() {
    return 'MyPageState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MyPageStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MyPageModel user) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MyPageModel user)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MyPageModel user)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyPageStateInitial value) initial,
    required TResult Function(MyPageStateLoading value) loading,
    required TResult Function(MyPageStateLoaded value) loaded,
    required TResult Function(MyPageStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyPageStateInitial value)? initial,
    TResult? Function(MyPageStateLoading value)? loading,
    TResult? Function(MyPageStateLoaded value)? loaded,
    TResult? Function(MyPageStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyPageStateInitial value)? initial,
    TResult Function(MyPageStateLoading value)? loading,
    TResult Function(MyPageStateLoaded value)? loaded,
    TResult Function(MyPageStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MyPageStateInitial implements MyPageState {
  const factory MyPageStateInitial() = _$MyPageStateInitialImpl;
}

/// @nodoc
abstract class _$$MyPageStateLoadingImplCopyWith<$Res> {
  factory _$$MyPageStateLoadingImplCopyWith(_$MyPageStateLoadingImpl value,
          $Res Function(_$MyPageStateLoadingImpl) then) =
      __$$MyPageStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyPageStateLoadingImplCopyWithImpl<$Res>
    extends _$MyPageStateCopyWithImpl<$Res, _$MyPageStateLoadingImpl>
    implements _$$MyPageStateLoadingImplCopyWith<$Res> {
  __$$MyPageStateLoadingImplCopyWithImpl(_$MyPageStateLoadingImpl _value,
      $Res Function(_$MyPageStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MyPageStateLoadingImpl implements MyPageStateLoading {
  const _$MyPageStateLoadingImpl();

  @override
  String toString() {
    return 'MyPageState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MyPageStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MyPageModel user) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MyPageModel user)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MyPageModel user)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyPageStateInitial value) initial,
    required TResult Function(MyPageStateLoading value) loading,
    required TResult Function(MyPageStateLoaded value) loaded,
    required TResult Function(MyPageStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyPageStateInitial value)? initial,
    TResult? Function(MyPageStateLoading value)? loading,
    TResult? Function(MyPageStateLoaded value)? loaded,
    TResult? Function(MyPageStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyPageStateInitial value)? initial,
    TResult Function(MyPageStateLoading value)? loading,
    TResult Function(MyPageStateLoaded value)? loaded,
    TResult Function(MyPageStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MyPageStateLoading implements MyPageState {
  const factory MyPageStateLoading() = _$MyPageStateLoadingImpl;
}

/// @nodoc
abstract class _$$MyPageStateLoadedImplCopyWith<$Res> {
  factory _$$MyPageStateLoadedImplCopyWith(_$MyPageStateLoadedImpl value,
          $Res Function(_$MyPageStateLoadedImpl) then) =
      __$$MyPageStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MyPageModel user});

  $MyPageModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$MyPageStateLoadedImplCopyWithImpl<$Res>
    extends _$MyPageStateCopyWithImpl<$Res, _$MyPageStateLoadedImpl>
    implements _$$MyPageStateLoadedImplCopyWith<$Res> {
  __$$MyPageStateLoadedImplCopyWithImpl(_$MyPageStateLoadedImpl _value,
      $Res Function(_$MyPageStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$MyPageStateLoadedImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as MyPageModel,
    ));
  }

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MyPageModelCopyWith<$Res> get user {
    return $MyPageModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$MyPageStateLoadedImpl implements MyPageStateLoaded {
  const _$MyPageStateLoadedImpl({required this.user});

  @override
  final MyPageModel user;

  @override
  String toString() {
    return 'MyPageState.loaded(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyPageStateLoadedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyPageStateLoadedImplCopyWith<_$MyPageStateLoadedImpl> get copyWith =>
      __$$MyPageStateLoadedImplCopyWithImpl<_$MyPageStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MyPageModel user) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MyPageModel user)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MyPageModel user)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyPageStateInitial value) initial,
    required TResult Function(MyPageStateLoading value) loading,
    required TResult Function(MyPageStateLoaded value) loaded,
    required TResult Function(MyPageStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyPageStateInitial value)? initial,
    TResult? Function(MyPageStateLoading value)? loading,
    TResult? Function(MyPageStateLoaded value)? loaded,
    TResult? Function(MyPageStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyPageStateInitial value)? initial,
    TResult Function(MyPageStateLoading value)? loading,
    TResult Function(MyPageStateLoaded value)? loaded,
    TResult Function(MyPageStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MyPageStateLoaded implements MyPageState {
  const factory MyPageStateLoaded({required final MyPageModel user}) =
      _$MyPageStateLoadedImpl;

  MyPageModel get user;

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyPageStateLoadedImplCopyWith<_$MyPageStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MyPageStateErrorImplCopyWith<$Res> {
  factory _$$MyPageStateErrorImplCopyWith(_$MyPageStateErrorImpl value,
          $Res Function(_$MyPageStateErrorImpl) then) =
      __$$MyPageStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MyPageStateErrorImplCopyWithImpl<$Res>
    extends _$MyPageStateCopyWithImpl<$Res, _$MyPageStateErrorImpl>
    implements _$$MyPageStateErrorImplCopyWith<$Res> {
  __$$MyPageStateErrorImplCopyWithImpl(_$MyPageStateErrorImpl _value,
      $Res Function(_$MyPageStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MyPageStateErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyPageStateErrorImpl implements MyPageStateError {
  const _$MyPageStateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MyPageState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyPageStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyPageStateErrorImplCopyWith<_$MyPageStateErrorImpl> get copyWith =>
      __$$MyPageStateErrorImplCopyWithImpl<_$MyPageStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MyPageModel user) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MyPageModel user)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MyPageModel user)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyPageStateInitial value) initial,
    required TResult Function(MyPageStateLoading value) loading,
    required TResult Function(MyPageStateLoaded value) loaded,
    required TResult Function(MyPageStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyPageStateInitial value)? initial,
    TResult? Function(MyPageStateLoading value)? loading,
    TResult? Function(MyPageStateLoaded value)? loaded,
    TResult? Function(MyPageStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyPageStateInitial value)? initial,
    TResult Function(MyPageStateLoading value)? loading,
    TResult Function(MyPageStateLoaded value)? loaded,
    TResult Function(MyPageStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MyPageStateError implements MyPageState {
  const factory MyPageStateError({required final String message}) =
      _$MyPageStateErrorImpl;

  String get message;

  /// Create a copy of MyPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyPageStateErrorImplCopyWith<_$MyPageStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
