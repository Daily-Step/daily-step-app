import 'package:dailystep/feature/mypage/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/mypage_viewmodel.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(myPageViewModelProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("마이페이지")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("마이페이지")),
      body: Column(
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
                              '${user.userName}님의 챌린지',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '내 정보 수정',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user.profileImageUrl.isNotEmpty
                            ? NetworkImage(user.profileImageUrl)
                            : NetworkImage(
                                'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3f4ec842-6f7a-4d31-ab32-a35b7c42e7d8/dgvd6bj-d8c21830-800a-4642-954f-249381540aae.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzNmNGVjODQyLTZmN2EtNGQzMS1hYjMyLWEzNWI3YzQyZTdkOFwvZGd2ZDZiai1kOGMyMTgzMC04MDBhLTQ2NDItOTU0Zi0yNDkzODE1NDBhYWUuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.DXNYAFrTUPlJjEfgUpPXR_YY_znMJ4qNWyu2QEG442E'),
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
    );
  }

  Widget _buildChallengeCards(UserModel user) {
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
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                children: [
                  Text(
                    challenge["title"] as String,
                    style: TextStyle(fontSize: 13),
                    softWrap: false,
                  ),
                  SizedBox(height: 4),
                  Text(
                    (challenge["count"] as int).toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("카테고리 설정"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 카테고리 설정 화면으로 이동
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("계정 설정"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 계정 설정 화면으로 이동
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Push 알림"),
                Switch(
                  value: ref
                          .watch(myPageViewModelProvider)
                          ?.isPushNotificationEnabled ??
                      false,
                  onChanged: (value) {
                    ref
                        .read(myPageViewModelProvider.notifier)
                        .togglePushNotification();
                  },
                ),
              ],
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("버전 정보"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.go('/main/myPage/version_info');
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
