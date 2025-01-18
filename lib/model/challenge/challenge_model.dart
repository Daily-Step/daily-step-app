import 'package:dailystep/model/category/category_model.dart';
import 'package:dailystep/model/record/record_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required final int id,
    required final CategoryModel category,
    required final RecordModel? record,
    required final String title,
    required final String content,
    required final int durationInWeeks,
    required final int weekGoalCount,
    required final int totalGoalCount,
    required final String color,
    required final DateTime startDateTime,
    required final DateTime endDateTime,
    required final String status,
  }) = _Challenge;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}