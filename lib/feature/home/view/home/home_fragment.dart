import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/home/reorderable_item.dart';
import 'package:dailystep/feature/home/view/home/reorderable_list.dart';
import 'package:dailystep/feature/home/view/home/week_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../model/challenge/challenge_model.dart';
import '../../action/challenge_list_action.dart';
import 'challenge_item.dart';
import '../../viewmodel/challenge_viewmodel.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool isEditing = false;

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
              Text(
                '진행 중 챌린지',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(isEditing ? Icons.done : Icons.edit),
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          ),
        ),
        WeekCalendar(challengeList: state.challengeList),
        Expanded(
          child: isEditing
              ? CachedReorderableListView(
                  list: state.challengeList,
                  itemBuilder: (BuildContext context, item, index) {
                    final bool isAchieved = item.successList.any((date) => date.isSameDate(DateTime.now()));

                    return ReorderableItem(
                      key: ValueKey('task_${item.id}'),
                      task: item,
                      index: index,
                      isEditing: isEditing,
                      onDismissed: (id) async {
                        await notifier.handleAction(RemoveTaskAction(id));
                      },
                      onTap: () {},
                      onClickAchieveButton: () {},
                      isAchieved: isAchieved,
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    notifier
                        .handleAction(ReorderTasksAction(oldIndex, newIndex));
                  },
                )
              : ListView.builder(
                  itemCount: state.challengeList.length,
                  itemBuilder: (context, index) {
                    final challenge = state.challengeList[index];
                    final bool isAchieved = challenge.successList.any((date) => date.isSameDate(DateTime.now()));
                    return ChallengeItem(
                      task: challenge,
                      index: index,
                      isEditing: isEditing,
                      onTap: () async {
                        await notifier.handleAction(FindTaskAction(challenge.id));
                        context.push('/main/home/${challenge.id}');
                      },
                      onClickAchieveButton: () async {
                        if(isAchieved == true){

                        } else {
                          await notifier.handleAction(FindTaskAction(challenge.id));
                          context.push('/main/home/record/edit/${challenge.id}');
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
