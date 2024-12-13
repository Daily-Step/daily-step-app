import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

import '../feature/home/view/home/calendar_day_container.dart';
import '../feature/home/view/home/calendar_label.dart';

class WMonthModal extends StatefulWidget {
  final List<DateTime> successList;

  const WMonthModal({super.key, required this.successList});

  @override
  State<WMonthModal> createState() => _WMonthModalState();
}

class _WMonthModalState extends State<WMonthModal> {
  late DateTime selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: subTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1, 1);
                    });
                  },
                ),
                Text(
                  selectedMonth.formattedMonth,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: selectedMonth.isSameMonth(DateTime.now()) ? backgroundColor : subTextColor,
                  ),
                  onPressed: () {
                    if (selectedMonth.isSameMonth(DateTime.now())) return;
                    setState(() {
                      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 1);
                    });
                  },
                ),
              ],
            ),
            height10,
            WMonthCalendar(
              successDates: widget.successList,
              selectedMonth: selectedMonth,
              isModal: true,
            ),
            height20,
          ],
        ),
      ),
    );
  }
}

class WMonthCalendar extends StatefulWidget {
  final List<DateTime> successDates;
  final DateTime selectedMonth;
  final bool isModal;

  const WMonthCalendar({
    super.key,
    required this.successDates,
    required this.selectedMonth,
    required this.isModal,
  });

  @override
  _WMonthCalendarState createState() => _WMonthCalendarState();
}

class _WMonthCalendarState extends State<WMonthCalendar> {
  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(widget.selectedMonth.year, widget.selectedMonth.month, 1);
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    return Column(mainAxisSize: MainAxisSize.max, children: [
      CalendarLabel(),
      SizedBox(),

    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: widget.isModal ? 10 : 20,
          ),
          itemCount: 35,
          itemBuilder: (context, index) {
            final date = firstDayOfCalendar.add(Duration(days: index));
            final isToday = date.isSameDate(DateTime.now());
            final isCurrentPeriod = date.isSameMonth(widget.selectedMonth);
            final isSuccess = widget.successDates.any((successDate) => successDate.isSameDate(date));

            return CalendarDayContainer(isToday: isToday, isSuccess: isSuccess, date: date, isCurrentPeriod: isCurrentPeriod);
          },
        ),
      ),
    ),

    ]);
  }
}
