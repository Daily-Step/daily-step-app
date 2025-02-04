import 'package:dailystep/common/util/size_util.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_dashed_border.dart';

class ChallengeEmpty extends StatelessWidget {
  const ChallengeEmpty();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: Container(
        height: 150,
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                '새 챌린지를 등록해보세요',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w600),
              ),
            ),
            height5,
            Icon(
              Icons.arrow_downward,
              color: Colors.grey.shade300,
              size: 30 * su,
            ),
          ],
        ), // 원하는 위젯 배치
      ),
    );
  }
}
