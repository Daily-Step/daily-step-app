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
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3f4ec842-6f7a-4d31-ab32-a35b7c42e7d8/dgvd6bj-d8c21830-800a-4642-954f-249381540aae.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzNmNGVjODQyLTZmN2EtNGQzMS1hYjMyLWEzNWI3YzQyZTdkOFwvZGd2ZDZiai1kOGMyMTgzMC04MDBhLTQ2NDItOTU0Zi0yNDkzODE1NDBhYWUuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.DXNYAFrTUPlJjEfgUpPXR_YY_znMJ4qNWyu2QEG442E'),
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
}
