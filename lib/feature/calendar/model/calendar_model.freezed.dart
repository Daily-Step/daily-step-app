// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarModel _$CalendarModelFromJson(Map<String, dynamic> json) {
  return _CalendarModel.fromJson(json);
}

/// @nodoc
mixin _$CalendarModel {
  String get title => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;

  /// Serializes this CalendarModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarModelCopyWith<CalendarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarModelCopyWith<$Res> {
  factory $CalendarModelCopyWith(
          CalendarModel value, $Res Function(CalendarModel) then) =
      _$CalendarModelCopyWithImpl<$Res, CalendarModel>;
  @useResult
  $Res call({String title, DateTime dateTime});
}

/// @nodoc
class _$CalendarModelCopyWithImpl<$Res, $Val extends CalendarModel>
    implements $CalendarModelCopyWith<$Res> {
  _$CalendarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarModelImplCopyWith<$Res>
    implements $CalendarModelCopyWith<$Res> {
  factory _$$CalendarModelImplCopyWith(
          _$CalendarModelImpl value, $Res Function(_$CalendarModelImpl) then) =
      __$$CalendarModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, DateTime dateTime});
}

/// @nodoc
class __$$CalendarModelImplCopyWithImpl<$Res>
    extends _$CalendarModelCopyWithImpl<$Res, _$CalendarModelImpl>
    implements _$$CalendarModelImplCopyWith<$Res> {
  __$$CalendarModelImplCopyWithImpl(
      _$CalendarModelImpl _value, $Res Function(_$CalendarModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? dateTime = null,
  }) {
    return _then(_$CalendarModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarModelImpl
    with DiagnosticableTreeMixin
    implements _CalendarModel {
  const _$CalendarModelImpl({required this.title, required this.dateTime});

  factory _$CalendarModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarModelImplFromJson(json);

  @override
  final String title;
  @override
  final DateTime dateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CalendarModel(title: $title, dateTime: $dateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CalendarModel'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('dateTime', dateTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, dateTime);

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarModelImplCopyWith<_$CalendarModelImpl> get copyWith =>
      __$$CalendarModelImplCopyWithImpl<_$CalendarModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarModelImplToJson(
      this,
    );
  }
}

abstract class _CalendarModel implements CalendarModel {
  const factory _CalendarModel(
      {required final String title,
      required final DateTime dateTime}) = _$CalendarModelImpl;

  factory _CalendarModel.fromJson(Map<String, dynamic> json) =
      _$CalendarModelImpl.fromJson;

  @override
  String get title;
  @override
  DateTime get dateTime;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarModelImplCopyWith<_$CalendarModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
