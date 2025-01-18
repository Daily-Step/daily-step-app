// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: (json['id'] as num).toInt(),
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      record: json['record'] == null
          ? null
          : RecordModel.fromJson(json['record'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      durationInWeeks: (json['durationInWeeks'] as num).toInt(),
      weekGoalCount: (json['weekGoalCount'] as num).toInt(),
      totalGoalCount: (json['totalGoalCount'] as num).toInt(),
      color: json['color'] as String,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'record': instance.record,
      'title': instance.title,
      'content': instance.content,
      'durationInWeeks': instance.durationInWeeks,
      'weekGoalCount': instance.weekGoalCount,
      'totalGoalCount': instance.totalGoalCount,
      'color': instance.color,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'status': instance.status,
    };
