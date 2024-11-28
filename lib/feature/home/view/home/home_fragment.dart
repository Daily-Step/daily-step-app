import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_month_calendar.dart';
import 'package:dailystep/feature/home/view/home/week_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_dashed_border.dart';
import '../../action/challenge_list_action.dart';
import 'challenge_item.dart';
import '../../viewmodel/challenge_viewmodel.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    final state = ref.watch(challengeViewModelProvider);
    final notifier = ref.read(challengeViewModelProvider.notifier);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  today.formattedMonth,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () =>
                      showCalendarModal(context, _generateDummySuccessDates()),
                ),
              ]),
              Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3f4ec842-6f7a-4d31-ab32-a35b7c42e7d8/dgvd6bj-d8c21830-800a-4642-954f-249381540aae.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzNmNGVjODQyLTZmN2EtNGQzMS1hYjMyLWEzNWI3YzQyZTdkOFwvZGd2ZDZiai1kOGMyMTgzMC04MDBhLTQ2NDItOTU0Zi0yNDkzODE1NDBhYWUuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.DXNYAFrTUPlJjEfgUpPXR_YY_znMJ4qNWyu2QEG442E'),
              ),
            ],
          ),
        ),
        WeekCalendar(challengeList: state.challengeList),
        height20,
        state.challengeList.length == 0
            ? Padding(
                padding: globalMargin,
                child: CustomPaint(
                  painter: DashedBorderPainter(),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline,color: Colors.grey.shade300,),
                        width5,
                        Text(
                          '새 챌린지를 등록해보세요',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ), // 원하는 위젯 배치
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: state.challengeList.length,
                    itemBuilder: (context, index) {
                      final challenge = state.challengeList[index];
                      final bool isAchieved = challenge.successList
                          .any((date) => date.isSameDate(DateTime.now()));
                      return ChallengeItem(
                        task: challenge,
                        index: index,
                        onTap: () async {
                          await notifier
                              .handleAction(FindTaskAction(challenge.id));
                          context.push('/main/home/${challenge.id}');
                        },
                        onClickAchieveButton: () async {
                          if (isAchieved == false) {
                            List<DateTime> copiedChallengeSuccessList =
                                List<DateTime>.from(challenge.successList);
                            copiedChallengeSuccessList.add(DateTime.now());
                            final newChallenge = challenge.copyWith(
                                successList: copiedChallengeSuccessList);
                            await notifier.handleAction(
                                UpdateTaskAction(challenge.id, newChallenge));
                          }
                        },
                        isAchieved: isAchieved,
                      );
                    }),
              ),
      ],
    );
  }

  List<DateTime> _generateDummySuccessDates() {
    final now = DateTime.now();
    final oneMonthAgo = now.subtract(Duration(days: 30));

    List<DateTime> successDates = [];
    for (int i = 0; i <= 10; i++) {
      successDates.add(oneMonthAgo.add(Duration(days: i)));
    }

    return successDates;
  }
}
