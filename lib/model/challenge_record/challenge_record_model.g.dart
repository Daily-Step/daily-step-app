// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeRecordImpl _$$ChallengeRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeRecordImpl(
      id: (json['id'] as num).toInt(),
      challengeId: (json['challengeId'] as num).toInt(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      memo: json['memo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChallengeRecordImplToJson(
        _$ChallengeRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengeId': instance.challengeId,
      'images': instance.images,
      'memo': instance.memo,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
