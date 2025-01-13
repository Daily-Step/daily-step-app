import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Splash 화면 이후 홈으로 이동
    await Future.delayed(Duration(seconds: 2)); // 스플래시 로딩 시간
    context.go('/main/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 105.0),
        child: Center(
          child: Image.asset('assets/splash/splash_logo.png'),
        ),
      ),
    );
  }
}
