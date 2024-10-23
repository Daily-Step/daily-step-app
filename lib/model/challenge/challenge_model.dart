import 'package:freezed_annotation/freezed_annotation.dart';
part 'challenge_model.freezed.dart';

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required final int id,
    required final String title,
    required final String startDate,
    required final int period,
    required final int progress,
    required final bool isCompleted,
    required final int repeat,
    required final bool isAlarm,
    String? alarmTime,
    String? alarmDate,
    required final String category,
    String? note,
  }) = _Challenge;
}