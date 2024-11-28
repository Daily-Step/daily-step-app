import 'package:flutter/material.dart';
import '../../widgets/widget_buttons.dart';
import '../../widgets/widget_constant.dart';
import '../../widgets/widget_textfield.dart';

class NickNameFragment extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String validation;

  const NickNameFragment({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '사용하실 닉네임을 입력하세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height30,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WTextField(
              controller: controller,
              hintText: '사용하실 닉네임을 입력하세요',
              onChanged: onChanged,
              isEnable: validation == '',
              suffixButton: WRoundButton(
                isEnabled: controller.text != '' && validation == '',
                onPressed: () {},
                text: '중복확인',
              ),
            ),
            Padding(
              padding: globalMargin,
              child: Text(
                validation,
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            )
          ],
        )
      ],
    );
  }
}