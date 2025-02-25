import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/auth/service/kakao_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
import '../../sign_up/viewmodel/sign_up_provider.dart';
import '../state/login_state.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(ref),
);

final isLoggedInProvider = StateProvider<bool>((ref) => false); // 기본값 false

class LoginViewModel extends StateNotifier<LoginState> {
  final KakaoAuthService _kakaoAuthService = KakaoAuthService();
  final Ref _ref;

  LoginViewModel(this._ref) : super(LoginState());

  Future<String?> handleLogin(BuildContext context) async {
    await _ref.read(secureStorageServiceProvider).deleteTokens();
    try {
      final accessToken = await _getAccessTokenFromStorageOrKakao();

      if (accessToken == null) {
        state = state.copyWith(isLoading: false, errorMessage: '카카오 로그인 실패');
        return null;
      }


      // 서버에서 로그인 시도
      final signUpSuccess = await _attemptSignUp(accessToken, context);

      if (signUpSuccess) {
        // 회원가입 성공 시 로그인 처리
        _onSignUpSuccess(context, accessToken);
        return accessToken;
      } else {
        // 회원가입 실패 시 처리
        _onSignUpFailure(context, accessToken);
        return accessToken;
      }
    } catch (e) {
      print('로그인 중 오류 발생: $e');
      state = state.copyWith(isLoading: false, errorMessage: '예상치 못한 오류 발생');
    }
  }

  Future<String?> _getAccessTokenFromStorageOrKakao() async {
    final savedToken = await _ref.read(secureStorageServiceProvider).getAccessToken();
    if (savedToken != null) {
      print('저장된 토큰 사용: $savedToken');
      return savedToken;
    }
    return await _kakaoAuthService.getKakaoAccessToken();
  }

  Future<bool> _attemptSignUp(String accessToken, BuildContext context) async {
    final responseData = await _signUpToServer(accessToken, context); // 로그인 서버 호출

    if (responseData != null) {
      final newAccessToken = responseData['accessToken'] ?? '';
      final newRefreshToken = responseData['refreshToken'] ?? '';
      final expiresInSeconds = responseData['accessTokenExpiresIn'] ?? 3600;

      if (newAccessToken.isNotEmpty) {
        await _ref.read(secureStorageServiceProvider).saveAccessToken(newAccessToken, expiresInSeconds);
        await _ref.read(secureStorageServiceProvider).saveRefreshToken(newRefreshToken);
        return true;
      } else {
        print('새로운 accessToken을 받지 못했습니다.');
      }
    } else {
      print('로그인 실패: 응답이 없습니다.');
      _onSignUpFailure(context, accessToken);
    }
    return false;
  }

  /// 서버에 로그인 요청 보내기
  Future<Map<String, dynamic>?> _signUpToServer(String accessToken, BuildContext context) async {
    print('login to server');
    try {
      final requestData = {'accessToken': accessToken};
      final response = await ApiClient().post('/auth/login/kakao', data: requestData, headers: {
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data['data'];
        } else {
          print('응답 데이터 형식이 아닙니다. 데이터: ${response.data}');
        }
      } else if (response.statusCode == 404) {
        print('회원 정보 없음 (400), 회원가입으로 이동');
        _onSignUpFailure(context, accessToken);
        return null; // 회원가입이 필요하므로 로그인 실패 처리
      } else {
        print('로그인 실패, 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('서버 로그인 요청 실패: $e');
      _onSignUpFailure(context, accessToken);
    }
    return null; // 로그인 실패 시 null 반환
  }

  /// 로그인 성공 후 처리
  void _onSignUpSuccess(BuildContext context, String accessToken) {
    state = state.copyWith(isLoading: false, isLoggedIn: true);
    _ref.read(isLoggedInProvider.notifier).state = true;
    print("로그인 성공, 액세스 토큰: $accessToken");
    context.go('/main/home');
  }

  /// 로그인 실패 후 회원가입 화면으로 이동
  void _onSignUpFailure(BuildContext context, String accessToken) async {
    state = state.copyWith(isLoading: false);

    if (accessToken == null || accessToken.isEmpty) {
      print('❌ 회원가입 이동 실패: accessToken이 없음');
      return;
    }

    print("🚀 회원가입 페이지로 이동 준비 중, accessToken: $accessToken");

    if (context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print("🚀 회원가입 페이지로 이동!");
        context.go('/signUp', extra: accessToken);
      });
    } else {
      print("❌ context가 dispose됨! 이동 실패");
    }
  }

/*
  Future<void> loginWithKakao(BuildContext context) async {  // context 매개변수 추가
    await _ref.read(secureStorageServiceProvider).deleteTokens();

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // 저장된 토큰이 있으면 바로 로그인 상태로 전환
      final savedToken = await _ref.read(secureStorageServiceProvider).getAccessToken();
      if (savedToken != null) {
        print('유효한 저장된 토큰: $savedToken');
        _ref.read(isLoggedInProvider.notifier).state = true;
        GoRouter.of(context).go('/main/home');
        return;
      }

      // 카카오 로그인 요청
      final accessToken = await _kakaoAuthService.getKakaoAccessToken();
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

        // 로그인 후 홈으로 이동
        GoRouter.of(context).go('/main/home');
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
*/

/*
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
*/

  /// 로그아웃 처리
  void logout() async {
    // Secure Storage에서 액세스 토큰과 리프레시 토큰 삭제
    await _ref.read(secureStorageServiceProvider).deleteTokens();

    // 로그인 상태 업데이트
    state = state.copyWith(isLoggedIn: false);
    print('로그아웃 성공, 모든 토큰 삭제됨');
  }
}
