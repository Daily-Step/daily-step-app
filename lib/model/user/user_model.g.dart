// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      birth: json['birth'] as String,
      gender: json['gender'] as String,
      profileImg: json['profileImg'] as String?,
      isNotificationReceived: json['isNotificationReceived'] as bool,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'birth': instance.birth,
      'gender': instance.gender,
      'profileImg': instance.profileImg,
      'isNotificationReceived': instance.isNotificationReceived,
    };
