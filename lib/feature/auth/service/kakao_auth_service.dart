import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoAuthService {
  Future<String?> getKakaoAccessToken() async {
    try {
      // Check Kakao Talk installation first
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          final OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡 로그인 성공: ${token.accessToken}');
          return token.accessToken;
        } catch (error) {
          print('카카오톡 로그인 실패: $error');

          // If it's a deliberate cancellation, return null
          if (error is PlatformException && error.code == 'CANCELED') {
            return null;
          }

          // Try Kakao Account login as fallback
          try {
            final OAuthToken accountToken = await UserApi.instance.loginWithKakaoAccount();
            print('카카오 계정 로그인 성공: ${accountToken.accessToken}');
            return accountToken.accessToken;
          } catch (accountError) {
            print('카카오 계정 로그인 실패: $accountError');
            return null;
          }
        }
      } else {
        // If Kakao Talk is not installed, try Kakao Account login
        try {
          final OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오 계정 로그인 성공: ${token.accessToken}');
          return token.accessToken;
        } catch (error) {
          print('카카오 계정 로그인 실패: $error');
          return null;
        }
      }
    } catch (error) {
      print('로그인 과정 중 예상치 못한 오류: $error');
      return null;
    }
  }
}
