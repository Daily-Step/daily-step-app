import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/secure_storage/secure_storage_provider.dart';
import '../../common/util/size_util.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    print('Delaying for 2 seconds');
    await Future.delayed(const Duration(seconds: 2)); // 스플래시 화면 지연

    // SecureStorage에서 Access Token 확인
    final secureStorage = ref.read(secureStorageServiceProvider);
    final savedToken = await secureStorage.getAccessToken();

    if (savedToken != null) {
      print('유효한 저장된 토큰이 있습니다. Navigating to /main/home');
      context.go('/main/home'); // 토큰이 있으면 홈 화면으로 이동
    } else {
      print('저장된 토큰이 없습니다. Navigating to /signIn');
      context.go('/signIn'); // 토큰이 없으면 로그인 화면으로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WAppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 105.0 * su),
              child: Center(
                child: Image.asset('assets/splash/splash_logo.png'),
              ),
            ),
            SizedBox(height: 20 * su),
          ],
        ),
      ),
    );
  }
}
