import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/home/calendar_day_container.dart';
import 'package:flutter/material.dart';

import '../feature/home/view/home/calendar_label.dart';

class WWeekPageView extends StatefulWidget {
  final List<DateTime> successList;
  final DateTime selectedDate;
  final void Function(int) onPageChanged;

  const WWeekPageView(
      {super.key,
        required this.successList,
        required this.selectedDate,
        required this.onPageChanged,});

  @override
  State<WWeekPageView> createState() => _WWeekPageViewState();
}

class _WWeekPageViewState extends State<WWeekPageView> {
  final PageController _pageController = PageController(initialPage: 26);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: widget.onPageChanged,
      itemCount: 27,
      itemBuilder: (context, index) {
        return WWeekCalendar(
          successDates: widget.successList,
          selectedWeek: widget.selectedDate,
        );
      },
    );
  }
}
class WWeekCalendar extends StatefulWidget {
  final List<DateTime> successDates;
  final DateTime selectedWeek;

  WWeekCalendar({
    super.key,
    required this.successDates,
    required this.selectedWeek,
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
