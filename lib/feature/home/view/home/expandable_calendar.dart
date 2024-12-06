import 'package:dailystep/feature/home/view/home/week_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../widgets/widget_month_calendar.dart';

class ExpandableCalendar extends StatefulWidget {
  final List<DateTime> successList;
  final bool isExpanded;
  final DateTime selectedDate;
  final void Function(int) onPageChanged;
  final PageController pageController;

  const ExpandableCalendar({
    Key? key,
    required this.successList,
    required this.isExpanded,
    required this.selectedDate,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  _ExpandableCalendarState createState() => _ExpandableCalendarState();
}

class _ExpandableCalendarState extends State<ExpandableCalendar> {
  late ScrollDirection controllerDirection = ScrollDirection.idle;
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          setState(() {
            print(notification.direction != ScrollDirection.reverse );
            controllerDirection = notification.direction;
          });
        }
        return true;
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: widget.isExpanded ? 240 : 80,
            curve: Curves.easeInOut,
            child: PageView.builder(
              controller: widget.pageController,
              onPageChanged: widget.onPageChanged,
              itemBuilder: (context, index) {
                return _buildCalendarContent();
              },
              physics: CustomPageScrollPhysics(
                  canScrollForward: controllerDirection != ScrollDirection.reverse ,
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarContent() {
    return widget.isExpanded
        ? WMonthCalendar(
            successDates: widget.successList,
            selectedMonth: widget.selectedDate,
            isModal: false,
          )
        : WeekCalendar(
            successDates: widget.successList,
            selectedWeek: widget.selectedDate,
          );
  }
}
///TODO: 이번주일때 역방향 스크롤 차단 기능 구현중
class CustomPageScrollPhysics extends ScrollPhysics {
  final bool canScrollForward;

  const CustomPageScrollPhysics({
    ScrollPhysics? parent,
    this.canScrollForward = true,
  }) : super(parent: parent);

  @override
  CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageScrollPhysics(
      parent: buildParent(ancestor),
      canScrollForward: canScrollForward,
    );
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return canScrollForward ||
        position.pixels <= position.minScrollExtent;
  }
}
