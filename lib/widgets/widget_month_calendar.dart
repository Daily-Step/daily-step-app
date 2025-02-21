import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import '../common/util/size_util.dart';
import '../feature/home/view/home/calendar_day_container.dart';
import '../feature/home/view/home/calendar_label.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WMonthModal extends HookWidget {
  final List<DateTime> successList;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final Color color;

  const WMonthModal({
    super.key,
    required this.successList,
    required this.startDateTime,
    required this.endDateTime,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final startMonth = useState(DateTime(startDateTime.year, startDateTime.month, 1));
    final endMonth = useState(DateTime(endDateTime.year, endDateTime.month + 1, 0));
    final selectedMonth = useState(DateTime(startDateTime.year, startDateTime.month, 1));
    final beforeMonthButtonDisabled = selectedMonth.value.isSameMonth(startMonth.value);
    final afterMonthButtonDisabled = selectedMonth.value.isSameMonth(endMonth.value);

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
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close, size: 24.0, color: subTextColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: beforeMonthButtonDisabled ? Colors.grey : Colors.black,
                  ),
                  onPressed: () {
                    if (!beforeMonthButtonDisabled) {
                      selectedMonth.value = DateTime(
                        selectedMonth.value.year,
                        selectedMonth.value.month - 1,
                        1,
                      );
                    }
                  },
                ),
                Spacer(),
                Text(
                  selectedMonth.value.formattedMonth,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: afterMonthButtonDisabled ? Colors.grey : Colors.black,
                  ),
                  onPressed: () {
                    if (!afterMonthButtonDisabled) {
                      selectedMonth.value = DateTime(
                        selectedMonth.value.year,
                        selectedMonth.value.month + 1,
                        1,
                      );
                    } else {
                      print("다음 달 이동 불가");
                    }
                  },
                ),
              ],
            ),
            height10,
            WMonthCalendar(
              successDates: successList,
              firstDateOfRange: selectedMonth.value,
              isModal: true,
              selectedDate: DateTime.now(),
              color: color,
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
    final firstDayOfMonth = DateTime(widget.firstDateOfRange.year, widget.firstDateOfRange.month, 1);
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );
    final today = DateTime.now();

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
          final isSuccess = widget.successDates.any((successDate) => successDate.isSameDate(date));
          final isToday = date.isSameDate(today);

          Color containerColor = Colors.transparent;
          Color textColor = isCurrentPeriod ? WAppColors.black : WAppColors.gray05;

          if (isToday) {
            if (isSuccess) {
              containerColor = widget.color;
              textColor = WAppColors.white;
            } else {
              containerColor = Colors.transparent;
              textColor = WAppColors.black;
            }
          }
          // "오늘 날짜"가 아닌 경우
          else {
            if (isSuccess && isCurrentPeriod) {
              containerColor = widget.color;
              textColor = WAppColors.white;
            }
          }

          // "선택된 날짜"가 오늘이 아닐 경우만 적용
          if (isSelected && !isToday) {
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
