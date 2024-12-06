import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/my_info_provider.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class MyInfoScreen extends ConsumerWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // TODO: Picked 이미지 파일을 프로필로 설정하는 로직 추가
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보 수정'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 프로필 이미지
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Color(0xff2257FF),
                        child: Text(
                          '🥰',
                          style: TextStyle(fontSize: 45),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => _pickImage(context),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.black,
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '닉네임',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: [
                        Text('챌린지 123'),
                        IconButton(
                          onPressed: () {
                            context.go('/main/myPage/myinfo/nickname/123');
                          },
                          icon: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '생년월일',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: [
                        Text('1999.02.11'),
                        IconButton(
                          onPressed: () {
                            context.go('/main/myPage/myinfo/birthday/1999.01.01');
                          },
                          icon: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),

                // 성별 선택 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '성별',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: [
                        Text('남성'),
                        IconButton(
                          onPressed: () {
                            context.go('/main/myPage/myinfo/gender');
                          },
                          icon: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                
                // 직무 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '직무',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: [
                        Text('없음'),
                        IconButton(
                          onPressed: () {
                            context.go('/main/myPage/myinfo/job');
                          },
                          icon: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                
                // 연차 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '연차',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: [
                        Text('없음'),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
