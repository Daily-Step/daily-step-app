import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/calendar_viewmodel.dart';
import 'widgets/custom_calendar_widget.dart';

class CalendarScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(calendarViewModelProvider);

    if (events.isEmpty) {
      ref.read(calendarViewModelProvider.notifier).loadDummyData();
    }

    return Scaffold(
      body: SafeArea(
        child: CustomCalendarWidget(),
      ),
    );
  }
}
