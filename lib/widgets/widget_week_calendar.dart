import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/home/calendar_day_container.dart';
import 'package:flutter/material.dart';

import '../feature/home/view/home/calendar_label.dart';
import '../feature/home/view/home/home_fragment.dart';

class WWeekPageView extends StatefulWidget {
  final List<DateTime> successList;
  final DateTime firstDateOfRange;
  final DateTime selectedDate;
  final void Function(int) onPageChanged;
  final PageController weekPageController;

  const WWeekPageView({
    super.key,
    required this.successList,
    required this.firstDateOfRange,
    required this.onPageChanged,
    required this.selectedDate,
    required this.weekPageController,
  });

  @override
  State<WWeekPageView> createState() => _WWeekPageViewState();
}

class _WWeekPageViewState extends State<WWeekPageView> {

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.weekPageController,
      onPageChanged: widget.onPageChanged,
      itemCount: WEEK_TOTAL_PAGE + 1,
      itemBuilder: (context, index) {
        return WWeekCalendar(
          successDates: widget.successList,
          firstDateOfRange: widget.firstDateOfRange,
          selectedDate: widget.selectedDate,
        );
      },
    );
  }
}

class WWeekCalendar extends StatefulWidget {
  final List<DateTime> successDates;
  final DateTime firstDateOfRange;
  final DateTime selectedDate;

  WWeekCalendar({
    super.key,
    required this.successDates,
    required this.firstDateOfRange,
    required this.selectedDate,
  });

  @override
  State<WWeekCalendar> createState() => _WWeekCalendarState();
}

class _WWeekCalendarState extends State<WWeekCalendar> {
  List<DateTime> _getWeekDays(DateTime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDays = _getWeekDays(widget.firstDateOfRange);
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
            final isToday = date.isSameDate(widget.selectedDate);
            final isCurrentPeriod = date.isSameMonth(widget.firstDateOfRange);
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
