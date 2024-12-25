import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_model.freezed.dart';
part 'mypage_model.g.dart';

@freezed
class MyPageModel with _$MyPageModel {
  const factory MyPageModel({
    required String userName,
    required String profileImageUrl,
    required int ongoingChallenges,
    required int completedChallenges,
    required int totalChallenges,
    @Default(false) bool isPushNotificationEnabled,
    required DateTime birth,
    required String gender,
  }) = _UserModel;

  factory MyPageModel.fromJson(Map<String, dynamic> json) =>
      _$MyPageModelFromJson(json);
}
