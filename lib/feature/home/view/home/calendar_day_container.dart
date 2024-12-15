import 'package:flutter/material.dart';

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
                    ? Colors.blue
                    : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
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
