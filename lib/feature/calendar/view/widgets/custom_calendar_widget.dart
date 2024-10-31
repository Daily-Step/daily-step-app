import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/calendar_viewmodel.dart';
import 'calendar_header.dart';
import 'calendar_body.dart';
import 'challenge_progress_list.dart';

class CustomCalendarWidget extends ConsumerWidget {
  const CustomCalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedDay = ref.watch(calendarViewModelProvider.notifier).focusedDay;

    return ListView(
      children: [
        CalendarHeader(
          focusedDay: focusedDay,
          onPreviousMonth: () => ref.read(calendarViewModelProvider.notifier).previousMonth(),
          onNextMonth: () => ref.read(calendarViewModelProvider.notifier).nextMonth(),
        ),
        CalendarBody(),
        const SizedBox(height: 20),
        ChallengeProgressList(),
      ],
    );
  }
}
