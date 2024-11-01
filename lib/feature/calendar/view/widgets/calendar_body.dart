import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/calendar_model.dart';
import '../../viewmodel/calendar_viewmodel.dart';

class CalendarBody extends ConsumerWidget {
  const CalendarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(calendarViewModelProvider.notifier);
    final events = ref.watch(calendarViewModelProvider);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: _containerDecoration(),
      child: TableCalendar(
        firstDay: viewModel.firstDay,
        lastDay: viewModel.lastDay,
        focusedDay: viewModel.focusedDay,
        onDaySelected: (selectedDay, focusedDay) => viewModel.updateFocusedDay(selectedDay),
        onPageChanged: viewModel.updateFocusedDay,
        headerStyle: _headerStyle(),
        daysOfWeekStyle: _daysOfWeekStyle(),
        calendarBuilders: _calendarBuilders(viewModel, events),
        eventLoader: viewModel.loadEventsForDay,
        pageJumpingEnabled: false,
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  HeaderStyle _headerStyle() {
    return const HeaderStyle(
      headerPadding: EdgeInsets.all(10),
      titleTextStyle: TextStyle(fontSize: 0),
      formatButtonVisible: false,
      leftChevronVisible: false,
      rightChevronVisible: false,
    );
  }

  DaysOfWeekStyle _daysOfWeekStyle() {
    return const DaysOfWeekStyle(
      weekdayStyle: TextStyle(color: Colors.black),
      weekendStyle: TextStyle(color: Colors.blue),
    );
  }

  CalendarBuilders _calendarBuilders(CalendarViewModel viewModel, List<CalendarModel> events) {
    return CalendarBuilders(
      dowBuilder: (context, day) {
        final text = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1];
        final color = _getDowColor(day.weekday);

        return Center(
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        );
      },
      defaultBuilder: (context, date, _) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                date.day.toString(),
                style: TextStyle(color: _getDowColor(date.weekday)),
              ),
              if (viewModel.isSameDay(date, DateTime.now()))
                Positioned(
                  bottom: 2,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      markerBuilder: (context, date, events) {
        if (events.isEmpty) return null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(events.length, (index) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                color: _getMarkerColor(index),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
      todayBuilder: (context, date, _) {
        return Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              date.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Color _getDowColor(int weekday) {
    return weekday == DateTime.sunday
        ? Colors.red
        : (weekday == DateTime.saturday ? Colors.blue : Colors.black);
  }

  Color _getMarkerColor(int index) {
    const List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.amber,
    ];
    return colors[index % colors.length];
  }
}
