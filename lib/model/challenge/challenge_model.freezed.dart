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
  CategoryModel get category => throw _privateConstructorUsedError;
  RecordModel? get record => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get durationInWeeks => throw _privateConstructorUsedError;
  int get weekGoalCount => throw _privateConstructorUsedError;
  int get totalGoalCount => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  DateTime get startDateTime => throw _privateConstructorUsedError;
  DateTime get endDateTime => throw _privateConstructorUsedError;

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
      CategoryModel category,
      RecordModel? record,
      String title,
      String content,
      int durationInWeeks,
      int weekGoalCount,
      int totalGoalCount,
      String color,
      DateTime startDateTime,
      DateTime endDateTime});

  $CategoryModelCopyWith<$Res> get category;
  $RecordModelCopyWith<$Res>? get record;
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
    Object? category = null,
    Object? record = freezed,
    Object? title = null,
    Object? content = null,
    Object? durationInWeeks = null,
    Object? weekGoalCount = null,
    Object? totalGoalCount = null,
    Object? color = null,
    Object? startDateTime = null,
    Object? endDateTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
      record: freezed == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as RecordModel?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      durationInWeeks: null == durationInWeeks
          ? _value.durationInWeeks
          : durationInWeeks // ignore: cast_nullable_to_non_nullable
              as int,
      weekGoalCount: null == weekGoalCount
          ? _value.weekGoalCount
          : weekGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalGoalCount: null == totalGoalCount
          ? _value.totalGoalCount
          : totalGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      startDateTime: null == startDateTime
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDateTime: null == endDateTime
          ? _value.endDateTime
          : endDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res> get category {
    return $CategoryModelCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecordModelCopyWith<$Res>? get record {
    if (_value.record == null) {
      return null;
    }

    return $RecordModelCopyWith<$Res>(_value.record!, (value) {
      return _then(_value.copyWith(record: value) as $Val);
    });
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
      CategoryModel category,
      RecordModel? record,
      String title,
      String content,
      int durationInWeeks,
      int weekGoalCount,
      int totalGoalCount,
      String color,
      DateTime startDateTime,
      DateTime endDateTime});

  @override
  $CategoryModelCopyWith<$Res> get category;
  @override
  $RecordModelCopyWith<$Res>? get record;
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
    Object? category = null,
    Object? record = freezed,
    Object? title = null,
    Object? content = null,
    Object? durationInWeeks = null,
    Object? weekGoalCount = null,
    Object? totalGoalCount = null,
    Object? color = null,
    Object? startDateTime = null,
    Object? endDateTime = null,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
      record: freezed == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as RecordModel?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      durationInWeeks: null == durationInWeeks
          ? _value.durationInWeeks
          : durationInWeeks // ignore: cast_nullable_to_non_nullable
              as int,
      weekGoalCount: null == weekGoalCount
          ? _value.weekGoalCount
          : weekGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalGoalCount: null == totalGoalCount
          ? _value.totalGoalCount
          : totalGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      startDateTime: null == startDateTime
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDateTime: null == endDateTime
          ? _value.endDateTime
          : endDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.id,
      required this.category,
      required this.record,
      required this.title,
      required this.content,
      required this.durationInWeeks,
      required this.weekGoalCount,
      required this.totalGoalCount,
      required this.color,
      required this.startDateTime,
      required this.endDateTime});

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final int id;
  @override
  final CategoryModel category;
  @override
  final RecordModel? record;
  @override
  final String title;
  @override
  final String content;
  @override
  final int durationInWeeks;
  @override
  final int weekGoalCount;
  @override
  final int totalGoalCount;
  @override
  final String color;
  @override
  final DateTime startDateTime;
  @override
  final DateTime endDateTime;

  @override
  String toString() {
    return 'ChallengeModel(id: $id, category: $category, record: $record, title: $title, content: $content, durationInWeeks: $durationInWeeks, weekGoalCount: $weekGoalCount, totalGoalCount: $totalGoalCount, color: $color, startDateTime: $startDateTime, endDateTime: $endDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.durationInWeeks, durationInWeeks) ||
                other.durationInWeeks == durationInWeeks) &&
            (identical(other.weekGoalCount, weekGoalCount) ||
                other.weekGoalCount == weekGoalCount) &&
            (identical(other.totalGoalCount, totalGoalCount) ||
                other.totalGoalCount == totalGoalCount) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.startDateTime, startDateTime) ||
                other.startDateTime == startDateTime) &&
            (identical(other.endDateTime, endDateTime) ||
                other.endDateTime == endDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      category,
      record,
      title,
      content,
      durationInWeeks,
      weekGoalCount,
      totalGoalCount,
      color,
      startDateTime,
      endDateTime);

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
      required final CategoryModel category,
      required final RecordModel? record,
      required final String title,
      required final String content,
      required final int durationInWeeks,
      required final int weekGoalCount,
      required final int totalGoalCount,
      required final String color,
      required final DateTime startDateTime,
      required final DateTime endDateTime}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  int get id;
  @override
  CategoryModel get category;
  @override
  RecordModel? get record;
  @override
  String get title;
  @override
  String get content;
  @override
  int get durationInWeeks;
  @override
  int get weekGoalCount;
  @override
  int get totalGoalCount;
  @override
  String get color;
  @override
  DateTime get startDateTime;
  @override
  DateTime get endDateTime;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
