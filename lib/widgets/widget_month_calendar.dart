import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

void showCalendarModal(BuildContext context, List<DateTime> successList) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WMonthCalendar(
                    successDates: successList,
                    initialMonth: DateTime.now()),
                height20,
              ],
            ),
          ),
        );
      });
}

class WMonthCalendar extends StatefulWidget {
  final List<DateTime> successDates;
  final DateTime initialMonth;

  const WMonthCalendar({
    super.key,
    required this.successDates,
    required this.initialMonth,
  });

  @override
  _WMonthCalendarState createState() => _WMonthCalendarState();
}

class _WMonthCalendarState extends State<WMonthCalendar> {
  late DateTime _selectedMonth;
  late List<DateTime> _filteredSuccessDates;

  @override
  void initState() {
    super.initState();
    _selectedMonth = widget.initialMonth;
    _filterSuccessDates();
  }

  void _filterSuccessDates() {
    _filteredSuccessDates = widget.successDates.where((date) {
      // 현재 선택된 월의 이전, 현재, 다음 달 데이터 포함
      return date.year == _selectedMonth.year &&
          (date.month == _selectedMonth.month ||
              date.month == _selectedMonth.month - 1 ||
              date.month == _selectedMonth.month + 1);
    }).toList();
  }

  void _changeMonth(int monthOffset) {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + monthOffset);
      _filterSuccessDates();
    });
  }

  bool _hasNextMonthData() {
    return widget.successDates.any((date) =>
    date.year == _selectedMonth.year &&
        date.month == _selectedMonth.month + 1
    );
  }

  bool _hasPreviousMonthData() {
    return widget.successDates.any((date) =>
    date.year == _selectedMonth.year &&
        date.month == _selectedMonth.month - 1
    );
  }

  @override
  Widget build(BuildContext context) {
    // 선택된 월의 첫 날
    final firstDayOfMonth = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    // 첫 주의 시작일 (일요일부터)
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: _hasPreviousMonthData()
                  ? () => _changeMonth(-1)
                  : null,
              color: Colors.grey,
              disabledColor: Colors.transparent,
            ),
            Text(
              _selectedMonth.formattedMonth,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: _hasNextMonthData()
                  ? () => _changeMonth(1)
                  : null,
              color: Colors.grey,
              disabledColor: Colors.transparent,
            ),
          ],
        ),
        // 기존 캘린더 위젯 코드 유지 (수정 필요한 부분만 변경)
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 42,
          itemBuilder: (context, index) {
            final date = firstDayOfCalendar.add(Duration(days: index));
            final isCurrentMonth = date.month == _selectedMonth.month;
            final isToday = date.isSameDate(DateTime.now());

            final isAllAchieved = _filteredSuccessDates.any(
                    (successDate) => successDate.isSameDate(date)
            );

            Color backgroundColor = Colors.transparent;
            if (isToday) {
              backgroundColor = Colors.black;
            } else if (isAllAchieved && isCurrentMonth) {
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
                      (backgroundColor == Colors.blue && isCurrentMonth)
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
}
