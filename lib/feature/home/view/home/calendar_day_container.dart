import 'package:flutter/material.dart';
import '../../../../widgets/widget_constant.dart';

class CalendarDayContainer extends StatelessWidget {
  final bool isSelected;
  final bool isSuccess;
  final bool isCurrentPeriod;
  final DateTime date;
  final bool isToday;
  final BorderRadius borderRadius;

  const CalendarDayContainer({
    required this.isSelected,
    required this.isSuccess,
    required this.date,
    this.isCurrentPeriod = true,
    this.isToday = false,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? WAppColors.black
            : isToday
                ? WAppColors.gray04
                : isSuccess
                    ? WAppColors.secondary
                    : Colors.transparent,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        '${date.day}',
        style: TextStyle(
          color: isSelected || isSuccess && !isToday
                  ? WAppColors.white
                  : isCurrentPeriod
                      ? WAppColors.black
                      : WAppColors.gray05,
          fontSize: 14,
        ),
      ),
    );
  }
}
