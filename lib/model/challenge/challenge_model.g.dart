// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: (json['id'] as num).toInt(),
      memberId: (json['memberId'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      color: json['color'] as String,
      weeklyGoalCount: (json['weeklyGoalCount'] as num).toInt(),
      totalGoalCount: (json['totalGoalCount'] as num).toInt(),
      achievedTotalGoalCount: (json['achievedTotalGoalCount'] as num).toInt(),
      startDatetime: DateTime.parse(json['startDatetime'] as String),
      endDatetime: DateTime.parse(json['endDatetime'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'content': instance.content,
      'color': instance.color,
      'weeklyGoalCount': instance.weeklyGoalCount,
      'totalGoalCount': instance.totalGoalCount,
      'achievedTotalGoalCount': instance.achievedTotalGoalCount,
      'startDatetime': instance.startDatetime.toIso8601String(),
      'endDatetime': instance.endDatetime.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
