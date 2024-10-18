import '../../model/user/user_model.dart';
import 'dio/dio_set.dart';

class UserApi {
  final client = dioSet;

  UserApi._();

  static UserApi instance = UserApi._();

  Future<void> loginWithKakaoTalk() async {}
  Future<void> loginWithKakaoAccount() async {}

  Future<User> me() async {
    await Future.delayed(Duration(seconds: 1),(){});
    return User(kakaoAccount: KakaoAccount());
  }
  Future<void> unlink() async {
    await Future.delayed(Duration(seconds: 1),(){});
  }
}


class KakaoAccount{
  final String? email;
  KakaoAccount({this.email});
}