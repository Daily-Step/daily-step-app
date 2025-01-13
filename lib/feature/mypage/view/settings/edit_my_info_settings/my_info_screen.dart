import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/feature/mypage/model/mypage_model.dart';
import 'package:dailystep/feature/mypage/model/mypage_state.dart';
import 'package:dailystep/widgets/widget_confirm_modal.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../viewmodel/my_info_viewmodel.dart';

class MyInfoScreen extends ConsumerWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  Future<void> _checkPermissionAndPickImage(BuildContext context, WidgetRef ref) async {
    // 권한 확인
    if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
      // 권한이 이미 허용된 경우 이미지 선택
      await _pickImage(context, ref);
      return;
    }

    // 권한 요청
    PermissionStatus permissionStatus;
    if (await Permission.photos.isDenied) {
      permissionStatus = await Permission.photos.request();
    } else {
      permissionStatus = await Permission.storage.request();
    }

    if (permissionStatus.isGranted) {
      // 권한 허용 후 이미지 선택
      await _pickImage(context, ref);
    } else {
      // 권한 거부된 경우 경고 메시지 표시
      _showPermissionDialog(context);
    }
  }

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref.read(myInfoViewModelProvider.notifier).uploadProfileImage(pickedFile);
    }
  }

  void _showPermissionDialog(BuildContext context) {
    showConfirmModal(
      context: context,
      content: Text(
        '갤러리 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16 * su,
          color: Colors.black,
        ),
      ),
      confirmText: '설정 열기',
      onClickConfirm: () {
        openAppSettings(); // 앱 설정 화면 열기
      },
      isCancelButton: true, // "닫기" 버튼 표시
    );
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
        title: Text('내 정보 수정', style: WAppFontSize.titleXL(),),
        centerTitle: true,
      ),
      body: userState.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (user) => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0 * su),
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
                              ? Text('🥰', style: TextStyle(fontSize: 45 * su))
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => _checkPermissionAndPickImage(context, ref),
                            child: CircleAvatar(
                              radius: 16 * su,
                              backgroundColor: Colors.black,
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 16 * su),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * su),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '닉네임', style: WAppFontSize.bodyL1(),
                      ),
                      Row(
                        children: [
                          Text(user.nickname, style: WAppFontSize.values(color: WAppColors.black),),
                          IconButton(
                            onPressed: () {
                              context.push('/main/myPage/myinfo/nickname/${user.nickname ?? ""}');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40 * su),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '생년월일',
                        style: WAppFontSize.bodyL1(),
                      ),
                      Row(
                        children: [
                          Text(DateFormat('yyyy-MM-dd').format(user.birth), style: WAppFontSize.values(color: WAppColors.black),),
                          IconButton(
                            onPressed: () {
                              context.push('/main/myPage/myinfo/birthday/${user.birth ?? ""}');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40 * su),

                  // 성별 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '성별',
                        style: WAppFontSize.bodyL1(),
                      ),
                      Row(
                        children: [
                          Text(user.translatedGender, style: WAppFontSize.values(color: WAppColors.black),),
                          IconButton(
                            onPressed: () {
                              context.push('/main/myPage/myinfo/gender');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40 * su),

                  // 직무 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '직무',
                        style: WAppFontSize.bodyL1(),
                      ),
                      Row(
                        children: [
                          Text(user.translatedJob, style: WAppFontSize.values(color: WAppColors.black),),
                          IconButton(
                            onPressed: () {
                              context.push('/main/myPage/myinfo/job');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40 * su),

                  // 연차 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '연차',
                        style: WAppFontSize.bodyL1(),
                      ),
                      Row(
                        children: [
                          Text(user.translatedJobTenure, style: WAppFontSize.values(color: WAppColors.black),),
                          IconButton(
                            onPressed: () {
                              context.push('/main/myPage/myinfo/jobTenure');
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * su),
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
