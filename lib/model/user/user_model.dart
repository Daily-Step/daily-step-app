import 'package:dailystep/data/api/user_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required final KakaoAccount kakaoAccount,
  }) = _User;
}