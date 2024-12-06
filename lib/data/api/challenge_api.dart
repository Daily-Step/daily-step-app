import 'package:dailystep/model/challenge/challenge_model.dart';

import 'dio/dio_set.dart';

class LoginApi {
  final client = dioSet;

  LoginApi._();

  static LoginApi instance = LoginApi._();

  // Future<ChallengeModel> me() async {
  //   await Future.delayed(Duration(seconds: 1),(){});
  //   return ;
  // }
}