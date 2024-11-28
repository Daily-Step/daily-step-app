import 'package:flutter/material.dart';

import '../../widgets/widget_constant.dart';

class EndFragment extends StatelessWidget {
  const EndFragment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height20,
        Text(
          '가입이 완료되었습니다',
          style: TextStyle(fontSize: 14, color: subTextColor),
        ),
        height5,
        Text(
          '함께 도전해 볼까요?',
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600 ),
        ),
        height20,
      ],
    );
  }
}
