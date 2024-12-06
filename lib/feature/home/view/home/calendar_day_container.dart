import 'package:flutter/material.dart';

class CalendarDayContainer extends StatelessWidget {
  final bool isToday;
  final bool isSuccess;
  final bool isCurrentPeriod;
  final DateTime date;

  const CalendarDayContainer({
    required this.isToday,
    required this.isSuccess,
    required this.isCurrentPeriod,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isToday
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
          color: isToday || isSuccess
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
