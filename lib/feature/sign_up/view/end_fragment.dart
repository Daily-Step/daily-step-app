import 'package:flutter/material.dart';

import '../../../widgets/widget_constant.dart';

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
          style: WAppFontSize.titleL(color: WAppColors.gray05),
        ),
        height10,
        Text(
          '함께 도전해 볼까요?',
          style: WAppFontSize.titleXXL(),
        ),
        height20,
      ],
    );
  }
}
