import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/nickname_settings/nickname_provider.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../widgets/widget_confirm_text.dart';
import '../../../../../../widgets/widget_constant.dart';
import '../../../../../../widgets/widget_textfield.dart';

class NickNameScreen extends ConsumerWidget {
  final String initialNickname;

  const NickNameScreen({super.key, required this.initialNickname});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickNameState = ref.watch(nickNameProvider(initialNickname));
    final isNickNameValid = ref.watch(isNickNameValidProvider);
    final nickNameNotifier = ref.read(nickNameProvider(initialNickname).notifier);
    bool isSaveButtonEnabled = nickNameState.isValid && nickNameState.validationMessage == '사용 가능한 닉네임입니다. :)';


    // 화면에 기존 닉네임을 표시
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (nickNameState.nickName.isEmpty) {
        nickNameNotifier.updateNickName(initialNickname);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('닉네임', style: WAppFontSize.titleXL()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/main/myPage/myinfo');
          },
        ),
        actions: [
          WConfirmButton(
            onPressed: isSaveButtonEnabled
                ? () async {
              await nickNameNotifier.saveNickName(nickNameState.nickName);
              context.go('/main/myPage/myinfo');
            }
                : () {},  // 버튼 비활성화 시 null로 설정
            isValidProvider: isNickNameValid,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height20,
          WTextField(
            controller: nickNameState.controller,
            hintText: '사용하실 닉네임을 입력하세요',
            hintStyle: WAppFontSize.values(),
            textStyle: WAppFontSize.values(color: WAppColors.black),
            onChanged: (value) {
              nickNameNotifier.updateNickName(value);
            },
            isEnable: nickNameState.isValid || nickNameState.nickName.isEmpty,
            suffixButton: Container(
              child: WRoundButton(
                isEnabled: nickNameState.isValid,
                onPressed: () {
                  // 중복 확인 로직 추가
                  ref.read(nickNameProvider(initialNickname).notifier).checkNicknameDuplication(nickNameState.nickName);
                },
                text: '중복확인',
                textStyle: WAppFontSize.values(color: WAppColors.gray09),
              ),
            ),
          ),
          SizedBox(height: 8 * su),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * su),
            child: Text(
              nickNameState.validationMessage,
              style: TextStyle(color: nickNameState.validationColor),
            ),
          ),
        ],
      ),
    );
  }
}
