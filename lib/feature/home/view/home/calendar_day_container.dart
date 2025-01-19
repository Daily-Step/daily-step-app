import 'package:flutter/material.dart';

import '../../../../common/util/size_util.dart';
import '../../../../widgets/widget_constant.dart';

class CalendarDayContainer extends StatelessWidget {
  final bool isSelected;
  final bool isSuccess;
  final bool isCurrentPeriod;
  final DateTime date;

  const CalendarDayContainer({
    required this.isSelected,
    required this.isSuccess,
    required this.isCurrentPeriod,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.black
            : isSuccess
                ? WAppColors.secondary
                : Colors.transparent,
        borderRadius: BorderRadius.circular(12 * su),
      ),
      alignment: Alignment.center,
      child: Text(
        '${date.day}',
        style: TextStyle(
          color: isSelected || isSuccess
              ? Colors.white
              : isCurrentPeriod
                  ? Colors.black
                  : Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
