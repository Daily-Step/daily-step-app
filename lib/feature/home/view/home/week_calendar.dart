import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/home/calendar_day_container.dart';
import 'package:flutter/material.dart';

import 'calendar_label.dart';

class WeekCalendar extends StatefulWidget {
  final List<DateTime> successDates;
  final DateTime selectedWeek;

  WeekCalendar({
    super.key,
    required this.successDates,
    required this.selectedWeek,
  });

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  List<DateTime> _getWeekDays(DateTime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDays = _getWeekDays(widget.selectedWeek);
    return Column(children: [
      CalendarLabel(),
      SizedBox(height: 4),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 20,
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            final date = weekDays[index];
            final isToday = date.isSameDate(DateTime.now());
            final isCurrentPeriod = date.isSameMonth(widget.selectedWeek);
            final isSuccess = widget.successDates
                .any((successDate) => successDate.isSameDate(date));

            return CalendarDayContainer(
              isToday: isToday,
              isSuccess: isSuccess,
              date: date,
              isCurrentPeriod: isCurrentPeriod,
            );
          },
        ),
      )
    ]);
  }
}
