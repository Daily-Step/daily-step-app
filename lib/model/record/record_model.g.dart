// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordImpl _$$RecordImplFromJson(Map<String, dynamic> json) => _$RecordImpl(
      successDates: (json['successDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$$RecordImplToJson(_$RecordImpl instance) =>
    <String, dynamic>{
      'successDates':
          instance.successDates.map((e) => e.toIso8601String()).toList(),
    };
