import 'package:dailystep/config/app.dart';
import 'package:dailystep/config/route/auth_redirection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/util/size_util.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 감지
    final loginState = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final auth = DailyStepAuthScope.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 105.0 * su),
                  child: Image.asset('assets/splash/splash_logo.png'),
                ),
                SizedBox(height: 20 * su),
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
                  padding: EdgeInsets.only(right: 16.0 * su, left: 16.0 * su),
                  child: ElevatedButton(
                    onPressed: () async {
                      //await ref.read(secureStorageServiceProvider).deleteTokens();

                      final savedToken = await ref.read(secureStorageServiceProvider).getAccessToken();

                      if (savedToken != null) {
                        print('유효한 저장된 토큰이 있습니다. 서버 요청을 건너뜁니다.');
                        await auth.signIn(context); // DailyStepAuth 상태 업데이트
                        return;
                      }

                      await viewModel.handleLogin(context);
                      if (viewModel.state.isLoggedIn) {
                        await auth.signIn(context); // DailyStepAuth 상태 동기화
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEE500),
                      minimumSize: Size(200 * su, 50 * su),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16 * su),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/auth/kakao.svg'),
                        SizedBox(width: 8 * su),
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
                SizedBox(height: 20 * su),
              ],
            ),
          ),
        ],
      ),
    ); // 여기에 Scaffold 괄호 닫기
  }
}
