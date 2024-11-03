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
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;

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
  $Res call(
      {String title,
      DateTime dateTime,
      DateTime startDate,
      DateTime endDate,
      int progress});
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
    Object? startDate = null,
    Object? endDate = null,
    Object? progress = null,
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
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call(
      {String title,
      DateTime dateTime,
      DateTime startDate,
      DateTime endDate,
      int progress});
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
    Object? startDate = null,
    Object? endDate = null,
    Object? progress = null,
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
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarModelImpl extends _CalendarModel {
  const _$CalendarModelImpl(
      {required this.title,
      required this.dateTime,
      required this.startDate,
      required this.endDate,
      required this.progress})
      : super._();

  factory _$CalendarModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarModelImplFromJson(json);

  @override
  final String title;
  @override
  final DateTime dateTime;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int progress;

  @override
  String toString() {
    return 'CalendarModel(title: $title, dateTime: $dateTime, startDate: $startDate, endDate: $endDate, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, dateTime, startDate, endDate, progress);

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

abstract class _CalendarModel extends CalendarModel {
  const factory _CalendarModel(
      {required final String title,
      required final DateTime dateTime,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int progress}) = _$CalendarModelImpl;
  const _CalendarModel._() : super._();

  factory _CalendarModel.fromJson(Map<String, dynamic> json) =
      _$CalendarModelImpl.fromJson;

  @override
  String get title;
  @override
  DateTime get dateTime;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get progress;

  /// Create a copy of CalendarModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarModelImplCopyWith<_$CalendarModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
