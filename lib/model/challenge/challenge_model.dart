import 'package:freezed_annotation/freezed_annotation.dart';
part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
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

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}