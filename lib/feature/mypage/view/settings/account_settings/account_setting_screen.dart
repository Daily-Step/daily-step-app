import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text('계정 설정'),
        leading: IconButton(
          onPressed: () {
            context.go('/main/myPage'); // 이전 페이지로 가는 대신 올바른 경로로 이동
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '로그아웃',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right),)
                ],
              ),
              Divider(), // Row 외부에 위치
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '회원탈퇴',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right),)
                ],
              ),
              Divider(), // Row 외부에 위치
            ],
          ),
        ),
      ),
    );
  }
}
