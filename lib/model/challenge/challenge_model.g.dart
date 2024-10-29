// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      startDate: json['startDate'] as String,
      period: (json['period'] as num).toInt(),
      progress: (json['progress'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      repeat: (json['repeat'] as num).toInt(),
      isAlarm: json['isAlarm'] as bool,
      alarmTime: json['alarmTime'] as String?,
      alarmDate: json['alarmDate'] as String?,
      category: json['category'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate,
      'period': instance.period,
      'progress': instance.progress,
      'isCompleted': instance.isCompleted,
      'repeat': instance.repeat,
      'isAlarm': instance.isAlarm,
      'alarmTime': instance.alarmTime,
      'alarmDate': instance.alarmDate,
      'category': instance.category,
      'note': instance.note,
    };
