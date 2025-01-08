import 'package:flutter/material.dart';
import '../../../widgets/widget_buttons.dart';
import '../../../widgets/widget_constant.dart';
import '../../../widgets/widget_textfield.dart';

class NickNameFragment extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onCheckNickname;
  final String validation;
  final Color validationColor;
  final bool isNicknameCheckInProgress;

  const NickNameFragment({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onCheckNickname,
    required this.validation,
    required this.validationColor,
    this.isNicknameCheckInProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '사용하실 닉네임을 입력하세요',
          style: WAppFontSize.titleXL(),
        ),
        height30,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WTextField(
              controller: controller
                ..selection = TextSelection.collapsed(
                  offset: controller.text.length,
                ),
              hintText: '사용하실 닉네임을 입력하세요',
              hintStyle: WAppFontSize.values(),
              onChanged: (text) {
                onChanged(text);
              },
              isEnable: true,
              suffixButton: WRoundButton(
                isEnabled: !isNicknameCheckInProgress && controller.text.isNotEmpty && validation.isEmpty,
                onPressed: onCheckNickname,
                text: '중복확인',
                textStyle: WAppFontSize.values(),
              ),
            ),
            Padding(
              padding: globalMargin,
              child: Text(
                validation,
                style: TextStyle(fontSize: 14, color: validationColor),
              ),
            )
          ],
        )
      ],
    );
  }
}

