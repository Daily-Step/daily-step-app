import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../model/challenge/challenge_dummies.dart';
import '../../../../widgets/widget_constant.dart';
import '../../action/challenge_list_action.dart';
import 'challenge_empty.dart';
import 'challenge_item.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'expandable_calendar.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool _isExpanded = false;
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    selectedDate = _isExpanded
        ? DateTime(selectedDate.year, selectedDate.month, 1)
        : selectedDate.getStartOfWeek();
    _pageController =
        PageController(initialPage: _isExpanded ? 6 : 26);
  }

  @override
  Widget build(BuildContext context) {
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
                  selectedDate.formattedMonth,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(_isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  onPressed: () => setState(() {
                    _isExpanded = !_isExpanded;
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
        ExpandableCalendar(
          successList: dummySuccessList,
          isExpanded: _isExpanded,
          selectedDate: selectedDate,
          pageController: _pageController,
            onPageChanged:(page) {
              setState(() {
                if (_isExpanded) {
                  selectedDate = DateTime(
                    currentDate.year,
                    currentDate.month + (page - 26),
                    1,
                  );
                } else {
                  selectedDate = currentDate
                      .add(Duration(days: (page - 26) * 7))
                      .getStartOfWeek();
                }
              });
            }
        ),
        height20,
        state.challengeList.length == 0
            ? ChallengeEmpty()
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
                          context.push('/main/challenge/challenge/${challenge.id}');
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
}
