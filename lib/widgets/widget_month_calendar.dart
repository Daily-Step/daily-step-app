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
        borderRadius: globalBorderRadius,
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
                      selectedMonth = DateTime(
                          selectedMonth.year, selectedMonth.month - 1, 1);
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
                    color: selectedMonth.isSameMonth(DateTime.now())
                        ? backgroundColor
                        : subTextColor,
                  ),
                  onPressed: () {
                    if (selectedMonth.isSameMonth(DateTime.now())) return;
                    setState(() {
                      selectedMonth = DateTime(
                          selectedMonth.year, selectedMonth.month + 1, 1);
                    });
                  },
                ),
              ],
            ),
            height10,
            WMonthCalendar(
              successDates: widget.successList,
              firstDateOfRange: selectedMonth,
              isModal: true,
              selectedDate: DateTime.now(),
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
  final DateTime firstDateOfRange;
  final bool isModal;
  final DateTime selectedDate;

  const WMonthCalendar({
    super.key,
    required this.successDates,
    required this.firstDateOfRange,
    required this.isModal,
    required this.selectedDate,
  });

  @override
  _WMonthCalendarState createState() => _WMonthCalendarState();
}

class _WMonthCalendarState extends State<WMonthCalendar> {
  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(
        widget.firstDateOfRange.year, widget.firstDateOfRange.month, 1);
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );
    final calendarGrid = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          final isSelected = date.isSameDate(widget.selectedDate) && date.isSameMonth(widget.firstDateOfRange);
          final isCurrentPeriod = date.isSameMonth(widget.firstDateOfRange);
          final isSuccess = widget.successDates
              .any((successDate) => successDate.isSameDate(date)) && date.isSameMonth(widget.firstDateOfRange);

          return CalendarDayContainer(
              isSelected: isSelected,
              isSuccess: isSuccess,
              date: date,
              isCurrentPeriod: isCurrentPeriod);
        },
      ),
    );

    return Column(
      children: [
        CalendarLabel(),
        SizedBox(height: 4),
        widget.isModal ? calendarGrid : Expanded(child: calendarGrid),
      ],
    );
  }
}
