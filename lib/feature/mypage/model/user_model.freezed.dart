// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get userName => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  int get ongoingChallenges => throw _privateConstructorUsedError;
  int get completedChallenges => throw _privateConstructorUsedError;
  int get totalChallenges => throw _privateConstructorUsedError;
  bool get isPushNotificationEnabled => throw _privateConstructorUsedError;
  DateTime get birth => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String userName,
      String profileImageUrl,
      int ongoingChallenges,
      int completedChallenges,
      int totalChallenges,
      bool isPushNotificationEnabled,
      DateTime birth,
      String gender});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? profileImageUrl = null,
    Object? ongoingChallenges = null,
    Object? completedChallenges = null,
    Object? totalChallenges = null,
    Object? isPushNotificationEnabled = null,
    Object? birth = null,
    Object? gender = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ongoingChallenges: null == ongoingChallenges
          ? _value.ongoingChallenges
          : ongoingChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      completedChallenges: null == completedChallenges
          ? _value.completedChallenges
          : completedChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      totalChallenges: null == totalChallenges
          ? _value.totalChallenges
          : totalChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      isPushNotificationEnabled: null == isPushNotificationEnabled
          ? _value.isPushNotificationEnabled
          : isPushNotificationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String profileImageUrl,
      int ongoingChallenges,
      int completedChallenges,
      int totalChallenges,
      bool isPushNotificationEnabled,
      DateTime birth,
      String gender});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? profileImageUrl = null,
    Object? ongoingChallenges = null,
    Object? completedChallenges = null,
    Object? totalChallenges = null,
    Object? isPushNotificationEnabled = null,
    Object? birth = null,
    Object? gender = null,
  }) {
    return _then(_$UserModelImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ongoingChallenges: null == ongoingChallenges
          ? _value.ongoingChallenges
          : ongoingChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      completedChallenges: null == completedChallenges
          ? _value.completedChallenges
          : completedChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      totalChallenges: null == totalChallenges
          ? _value.totalChallenges
          : totalChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      isPushNotificationEnabled: null == isPushNotificationEnabled
          ? _value.isPushNotificationEnabled
          : isPushNotificationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.userName,
      required this.profileImageUrl,
      required this.ongoingChallenges,
      required this.completedChallenges,
      required this.totalChallenges,
      this.isPushNotificationEnabled = true,
      required this.birth,
      required this.gender});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String userName;
  @override
  final String profileImageUrl;
  @override
  final int ongoingChallenges;
  @override
  final int completedChallenges;
  @override
  final int totalChallenges;
  @override
  @JsonKey()
  final bool isPushNotificationEnabled;
  @override
  final DateTime birth;
  @override
  final String gender;

  @override
  String toString() {
    return 'UserModel(userName: $userName, profileImageUrl: $profileImageUrl, ongoingChallenges: $ongoingChallenges, completedChallenges: $completedChallenges, totalChallenges: $totalChallenges, isPushNotificationEnabled: $isPushNotificationEnabled, birth: $birth, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.ongoingChallenges, ongoingChallenges) ||
                other.ongoingChallenges == ongoingChallenges) &&
            (identical(other.completedChallenges, completedChallenges) ||
                other.completedChallenges == completedChallenges) &&
            (identical(other.totalChallenges, totalChallenges) ||
                other.totalChallenges == totalChallenges) &&
            (identical(other.isPushNotificationEnabled,
                    isPushNotificationEnabled) ||
                other.isPushNotificationEnabled == isPushNotificationEnabled) &&
            (identical(other.birth, birth) || other.birth == birth) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userName,
      profileImageUrl,
      ongoingChallenges,
      completedChallenges,
      totalChallenges,
      isPushNotificationEnabled,
      birth,
      gender);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String userName,
      required final String profileImageUrl,
      required final int ongoingChallenges,
      required final int completedChallenges,
      required final int totalChallenges,
      final bool isPushNotificationEnabled,
      required final DateTime birth,
      required final String gender}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get userName;
  @override
  String get profileImageUrl;
  @override
  int get ongoingChallenges;
  @override
  int get completedChallenges;
  @override
  int get totalChallenges;
  @override
  bool get isPushNotificationEnabled;
  @override
  DateTime get birth;
  @override
  String get gender;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
