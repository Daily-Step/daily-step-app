import '../../model/user/user_dummy.dart';
import '../../model/user/user_model.dart';
import 'dio/dio_set.dart';

class LoginApi {
  final client = dioSet;

  LoginApi._();

  static LoginApi instance = LoginApi._();

  Future<UserModel> me() async {
    await Future.delayed(Duration(seconds: 1),(){});
    return dummyUser;
  }

  Future<String> token() async {
    await Future.delayed(Duration(seconds: 1),(){});
    return '';
  }
}