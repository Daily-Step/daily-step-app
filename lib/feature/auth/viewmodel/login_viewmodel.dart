import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/auth/service/kakao_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
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
    await _ref.read(secureStorageServiceProvider).deleteTokens();

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final savedToken = await _ref.read(secureStorageServiceProvider).getAccessToken();

      if (savedToken != null) {
        print('유효한 저장된 토큰: $savedToken');
        // 유효한 토큰이 있으면 바로 로그인 상태로 전환
        state = state.copyWith(isLoading: false, isLoggedIn: true);
        return;
      }

      final accessToken = await _kakaoAuthService.getKakaoAccessToken();

      if (accessToken == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '카카오 로그인이 실패했습니다.',
        );
        return;
      }
      await _saveAccessToken(accessToken);

      // 서버에서 로그인 시도
      final loginSuccess = await _loginToServer(accessToken);

      if (loginSuccess) {
        // 로그인 성공
        state = state.copyWith(isLoading: false, isLoggedIn: true);
      } else {
        // 로그인 실패 시, SignUpViewModel을 통해 회원가입 처리
        _ref.read(signUpProvider.notifier).saveUserInfo(accessToken, context);
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

  Future<void> _saveAccessToken(String accessToken) async {
    try {
      // SecureStorageService를 사용하여 토큰 저장
      await _ref.read(secureStorageServiceProvider).saveAccessToken(accessToken, 2592000);
    } catch (e) {
      print("토큰 저장 중 오류 발생: $e");
      // 필요 시 에러 상태 업데이트
      state = state.copyWith(errorMessage: '토큰 저장 중 오류가 발생했습니다.');
    }
  }

  /// 로그아웃 처리
  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }
}
