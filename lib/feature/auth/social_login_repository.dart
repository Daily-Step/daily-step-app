import 'dart:io';
import 'package:dailystep/common/util/custom_exception.dart';
import 'package:dailystep/feature/auth/social_type.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../common/util/run_catching_exception.dart';
import '../../data/api/result/simple_result.dart';

class SocialLoginRepository implements SocialRepositoryImpl {
  @override
  Future<SimpleResult<dynamic, CustomExceptions>> socialLogin({
    required SocialType socialType,
  }) async {
    switch (socialType) {
      case SocialType.kakao:
        return _kakao();
      case SocialType.naver:
        return _naver();
      case SocialType.google:
        return _google();
    }
  }

  Future<SimpleResult<User?, CustomExceptions>> _kakao() async {
    return await runCatchingExceptions(() async {
      final UserApi api = UserApi.instance;
      bool isInstalled = await isKakaoTalkInstalled();
      if (Platform.isIOS) {
        isInstalled = false;
      }
      isInstalled
          ? await api.loginWithKakaoTalk()
          : await api.loginWithKakaoAccount();

      final User user = await api.me();
      await UserApi.instance.unlink();
      return user;
    });
  }

  Future<SimpleResult<NaverLoginResult?, CustomExceptions>> _naver() async {
    return await runCatchingExceptions(() async {
      final NaverLoginResult? res = await FlutterNaverLogin.logIn();
      return res;
    });
  }

  Future<SimpleResult<GoogleSignInAccount?, CustomExceptions>> _google() async {
    return await runCatchingExceptions(() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? res = await _googleSignIn.signIn();
      return res;
    });
  }
}

// 코드의 안정화를 위해 추가
abstract class SocialRepositoryImpl {
  Future<SimpleResult<dynamic, CustomExceptions>> socialLogin({
    required SocialType socialType,
  });
}