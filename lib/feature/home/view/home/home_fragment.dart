import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/viewmodel/calendar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/challenge/challenge_dummies.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_month_calendar.dart';
import '../../../../widgets/widget_week_calendar.dart';
import '../../action/calendar_action.dart';
import 'challenge_empty.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'challenge_list.dart';

const int DAY_TOTAL_PAGE = 180;
const int WEEK_TOTAL_PAGE = 26;
const int MONTH_TOTAL_PAGE = 6;

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final PageController weekPageController =
      PageController(initialPage: WEEK_TOTAL_PAGE);
  final PageController monthPageController =
      PageController(initialPage: MONTH_TOTAL_PAGE);

  @override
  void dispose() {
    weekPageController.dispose();
    monthPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final challengeState = ref.watch(challengeViewModelProvider);
    final calendarState = ref.watch(calendarViewModelProvider);
    final calendarNotifier = ref.read(calendarViewModelProvider.notifier);
    final isExpanded = calendarState.isExpanded;

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
                IconButton(
                  icon: Icon(isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  onPressed: () => setState(() {
                    calendarNotifier.handleAction(ChangeExpandAction(
                        controller: isExpanded
                            ? weekPageController
                            : monthPageController));
                  }),
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
          height: isExpanded ? 240 : 80,
          curve: Curves.easeInOut,
          child: isExpanded
              ? WMonthPageView(
                  monthPageController: monthPageController,
                  successList: dummySuccessList,
                )
              : WWeekPageView(
                  weekPageController: weekPageController,
                  successList: dummySuccessList,
                ),
        ),
        height20,
        challengeState.challengeList.length == 0
            ? ChallengeEmpty()
            : Expanded(
                child: ChallengeListPageView(
                  onPageChanged: (page) {
                    setState(() {
                      calendarNotifier.handleAction(ChangeSelectedDateAction(
                          addPage: page - DAY_TOTAL_PAGE,
                          controller: isExpanded
                              ? monthPageController
                              : weekPageController));
                    });
                  },
                ),
              ),
      ],
    );
  }
}
