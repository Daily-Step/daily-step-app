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
  int get memberId => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get colorId => throw _privateConstructorUsedError;
  int get weeklyGoalCount => throw _privateConstructorUsedError;
  int get totalGoalCount => throw _privateConstructorUsedError;
  List<DateTime> get successList => throw _privateConstructorUsedError;
  DateTime get startDatetime => throw _privateConstructorUsedError;
  DateTime get endDatetime => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      int memberId,
      int categoryId,
      String title,
      String content,
      int colorId,
      int weeklyGoalCount,
      int totalGoalCount,
      List<DateTime> successList,
      DateTime startDatetime,
      DateTime endDatetime,
      DateTime createdAt,
      DateTime? updatedAt});
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
    Object? memberId = null,
    Object? categoryId = null,
    Object? title = null,
    Object? content = null,
    Object? colorId = null,
    Object? weeklyGoalCount = null,
    Object? totalGoalCount = null,
    Object? successList = null,
    Object? startDatetime = null,
    Object? endDatetime = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      colorId: null == colorId
          ? _value.colorId
          : colorId // ignore: cast_nullable_to_non_nullable
              as int,
      weeklyGoalCount: null == weeklyGoalCount
          ? _value.weeklyGoalCount
          : weeklyGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalGoalCount: null == totalGoalCount
          ? _value.totalGoalCount
          : totalGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      successList: null == successList
          ? _value.successList
          : successList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      startDatetime: null == startDatetime
          ? _value.startDatetime
          : startDatetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDatetime: null == endDatetime
          ? _value.endDatetime
          : endDatetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      int memberId,
      int categoryId,
      String title,
      String content,
      int colorId,
      int weeklyGoalCount,
      int totalGoalCount,
      List<DateTime> successList,
      DateTime startDatetime,
      DateTime endDatetime,
      DateTime createdAt,
      DateTime? updatedAt});
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
    Object? memberId = null,
    Object? categoryId = null,
    Object? title = null,
    Object? content = null,
    Object? colorId = null,
    Object? weeklyGoalCount = null,
    Object? totalGoalCount = null,
    Object? successList = null,
    Object? startDatetime = null,
    Object? endDatetime = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      colorId: null == colorId
          ? _value.colorId
          : colorId // ignore: cast_nullable_to_non_nullable
              as int,
      weeklyGoalCount: null == weeklyGoalCount
          ? _value.weeklyGoalCount
          : weeklyGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalGoalCount: null == totalGoalCount
          ? _value.totalGoalCount
          : totalGoalCount // ignore: cast_nullable_to_non_nullable
              as int,
      successList: null == successList
          ? _value._successList
          : successList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      startDatetime: null == startDatetime
          ? _value.startDatetime
          : startDatetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDatetime: null == endDatetime
          ? _value.endDatetime
          : endDatetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.id,
      required this.memberId,
      required this.categoryId,
      required this.title,
      required this.content,
      required this.colorId,
      required this.weeklyGoalCount,
      required this.totalGoalCount,
      required final List<DateTime> successList,
      required this.startDatetime,
      required this.endDatetime,
      required this.createdAt,
      this.updatedAt})
      : _successList = successList;

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final int id;
  @override
  final int memberId;
  @override
  final int categoryId;
  @override
  final String title;
  @override
  final String content;
  @override
  final int colorId;
  @override
  final int weeklyGoalCount;
  @override
  final int totalGoalCount;
  final List<DateTime> _successList;
  @override
  List<DateTime> get successList {
    if (_successList is EqualUnmodifiableListView) return _successList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successList);
  }

  @override
  final DateTime startDatetime;
  @override
  final DateTime endDatetime;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChallengeModel(id: $id, memberId: $memberId, categoryId: $categoryId, title: $title, content: $content, colorId: $colorId, weeklyGoalCount: $weeklyGoalCount, totalGoalCount: $totalGoalCount, successList: $successList, startDatetime: $startDatetime, endDatetime: $endDatetime, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.colorId, colorId) || other.colorId == colorId) &&
            (identical(other.weeklyGoalCount, weeklyGoalCount) ||
                other.weeklyGoalCount == weeklyGoalCount) &&
            (identical(other.totalGoalCount, totalGoalCount) ||
                other.totalGoalCount == totalGoalCount) &&
            const DeepCollectionEquality()
                .equals(other._successList, _successList) &&
            (identical(other.startDatetime, startDatetime) ||
                other.startDatetime == startDatetime) &&
            (identical(other.endDatetime, endDatetime) ||
                other.endDatetime == endDatetime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      memberId,
      categoryId,
      title,
      content,
      colorId,
      weeklyGoalCount,
      totalGoalCount,
      const DeepCollectionEquality().hash(_successList),
      startDatetime,
      endDatetime,
      createdAt,
      updatedAt);

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
      required final int memberId,
      required final int categoryId,
      required final String title,
      required final String content,
      required final int colorId,
      required final int weeklyGoalCount,
      required final int totalGoalCount,
      required final List<DateTime> successList,
      required final DateTime startDatetime,
      required final DateTime endDatetime,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  int get id;
  @override
  int get memberId;
  @override
  int get categoryId;
  @override
  String get title;
  @override
  String get content;
  @override
  int get colorId;
  @override
  int get weeklyGoalCount;
  @override
  int get totalGoalCount;
  @override
  List<DateTime> get successList;
  @override
  DateTime get startDatetime;
  @override
  DateTime get endDatetime;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
