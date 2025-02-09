import 'dart:async';

import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/feature/home/viewmodel/challenge_viewmodel.dart';
import 'package:dailystep/feature/mypage/model/mypage_model.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../viewmodel/mypage_viewmodel.dart';

class MyPageScreen extends HookConsumerWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(myPageViewModelProvider);
    final notifier = ref.watch(myPageViewModelProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        await notifier.loadUserData(); // 첫 로딩 시 API 호출
      });
      return null;
    }, []);

    // ✅ challengeViewModelProvider의 변경 사항 감지 후 API 호출
    ref.listen(challengeViewModelProvider, (prev, next) {
      final prevChallengeData = prev?.asData?.value;
      final nextChallengeData = next.asData?.value;

      if (prevChallengeData != nextChallengeData && nextChallengeData != null) {
        notifier.loadUserData(); // 상태 변경 시 API 호출
      }
    });

    useEffect(() {
      Future<void> fetchUserData() async {
        final prefs = await SharedPreferences.getInstance();
        final storedPushState = prefs.getBool('isPushNotificationEnabled') ?? false;

        // ✅ 상태 변경이 필요할 때만 업데이트
        if (ref.read(myPageViewModelProvider)?.isPushNotificationEnabled != storedPushState) {
          ref.read(myPageViewModelProvider.notifier).updatePushState(storedPushState);
        }
      }

      fetchUserData();
      return null;
    }, []);


    // 만약 데이터가 없으면 기본 UI를 빈 화면으로 처리
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("마이페이지", style: WAppFontSize.titleXL()),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Text("데이터를 불러오는 중...", style: TextStyle(fontSize: 16, color: Colors.black54)),
        ),
      );
    }

    return _buildMyPageScreen(context, user, ref);
  }


  Widget _buildMyPageScreen(BuildContext context, MyPageModel user, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("마이페이지", style: WAppFontSize.titleXL()),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildProfileSection(user, context),
          _buildChallengeCards(user),
          height10,
          _buildSettingsContainer(ref, context),
        ],
      ),
    );
  }

  /// 프로필 섹션 (닉네임, 프로필 이미지)
  Widget _buildProfileSection(MyPageModel user, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0 * su),
        child: Row(
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
                  SizedBox(
                    width: 95 * su,
                    height: 30 * su,
                    child: TextButton(
                      onPressed: () => context.go('/main/myPage/myinfo'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8 * su, vertical: 4 * su),
                        backgroundColor: WAppColors.gray02,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * su)),
                      ),
                      child: Text(
                        '내 정보 수정',
                        style:
                            TextStyle(fontSize: 13 * su, fontWeight: WAppTextStyle.regular, color: WAppColors.gray07),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16 * su),
            CircleAvatar(
              radius: 40 * su,
              backgroundColor: Colors.transparent,
              child: user.profileImageUrl.isNotEmpty
                  ? ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/ellipse.png',
                        image: user.profileImageUrl,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 700),
                        width: 80 * su,
                        height: 80 * su,
                      ),
                    )
                  : Container(
                width: 80 * su,
                height: 80 * su,
                decoration: BoxDecoration(
                  color: WAppColors.secondary1,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '🥰',
                  style: TextStyle(fontSize: 30 * su, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 챌린지 카드 섹션
  Widget _buildChallengeCards(MyPageModel user) {
    final challenges = [
      {"title": "진행 중 챌린지 수", "count": user.ongoingChallenges},
      {"title": "완료한 챌린지 수", "count": user.completedChallenges},
      {"title": "누적 챌린지 수", "count": user.totalChallenges},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16 * su)),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 16.0 * su, left: 16.0 * su, bottom: 8.0 * su),
        child: Row(
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
                      Text(challenge["title"] as String, style: TextStyle(fontSize: 13 * su, color: WAppColors.gray03)),
                      SizedBox(height: 8 * su),
                      Text(
                        (challenge["count"] as int).toString(),
                        style:
                            TextStyle(fontSize: 24 * su, fontWeight: WAppTextStyle.extraBold, color: WAppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 설정 컨테이너 (Push 알림, 계정 설정, 문의하기, 버전 정보)
  Widget _buildSettingsContainer(WidgetRef ref, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * su),
      ),
      child: Column(
        children: [
          _buildPushNotificationToggle(ref, context),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * su, right: 16.0 * su),
            child: Divider(
              color: WAppColors.gray03,
            ),
          ),
          ListTile(
            title: Text("계정 설정"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20 * su,
              color: WAppColors.black,
            ),
            onTap: () => context.go('/main/myPage/myinfo/account_settings/account'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * su, right: 16.0 * su),
            child: Divider(
              color: WAppColors.gray03,
            ),
          ),
          ListTile(
            title: Text("문의하기"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20 * su,
              color: WAppColors.black,
            ),
            onTap: () async {
              const url =
                  'https://docs.google.com/forms/d/e/1FAIpQLSfNdMgr94MfE46QLKCgEQ8NgTVYdCXQjakzJvuRwHJcucCsKQ/viewform';

              final Uri uri = Uri.parse(url);

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw '해당 주소를 가져올 수 없습니다.';
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * su, right: 16.0 * su),
            child: Divider(),
          ),
          ListTile(
            title: Text("버전 정보"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20 * su,
              color: WAppColors.black,
            ),
            onTap: () => context.go('/main/myPage/version/version_info'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * su, right: 16.0 * su),
            child: Divider(
              color: WAppColors.gray03,
            ),
          ),
          height70
        ],
      ),
    );
  }
}

Widget _buildPushNotificationToggle(WidgetRef ref, BuildContext context) {
  final isPushEnabled = ref.watch(myPageViewModelProvider)?.isPushNotificationEnabled ?? false;
  final notifier = ref.read(myPageViewModelProvider.notifier);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0 * su),
        child: Text(
          "앱 설정",
          style: TextStyle(fontSize: 15 * su, fontWeight: FontWeight.w300, color: WAppColors.gray05),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0 * su),
            child: Text("매일 챌린지 알림", style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0 * su),
            child: Container(
              height: 28 * su,
              width: 55 * su,
              child: FlutterSwitch(
                value: isPushEnabled,
                onToggle: (value) async {
                  final prefs = await SharedPreferences.getInstance();
                  bool hasAskedBefore = prefs.getBool('hasAskedNotificationPermission') ?? false;

                  if (value && !hasAskedBefore) {
                    bool userConsent = await notifier.showPermissionDialog(context);
                    if (!userConsent) {
                      print("❌ 유저가 거부함. 토글 원래 상태 유지");
                      return;
                    }
                    await prefs.setBool('hasAskedNotificationPermission', true);
                  }

                  bool newState = await notifier.togglePushNotification(context, value: value);
                  notifier.updatePushState(newState);
                },
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
