import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/nickname_settings/nickname_provider.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../widgets/widget_textfield.dart';

class NickNameScreen extends ConsumerWidget {
  const NickNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickNameState = ref.watch(nickNameProvider);
    final nickNameNotifier = ref.read(nickNameProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('닉네임'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/main/myPage/myinfo');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WTextField(
            controller: TextEditingController(text: nickNameState.nickName)
              ..selection = TextSelection.collapsed(
                offset: nickNameState.nickName.length,
              ),
            hintText: '사용하실 닉네임을 입력하세요',
            onChanged: (value) {
              nickNameNotifier.updateNickName(value); // 상태 업데이트
            },
            isEnable: nickNameState.isValid || nickNameState.nickName.isEmpty,
            suffixButton: WRoundButton(
              isEnabled: nickNameState.isValid,
              onPressed: () {
                // 중복 확인 로직 추가 가능
              },
              text: '중복확인',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}