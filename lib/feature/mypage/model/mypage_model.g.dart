// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userName: json['userName'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      ongoingChallenges: (json['ongoingChallenges'] as num).toInt(),
      completedChallenges: (json['completedChallenges'] as num).toInt(),
      totalChallenges: (json['totalChallenges'] as num).toInt(),
      isPushNotificationEnabled:
          json['isPushNotificationEnabled'] as bool? ?? true,
      birth: DateTime.parse(json['birth'] as String),
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'profileImageUrl': instance.profileImageUrl,
      'ongoingChallenges': instance.ongoingChallenges,
      'completedChallenges': instance.completedChallenges,
      'totalChallenges': instance.totalChallenges,
      'isPushNotificationEnabled': instance.isPushNotificationEnabled,
      'birth': instance.birth.toIso8601String(),
      'gender': instance.gender,
    };
