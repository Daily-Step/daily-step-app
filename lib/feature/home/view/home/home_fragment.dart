import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/viewmodel/calendar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/challenge/challenge_dummies.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_week_calendar.dart';
import 'challenge_empty.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'challenge_list.dart';

const int WEEK_TOTAL_PAGE = 26;

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final PageController weekPageController =
      PageController(initialPage: WEEK_TOTAL_PAGE);

  @override
  void dispose() {
    weekPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final challengeState = ref.watch(challengeViewModelProvider);
    final calendarState = ref.watch(calendarViewModelProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  calendarState.selectedDate.formattedMonth,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ]),
              Spacer(),
              CircleAvatar(
                backgroundColor: Color(0xff2257FF),
                child: Text(
                  '🥰',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 80,
          curve: Curves.easeInOut,
          child: WWeekPageView(
                  weekPageController: weekPageController,
                  successList: dummySuccessList,
                ),
        ),
        height20,
        challengeState.challengeList.length == 0
            ? ChallengeEmpty()
            : Expanded(
                child: ChallengeList(),
              ),
      ],
    );
  }
}
