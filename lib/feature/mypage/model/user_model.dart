import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userName,
    required String profileImageUrl,
    required int ongoingChallenges,
    required int completedChallenges,
    required int totalChallenges,
    @Default(true) bool isPushNotificationEnabled,
    required DateTime birth,
    required String gender,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
