import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/auth/service/kakao_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../sign_up/viewmodel/sign_up_provider.dart';
import '../state/login_state.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
      (ref) => LoginViewModel(ref),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final KakaoAuthService _kakaoAuthService = KakaoAuthService();
  final Ref _ref;

  LoginViewModel(this._ref) : super(LoginState());

  /// Kakao 로그인 로직
  Future<void> loginWithKakao(BuildContext context) async {  // context 매개변수 추가
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final accessToken = await _kakaoAuthService.getKakaoAccessToken();

      print('카카오 토큰 : ${accessToken}');
      if (accessToken == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '카카오 로그인이 실패했습니다.',
        );
        return;
      }

      // 서버에서 로그인 시도
      final loginSuccess = await _loginToServer(accessToken);

      if (loginSuccess) {
        // 로그인 성공
        state = state.copyWith(isLoading: false, isLoggedIn: true);
      } else {
        // 로그인 실패 시, SignUpViewModel을 통해 회원가입 처리
        _ref.read(signUpProvider.notifier).saveUserInfo(accessToken, context);  // 수정된 부분
      }
    } catch (e) {
      print('Kakao 로그인 중 에러: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '예상치 못한 오류입니다.',
      );
    }
  }

  /// 서버 API로 Kakao AccessToken 전송
  Future<bool> _loginToServer(String accessToken) async {
    try {
      final requestData = {'accessToken': accessToken};
      print('요청 데이터: $requestData');

      final response = await ApiClient().post(
        'login/kakao',
        data: requestData,
      );

      print('서버 응답 성공: ${response.statusCode}');
      print('서버 응답 데이터: ${response.data}');

      // 로그인 성공 시 true 반환, 실패 시 false 반환
      if (response.statusCode == 200) {
        return true; // 로그인 성공
      } else {
        return false; // 로그인 실패
      }
    } catch (e) {
      print('서버 요청 실패: $e');
      return false; // 예외 발생 시 실패로 처리
    }
  }

  /// 로그아웃 처리
  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }
}
