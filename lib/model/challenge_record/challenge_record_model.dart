import 'package:freezed_annotation/freezed_annotation.dart';
part 'challenge_record_model.freezed.dart';
part 'challenge_record_model.g.dart';

@freezed
class ChallengeRecordModel with _$ChallengeRecordModel {
  const factory ChallengeRecordModel({
    required final int id,
    required final int challengeId,
    List<String>? images,
    String? memo,
    required final DateTime createdAt,
    DateTime? updatedAt,
  }) = _ChallengeRecord;

  factory ChallengeRecordModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeRecordModelFromJson(json);
}