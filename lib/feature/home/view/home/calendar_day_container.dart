import 'package:flutter/material.dart';

class CalendarDayContainer extends StatelessWidget {
  final Color containerColor;
  final Color textColor;
  final DateTime date;
  final BorderRadius borderRadius;

  const CalendarDayContainer({
    required this.containerColor,
    required this.textColor,
    required this.date,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        '${date.day}',
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
