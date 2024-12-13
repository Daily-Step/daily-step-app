import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/auth/service/kakao_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/login_state.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
      (ref) => LoginViewModel(),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final KakaoAuthService _kakaoAuthService = KakaoAuthService();

  LoginViewModel() : super(LoginState());

  /// Kakao 로그인 로직
  Future<void> loginWithKakao() async {
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

      // 서버 API로 AccessToken을 전달하는 작업
      await _loginToServer(accessToken);

      // 상태 업데이트
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } catch (e) {
      print('Kakao 로그인 중 에러: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '예상치 못한 오류입니다.',
      );
    }
  }

  /// 서버 API로 Kakao AccessToken 전송
  Future<void> _loginToServer(String accessToken) async {
    // 예제: 서버 API 호출 로직 (여기에서 성공/실패 처리 가능)
    try {
      final requestData = {'accessToken': accessToken};
      print('요청 데이터: $requestData');

      print('AccessToken 서버로 전송: $requestData');
      final response = await ApiClient().post(
        '/api/v1/auth/login/kakao',
        data: requestData,
      );

      // 응답 성공 로그
      print('서버 응답 성공: ${response.statusCode}');
      print('서버 응답 데이터: ${response.data}');
    } catch (e) {
      print('서버 요청 실패');
    }
  }

  /// 로그아웃 처리
  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }
}
