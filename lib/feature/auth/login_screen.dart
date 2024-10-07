import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

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
                const Text(
                  '로그인',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
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
                WCtaButton('구글 로그인'),
                height10,
                WCtaButton('애플 로그인'),
                height10,
                WCtaButton('카카오 로그인'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
