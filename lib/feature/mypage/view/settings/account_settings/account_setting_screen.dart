import 'package:dailystep/config/route/auth_redirection.dart';
import 'package:dailystep/feature/auth/viewmodel/login_viewmodel.dart';
import 'package:dailystep/widgets/widget_confirm_modal.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/util/size_util.dart';

class AccountSettingScreen extends ConsumerWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  final _secureStorage = const FlutterSecureStorage();

  Future<void> _deleteAccessToken() async {
    await _secureStorage.delete(key: 'access_token');
    print('Access Token 삭제 완료');
  }

  void handleLogout(BuildContext context, WidgetRef ref) {
    final auth = DailyStepAuthScope.of(context); // 인스턴스 가져오기

    showConfirmModal(
        context: context,
        content: Column(
          children: [
            Text(
              '정말로 로그아웃 하시겠어요?',
              style: WAppFontSize.titleL(),
            ),
            height5,
            Text(
              '챌린지 수행은 로그인 후 가능해요',
              style: WAppFontSize.bodyS1(),
            )
          ],
        ),
        confirmText: '로그아웃',
        isCancelButton: true,
        onClickConfirm: () async {
          await _deleteAccessToken();
          auth.signOut(); // 인스턴스 메서드 호출
          context.go('/signIn');
        },
    );
  }

  Future<void> handleAccountDeletion(BuildContext context) async {
    const url = 'https://docs.google.com/forms/d/e/1FAIpQLSfrKhMPVUThBZq0jvHy8dX38WU95e0lLTYqg69l62jAl8SGIg/viewform';
    final Uri uri = Uri.parse(url);

    showConfirmModal(
      context: context,
      content: Column(
        children: [
          Text(
            '정말로 탈퇴하시겠어요?',
            style: WAppFontSize.titleL(),
          ),
          height5,
          Text(
            '한 번 탈퇴하면 복구가 힘들어요',
            style: WAppFontSize.bodyS1(),
          )
        ],
      ),
      confirmText: '회원탈퇴',
      isCancelButton: true,
      onClickConfirm: () async {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = DailyStepAuthScope.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text('계정 설정', style: WAppFontSize.titleXL(),),
        leading: IconButton(
          onPressed: () {
            context.go('/main/myPage');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0 * su),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '로그아웃',
                    style: WAppFontSize.values(color: WAppColors.black),
                  ),
                  IconButton(
                    onPressed: () async{
                      await _deleteAccessToken();
                      auth.signOut(); // 인스턴스 메서드 호출
                      context.go('/signIn');
                    },
                    icon: Icon(Icons.keyboard_arrow_right),
                  )
                ],
              ),
              Divider(), // Row 외부에 위치
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '회원탈퇴',
                    style: WAppFontSize.values(color: WAppColors.black),
                  ),
                  IconButton(
                    onPressed: () => handleAccountDeletion(context),
                    icon: Icon(Icons.keyboard_arrow_right),
                  )
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
