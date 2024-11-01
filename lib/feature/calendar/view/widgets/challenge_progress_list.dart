import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'challenge_progress_card.dart';
import '../../viewmodel/calendar_viewmodel.dart';

class ChallengeProgressList extends ConsumerWidget {
  const ChallengeProgressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(calendarViewModelProvider);

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Change to min
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "진행 중 챌린지",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 12),
                if (events.isEmpty)
                  Center(
                    child: Text(
                      "진행 중인 챌린지가 없습니다.",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                else
                  Column(
                    children: events.map((event) {
                      return ChallengeProgressCard(
                        title: event.title,
                        period: event.period,
                        progress: event.progress,
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}