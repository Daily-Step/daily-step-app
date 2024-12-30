import 'package:dailystep/feature/mypage/model/mypage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/secure_storage/secure_storage_provider.dart';
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
          title: Text("마이페이지"),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("마이페이지")),
      body: Container(
        color: Color(0xffD8D8D8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // 배경색 설정
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // 그림자 색상 설정
                    blurRadius: 4,
                    offset: Offset(0, 2), // 그림자의 위치
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              TextButton(
                                onPressed: () {
                                  context.go('/main/myPage/myinfo');
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  backgroundColor: Color(0xffF8F8F8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  '내 정보 수정',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xff555555)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff2257FF),
                          child: Text(
                            '🥰',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildChallengeCards(user),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
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
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                children: [
                  Text(
                    challenge["title"] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(height: 4),
                  Text(
                    (challenge["count"] as int).toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "앱 설정",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Push 알림"),
                Switch(
                    value: ref.watch(myPageViewModelProvider)?.isPushNotificationEnabled ?? false,
                    onChanged: (value) {
                      ref.read(myPageViewModelProvider.notifier).togglePushNotification();
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Color(0xffD2D2D2),
                    trackOutlineColor: WidgetStatePropertyAll(Colors.transparent)),
              ],
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("계정 설정"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.go('/main/myPage/myinfo/account_settings/account');
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("문의하기"),
              trailing: Icon(Icons.arrow_forward_ios),
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
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("버전 정보"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.go('/main/myPage/version/version_info');
              },
            ),
            Divider(),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
