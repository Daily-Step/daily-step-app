import 'package:flutter/material.dart';

class CalendarLabel extends StatelessWidget {
  const CalendarLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
          .map((day) => Container(
                width: 30,
                child: Text(
                  day,
                  style: TextStyle(
                    color: day == 'Sun'
                        ? Colors.red
                        : day == 'Sat'
                            ? Colors.blue
                            : Colors.black54,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    );
  }
}
