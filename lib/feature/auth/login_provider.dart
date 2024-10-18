import 'dart:io';
import 'package:dailystep/common/util/custom_exception.dart';
import 'package:dailystep/model/user/email_model.dart';
import 'package:dailystep/feature/auth/social_type.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as KakaoSdk;
import '../../common/util/run_catching_exception.dart';
import '../../data/api/result/simple_result.dart';
import '../../data/api/user_api.dart';
import '../../model/user/user_model.dart';

///TODO: 로그인 처리 네이티브 설정
// @riverpod
// SocialLoginRepository socialLoginRepository(SocialLoginRepositoryRef ref) {
//   return SocialLoginRepository();
// }

class SocialLoginRepository implements SocialRepositoryImpl {
  @override
  Future<SimpleResult<Email?, CustomExceptions>> socialLogin({
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

  Future<SimpleResult<Email?, CustomExceptions>> _kakao() async {
    return await runCatchingExceptions(() async {
      bool isInstalled = await _isKakaoTalkInstalled();
      if (Platform.isIOS) {
        isInstalled = false;
      }
      isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final User user = await UserApi.instance.me();
      final String? userEmail = user.kakaoAccount.email;
      await UserApi.instance.unlink();

      return userEmail != ''
          ? Email(socialEmail: userEmail!, socialType: 0)
          : null;
    });
  }

  Future<SimpleResult<Email?, CustomExceptions>> _naver() async {
    return await runCatchingExceptions(() async {
      final NaverLoginResult res = await FlutterNaverLogin.logIn();
      final String userEmail = res.account.email;
      return userEmail.isNotEmpty
          ? Email(socialEmail: userEmail, socialType: 1)
          : null;
    });
  }
/**/
  Future<SimpleResult<Email?, CustomExceptions>> _google() async {
    return await runCatchingExceptions(() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final String? userEmail = googleUser?.email;
      await UserApi.instance.unlink();
      return userEmail != null
          ? Email(socialEmail: userEmail, socialType: 1)
          : null;
    });
  }
  Future<bool> _isKakaoTalkInstalled() async {
    try {
      final isInstalled = await KakaoSdk.isKakaoTalkInstalled();
      return isInstalled;
    } catch (e) {
      print('카카오톡 설치 여부 확인 중 오류 발생: $e');
      return false;
    }
  }
}

// 코드의 안정화를 위해 추가
abstract class SocialRepositoryImpl {
  Future<SimpleResult<Email?, CustomExceptions>> socialLogin({
    required SocialType socialType,
  });
}