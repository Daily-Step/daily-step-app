import 'package:dailystep/feature/mypage/model/mypage_model.dart';
import 'package:dailystep/feature/mypage/model/mypage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../viewmodel/my_info_viewmodel.dart';

class MyInfoScreen extends ConsumerWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref.read(myInfoViewModelProvider.notifier).uploadProfileImage(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(myInfoViewModelProvider); // 변수명 변경

    if (userState is MyPageStateInitial) {
      Future.delayed(Duration.zero, () {
        ref.read(myInfoViewModelProvider.notifier).fetchUserData();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보 수정'),
        centerTitle: true,
      ),
      body: userState.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (user) => Column(
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
                          backgroundColor: const Color(0xff2257FF),
                          backgroundImage: user.profileImageUrl.isEmpty
                              ? null
                              : NetworkImage(user.profileImageUrl),
                          child: user.profileImageUrl.isEmpty
                              ? const Text('🥰', style: TextStyle(fontSize: 45))
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => _pickImage(context, ref),
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.black,
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
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
                          Text(user.nickname),
                          IconButton(
                            onPressed: () {
                              context.go('/main/myPage/myinfo/nickname/${user.nickname ?? ""}');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
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
                          Text(DateFormat('yyyy-MM-dd').format(user.birth)),
                          IconButton(
                            onPressed: () {
                              context.go('/main/myPage/myinfo/birthday/${user.birth ?? ""}');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
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
                          Text(user.translatedGender),
                          IconButton(
                            onPressed: () {
                              context.go('/main/myPage/myinfo/gender');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
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
                          Text(user.translatedJob),
                          IconButton(
                            onPressed: () {
                              context.go('/main/myPage/myinfo/job');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
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
                          Text(user.translatedJobTenure),
                          IconButton(
                            onPressed: () {
                              context.go('/main/myPage/myinfo/jobTenure');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
        error: (message) => Center(
          child: Text('오류: $message', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
