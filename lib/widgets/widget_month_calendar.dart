import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import '../common/util/size_util.dart';
import '../feature/home/view/home/calendar_day_container.dart';
import '../feature/home/view/home/calendar_label.dart';

class WMonthModal extends StatefulWidget {
  final List<DateTime> successList;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final Color color;

  const WMonthModal(
      {super.key,
      required this.successList,
      required this.startDateTime,
      required this.endDateTime,
      required this.color});

  @override
  State<WMonthModal> createState() => _WMonthModalState();
}

class _WMonthModalState extends State<WMonthModal> {
  late DateTime endMonth = widget.endDateTime.isBefore(DateTime.now())
      ? DateTime(widget.endDateTime.year, widget.endDateTime.month, 1)
      : DateTime.now();

  late DateTime selectedMonth =
      widget.endDateTime.isBefore(DateTime.now()) ? endMonth : DateTime.now();

  late DateTime startMonth =
      DateTime(widget.startDateTime.year, widget.startDateTime.month, 1);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: globalBorderRadius,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  ' 달성한 날',
                  style: WAppFontSize.titleS(),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // 닫기 동작
                  },
                  child: Icon(Icons.close,
                      size: 24.0, color: subTextColor // 아이콘 크기 설정
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: selectedMonth.isSameMonth(startMonth)
                        ? backgroundColor
                        : subTextColor,
                  ),
                  onPressed: () {
                    if (selectedMonth.isSameMonth(startMonth)) return;
                    setState(() {
                      selectedMonth = DateTime(
                          selectedMonth.year, selectedMonth.month - 1, 1);
                    });
                  },
                ),
                Spacer(),
                Text(
                  selectedMonth.formattedMonth,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: selectedMonth.isSameMonth(endMonth)
                        ? backgroundColor
                        : subTextColor,
                  ),
                  onPressed: () {
                    if (selectedMonth.isSameMonth(endMonth)) return;
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
              color: widget.color,
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
  final Color color;

  const WMonthCalendar({
    super.key,
    required this.successDates,
    required this.firstDateOfRange,
    required this.isModal,
    required this.selectedDate,
    required this.color,
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
          final isSelected = date.isSameDate(widget.selectedDate);
          final isCurrentPeriod = date.isSameMonth(widget.firstDateOfRange);
          final isSuccess = widget.successDates
              .any((successDate) => successDate.isSameDate(date));

          Color containerColor = Colors.transparent;
          Color textColor =
              isCurrentPeriod ? WAppColors.black : WAppColors.gray05;
          if (isSuccess) {
            containerColor = widget.color;
            textColor = WAppColors.white;
          }
          if (isSelected) {
            containerColor = WAppColors.black;
            textColor = WAppColors.white;
          }

          return CalendarDayContainer(
            containerColor: containerColor,
            textColor: textColor,
            date: date,
            borderRadius: BorderRadius.circular(12 * su),
          );
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
