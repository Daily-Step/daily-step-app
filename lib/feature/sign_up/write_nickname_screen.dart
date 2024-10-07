import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';

class WriteNickNameScreen extends StatefulWidget {
  const WriteNickNameScreen({super.key});

  @override
  State<WriteNickNameScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<WriteNickNameScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Center(
                child: Icon(
                  Icons.check_circle,
                  size: 100,
                ),
              ),
              height10,
              const Text(
                '닉네임을 입력해 주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              height20,
              WTextField(controller, hintText: '닉네임을 입력해 주세요',)
            ],
          ),
          // Buttons
          WCtaFloatingButton('입력완료')
        ],
      ),
    );
  }
}
