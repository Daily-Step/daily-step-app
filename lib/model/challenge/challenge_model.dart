import 'package:freezed_annotation/freezed_annotation.dart';
part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required final int id,
    required final int memberId,
    required final int categoryId,
    required final String title,
    required final String content,
    required final String color,
    required final int weeklyGoalCount,
    required final int totalGoalCount,
    required final int achievedTotalGoalCount,
    required final DateTime startDatetime,
    required final DateTime endDatetime,
    required final DateTime createdAt,
    DateTime? updatedAt,
  }) = _Challenge;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}