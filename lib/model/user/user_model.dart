import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required final int id,
    required final String email,
    required final String nickname,
    required final String birth,
    required final String gender,
    String? profileImg,
    required final bool isNotificationReceived,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}