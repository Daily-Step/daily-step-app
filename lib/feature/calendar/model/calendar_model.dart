import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_model.freezed.dart';
part 'calendar_model.g.dart';

@freezed
class CalendarModel with _$CalendarModel {
  const CalendarModel._();

  const factory CalendarModel({
    required String title,
    required DateTime dateTime,
    required DateTime startDate,
    required DateTime endDate,
    required int progress,
  }) = _CalendarModel;

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);

  // 기간을 계산하는 메소드
  String get period {
    final start = '${startDate.year}-${startDate.month}-${startDate.day}';
    final end = '${endDate.year}-${endDate.month}-${endDate.day}';
    return '$start ~ $end';
  }
}
