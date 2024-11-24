import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:flutter/material.dart';

class MonthCalendar extends StatelessWidget {
  final List<DateTime> successDates;
  final DateTime selectedMonth;

  MonthCalendar({
    super.key,
    required this.successDates,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    // 선택된 월의 첫 날
    final firstDayOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month, 1);
    // 해당 월의 마지막 날
    final lastDayOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    // 첫 주의 시작일 (일요일부터)
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
              .map((day) => Text(
                    day,
                    style: TextStyle(
                      color: day == 'Sun'
                          ? Colors.red
                          : day == 'Sat'
                              ? Colors.blue
                              : Colors.black54,
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
        // 달력 그리드
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 42,
          // 6주 x 7일
          itemBuilder: (context, index) {
            final date = firstDayOfCalendar.add(Duration(days: index));
            final isCurrentMonth = date.month == selectedMonth.month;
            final isToday = date.isSameDate(DateTime.now());

            final isAllAchieved = _isDateAchieved(date, successDates);

            Color backgroundColor = Colors.transparent;
            if (isToday) {
              backgroundColor = Colors.black;
            } else if (isAllAchieved && isCurrentMonth ) {
              backgroundColor = Colors.blue;
            }

            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: backgroundColor == Colors.black ||
                          backgroundColor == Colors.blue && isCurrentMonth
                      ? Colors.white
                      : isCurrentMonth
                          ? Colors.black
                          : Colors.grey,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  bool _isDateAchieved(DateTime date, List<DateTime> successDates) {
    return successDates.any((successDate) => successDate.isSameDate(date));
  }
}
