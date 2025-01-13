import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/feature/mypage/model/mypage_model.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/secure_storage/secure_storage_provider.dart';
import '../../../widgets/widget_constant.dart';
import '../viewmodel/mypage_viewmodel.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(myPageViewModelProvider);

    final secureStorage = ref.watch(secureStorageServiceProvider).getAccessToken();

    // 비동기적으로 SecureStorage에서 데이터 읽기
    Future<void> readAndLog() async {
      String? accessToken = await secureStorage;
      print('Access Token from SecureStorage: $accessToken');
    }

    // 화면이 빌드될 때 readAndLog() 호출
    readAndLog();

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("마이페이지", style: WAppFontSize.titleXL()),
          backgroundColor: Colors.white,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "마이페이지",
          style: WAppFontSize.titleXL(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: WAppColors.gray02,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16 * su)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0 * su),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.nickname}님의 챌린지',
                                style: TextStyle(fontSize: 20 * su, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4 * su),
                              Container(
                                width: 95 * su,
                                height: 30 * su,
                                child: TextButton(
                                  onPressed: () {
                                    context.go('/main/myPage/myinfo');
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 8 * su, vertical: 4 * su),
                                    backgroundColor: WAppColors.gray02,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16 * su),
                                    ),
                                  ),
                                  child: Text(
                                    '내 정보 수정',
                                    style: TextStyle(
                                      fontSize: 13 * su,
                                      fontWeight: WAppTextStyle.regular,
                                      color: WAppColors.gray07,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16 * su),
                        CircleAvatar(
                          radius: 40 * su,
                          backgroundColor: Color(0xff2257FF),
                          child: Text(
                            '🥰',
                            style: TextStyle(fontSize: 30 * su),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * su),
                    _buildChallengeCards(user),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16 * su),
            _buildSettingsContainer(ref, context),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCards(MyPageModel user) {
    final challenges = [
      {"title": "진행 중 챌린지 수", "count": user.ongoingChallenges},
      {"title": "완료한 챌린지 수", "count": user.completedChallenges},
      {"title": "누적 챌린지 수", "count": user.totalChallenges},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: challenges.map((challenge) {
        return Expanded(
          child: Card(
            color: Colors.black,
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0 * su),
              child: Column(
                children: [
                  Text(
                    challenge["title"] as String,
                    style: TextStyle(fontSize: 13 * su, color: WAppColors.gray03),
                    softWrap: false,
                  ),
                  SizedBox(height: 8 * su),
                  Text(
                    (challenge["count"] as int).toString(),
                    style: TextStyle(fontSize: 24 * su, fontWeight: WAppTextStyle.extraBold, color: WAppColors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSettingsContainer(WidgetRef ref, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * su),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0 * su),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "앱 설정",
              style: TextStyle(fontSize: 15 * su, fontWeight: FontWeight.w300, color: WAppColors.gray05),
            ),
            SizedBox(height: 35 * su),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Push 알림", style: TextStyle(fontSize: 16 * su)),
                FlutterSwitch(
                  value: ref.watch(myPageViewModelProvider)?.isPushNotificationEnabled ?? false,
                  onToggle: (value) async {
                    final notifier = ref.read(myPageViewModelProvider.notifier);

                    try {
                      // 푸시 알림 상태 변경 요청
                      await notifier.togglePushNotification(context, value: value);
                    } catch (e) {
                      // 오류 발생 시 로그 출력 (필요시 사용자 안내 가능)
                      print('푸시 알림 상태 변경 중 오류: $e');
                    }
                  },
                  activeColor: Colors.black,
                  inactiveColor: const Color(0xffD2D2D2),
                  activeToggleColor: Colors.white,
                  inactiveToggleColor: Colors.white,
                  width: 50.0 * su,
                  height: 24.0 * su,
                  toggleSize: 20.0 * su,
                  borderRadius: 20.0 * su,
                  padding: 2.0 * su,
                  activeText: "ON",
                  inactiveText: "OFF",
                  showOnOff: false,
                ),
              ],
            ),
            SizedBox(
              height: 19.5 * su,
            ),
            Divider(height: 1 * su),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("계정 설정", style: TextStyle(fontSize: 16 * su)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16 * su),
              onTap: () {
                context.go('/main/myPage/myinfo/account_settings/account');
              },
            ),
            Divider(height: 1 * su),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("문의하기", style: TextStyle(fontSize: 16 * su)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16 * su),
              onTap: () async {
                const url = 'https://docs.google.com/forms/d/e/1FAIpQLSfNdMgr94MfE46QLKCgEQ8NgTVYdCXQjakzJvuRwHJcucCsKQ/viewform';

                final Uri uri = Uri.parse(url);

                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw '해당 주소를 가져올 수 없습니다.';
                }
              },
            ),
            Divider(height: 1 * su),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("버전 정보", style: TextStyle(fontSize: 16 * su)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16 * su),
              onTap: () {
                context.go('/main/myPage/version/version_info');
              },
            ),
            Divider(height: 1 * su),
            SizedBox(height: 50 * su),
          ],
        ),
      ),
    );
  }
}
