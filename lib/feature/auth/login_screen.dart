import 'package:dailystep/config/route/auth_redirection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  final DailyStepAuth auth;

  const LoginScreen({super.key, required this.auth});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 105.0),
                  child: Image.asset('assets/splash/splash_logo.png'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Buttons
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /*
                WCtaButton('구글 로그인', onPressed: () => widget.auth.googleSignIn(context)),
                height10,
                WCtaButton('네이버 로그인', onPressed: () => widget.auth.naverSignIn(context),),
                height10,
                */

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () => widget.auth.kakaoSignIn(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEE500), // 카카오 노란색
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 둥근 모서리
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/auth/kakao.svg'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Text(
                              '카카오 계정으로 시작하기',
                              style: TextStyle(
                                color: Colors.black, // 텍스트 색상
                                fontWeight: FontWeight.bold, // 굵은 텍스트
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
