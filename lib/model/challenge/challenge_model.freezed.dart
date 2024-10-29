// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$ChallengeModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  int get period => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  int get repeat => throw _privateConstructorUsedError;
  bool get isAlarm => throw _privateConstructorUsedError;
  String? get alarmTime => throw _privateConstructorUsedError;
  String? get alarmDate => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeModelCopyWith<ChallengeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeModelCopyWith<$Res> {
  factory $ChallengeModelCopyWith(
          ChallengeModel value, $Res Function(ChallengeModel) then) =
      _$ChallengeModelCopyWithImpl<$Res, ChallengeModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String startDate,
      int period,
      int progress,
      bool isCompleted,
      int repeat,
      bool isAlarm,
      String? alarmTime,
      String? alarmDate,
      String category,
      String? note});
}

/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res, $Val extends ChallengeModel>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? period = null,
    Object? progress = null,
    Object? isCompleted = null,
    Object? repeat = null,
    Object? isAlarm = null,
    Object? alarmTime = freezed,
    Object? alarmDate = freezed,
    Object? category = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int,
      isAlarm: null == isAlarm
          ? _value.isAlarm
          : isAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      alarmTime: freezed == alarmTime
          ? _value.alarmTime
          : alarmTime // ignore: cast_nullable_to_non_nullable
              as String?,
      alarmDate: freezed == alarmDate
          ? _value.alarmDate
          : alarmDate // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
          _$ChallengeImpl value, $Res Function(_$ChallengeImpl) then) =
      __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String startDate,
      int period,
      int progress,
      bool isCompleted,
      int repeat,
      bool isAlarm,
      String? alarmTime,
      String? alarmDate,
      String category,
      String? note});
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeModelCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
      _$ChallengeImpl _value, $Res Function(_$ChallengeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? period = null,
    Object? progress = null,
    Object? isCompleted = null,
    Object? repeat = null,
    Object? isAlarm = null,
    Object? alarmTime = freezed,
    Object? alarmDate = freezed,
    Object? category = null,
    Object? note = freezed,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int,
      isAlarm: null == isAlarm
          ? _value.isAlarm
          : isAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      alarmTime: freezed == alarmTime
          ? _value.alarmTime
          : alarmTime // ignore: cast_nullable_to_non_nullable
              as String?,
      alarmDate: freezed == alarmDate
          ? _value.alarmDate
          : alarmDate // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.period,
      required this.progress,
      required this.isCompleted,
      required this.repeat,
      required this.isAlarm,
      this.alarmTime,
      this.alarmDate,
      required this.category,
      this.note});

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String startDate;
  @override
  final int period;
  @override
  final int progress;
  @override
  final bool isCompleted;
  @override
  final int repeat;
  @override
  final bool isAlarm;
  @override
  final String? alarmTime;
  @override
  final String? alarmDate;
  @override
  final String category;
  @override
  final String? note;

  @override
  String toString() {
    return 'ChallengeModel(id: $id, title: $title, startDate: $startDate, period: $period, progress: $progress, isCompleted: $isCompleted, repeat: $repeat, isAlarm: $isAlarm, alarmTime: $alarmTime, alarmDate: $alarmDate, category: $category, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.isAlarm, isAlarm) || other.isAlarm == isAlarm) &&
            (identical(other.alarmTime, alarmTime) ||
                other.alarmTime == alarmTime) &&
            (identical(other.alarmDate, alarmDate) ||
                other.alarmDate == alarmDate) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      startDate,
      period,
      progress,
      isCompleted,
      repeat,
      isAlarm,
      alarmTime,
      alarmDate,
      category,
      note);

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(
      this,
    );
  }
}

abstract class _Challenge implements ChallengeModel {
  const factory _Challenge(
      {required final int id,
      required final String title,
      required final String startDate,
      required final int period,
      required final int progress,
      required final bool isCompleted,
      required final int repeat,
      required final bool isAlarm,
      final String? alarmTime,
      final String? alarmDate,
      required final String category,
      final String? note}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get startDate;
  @override
  int get period;
  @override
  int get progress;
  @override
  bool get isCompleted;
  @override
  int get repeat;
  @override
  bool get isAlarm;
  @override
  String? get alarmTime;
  @override
  String? get alarmDate;
  @override
  String get category;
  @override
  String? get note;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
