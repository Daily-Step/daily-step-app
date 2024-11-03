// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarModelImpl _$$CalendarModelImplFromJson(Map<String, dynamic> json) =>
    _$CalendarModelImpl(
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      progress: (json['progress'] as num).toInt(),
    );

Map<String, dynamic> _$$CalendarModelImplToJson(_$CalendarModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateTime': instance.dateTime.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'progress': instance.progress,
    };
