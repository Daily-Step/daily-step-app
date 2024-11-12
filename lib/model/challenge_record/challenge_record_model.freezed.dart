// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChallengeRecordModel _$ChallengeRecordModelFromJson(Map<String, dynamic> json) {
  return _ChallengeRecord.fromJson(json);
}

/// @nodoc
mixin _$ChallengeRecordModel {
  int get id => throw _privateConstructorUsedError;
  int get challengeId => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChallengeRecordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeRecordModelCopyWith<ChallengeRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeRecordModelCopyWith<$Res> {
  factory $ChallengeRecordModelCopyWith(ChallengeRecordModel value,
          $Res Function(ChallengeRecordModel) then) =
      _$ChallengeRecordModelCopyWithImpl<$Res, ChallengeRecordModel>;
  @useResult
  $Res call(
      {int id,
      int challengeId,
      List<String>? images,
      String? memo,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ChallengeRecordModelCopyWithImpl<$Res,
        $Val extends ChallengeRecordModel>
    implements $ChallengeRecordModelCopyWith<$Res> {
  _$ChallengeRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? images = freezed,
    Object? memo = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as int,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ChallengeRecordImplCopyWith<$Res>
    implements $ChallengeRecordModelCopyWith<$Res> {
  factory _$$ChallengeRecordImplCopyWith(_$ChallengeRecordImpl value,
          $Res Function(_$ChallengeRecordImpl) then) =
      __$$ChallengeRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int challengeId,
      List<String>? images,
      String? memo,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ChallengeRecordImplCopyWithImpl<$Res>
    extends _$ChallengeRecordModelCopyWithImpl<$Res, _$ChallengeRecordImpl>
    implements _$$ChallengeRecordImplCopyWith<$Res> {
  __$$ChallengeRecordImplCopyWithImpl(
      _$ChallengeRecordImpl _value, $Res Function(_$ChallengeRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChallengeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? images = freezed,
    Object? memo = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChallengeRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as int,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$ChallengeRecordImpl implements _ChallengeRecord {
  const _$ChallengeRecordImpl(
      {required this.id,
      required this.challengeId,
      final List<String>? images,
      this.memo,
      required this.createdAt,
      this.updatedAt})
      : _images = images;

  factory _$ChallengeRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeRecordImplFromJson(json);

  @override
  final int id;
  @override
  final int challengeId;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? memo;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChallengeRecordModel(id: $id, challengeId: $challengeId, images: $images, memo: $memo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, challengeId,
      const DeepCollectionEquality().hash(_images), memo, createdAt, updatedAt);

  /// Create a copy of ChallengeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeRecordImplCopyWith<_$ChallengeRecordImpl> get copyWith =>
      __$$ChallengeRecordImplCopyWithImpl<_$ChallengeRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeRecordImplToJson(
      this,
    );
  }
}

abstract class _ChallengeRecord implements ChallengeRecordModel {
  const factory _ChallengeRecord(
      {required final int id,
      required final int challengeId,
      final List<String>? images,
      final String? memo,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$ChallengeRecordImpl;

  factory _ChallengeRecord.fromJson(Map<String, dynamic> json) =
      _$ChallengeRecordImpl.fromJson;

  @override
  int get id;
  @override
  int get challengeId;
  @override
  List<String>? get images;
  @override
  String? get memo;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ChallengeRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeRecordImplCopyWith<_$ChallengeRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
