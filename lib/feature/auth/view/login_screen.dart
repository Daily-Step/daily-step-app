import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/secure_storage/secure_storage_provider.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 감지
    final loginState = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final savedTokenAsync = ref.watch(savedTokenProvider); // 비동기 savedToken 확인

    return Scaffold(
      body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 105.0),
                      child: Image.asset('assets/splash/splash_logo.png'),
                    ),
                    const SizedBox(height: 20),
                    if (loginState.errorMessage != null)
                      Text(
                        loginState.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {

                          final savedToken = await ref.read(secureStorageServiceProvider).getAccessToken();

                          if (savedToken != null) {
                            // 저장된 토큰이 유효하면 서버 요청 없이 바로 로그인 처리
                            print('유효한 저장된 토큰이 있습니다. 서버 요청을 건너뜁니다.');
                            ref.read(loginViewModelProvider.notifier).state = loginState.copyWith(isLoggedIn: true);
                            context.go('/main/home'); // 바로 홈 화면으로 이동
                            return;
                          }

                          await viewModel.handleLogin(context);


                          // 저장된 토큰을 콘솔에 출력합니다
                          print('저장된 토큰: $savedToken');

                          final isLoggedIn = viewModel.state.isLoggedIn;

                          if (isLoggedIn) {
                            context.go('/main/home');
                          } else {
                            context.go('/signUp');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEE500),
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/auth/kakao.svg'),
                            const SizedBox(width: 8),
                            const Text(
                              '카카오 계정으로 시작하기',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
      ),
    );  // 여기에 Scaffold 괄호 닫기
  }
}