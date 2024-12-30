import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_model.freezed.dart';

@freezed
class MyPageModel with _$MyPageModel {
  const factory MyPageModel({
    required String nickname,
    @Default('') String profileImageUrl,
    required DateTime birth,
    required String gender,
    @Default(0) int ongoingChallenges,
    @Default(0) int completedChallenges,
    @Default(0) int totalChallenges,
    @Default(false) bool isPushNotificationEnabled,
    int? jobId,
    String? job,
    int? jobYearId,
  }) = _UserModel;

  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return MyPageModel(
      nickname: data['nickname'] as String,
      birth: DateTime.parse(data['birth'] as String),
      gender: data['gender'] as String,
      jobId: data['jobId'] as int?,
      job: data['job'] as String?,
      jobYearId: data['jobYearId'] as int?,
    );
  }
}