import 'package:flutter/material.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_dashed_border.dart';

class ChallengeEmpty extends StatelessWidget {
  const ChallengeEmpty();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: globalMargin,
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: Container(
          height: 150,
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.grey.shade300,
              ),
              width5,
              Text(
                '새 챌린지를 등록해보세요',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w600),
              )
            ],
          ), // 원하는 위젯 배치
        ),
      ),
    );
  }
}
