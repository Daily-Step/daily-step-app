import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/string_extension.dart';
import 'package:dailystep/model/challenge/challenge_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/widget_confirm_modal.dart';
import '../../action/challenge_list_action.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'challenge_item.dart';

class ChallengeList extends ConsumerStatefulWidget {
  const ChallengeList({
    Key? key,
  }) : super(key: key);

  @override
  _ChallengeListState createState() => _ChallengeListState();
}

class _ChallengeListState extends ConsumerState<ChallengeList> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(challengeViewModelProvider);
    final notifier = ref.read(challengeViewModelProvider.notifier);

    return state.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.challengeList.length,
              itemBuilder: (context, index) {
                final challenge = data.challengeList[index];
                final List<String> successDates = challenge.record
                    ?.successDates ?? [];
                final bool isAchieved = successDates
                    .any((date) =>
                    date.toDateTime.isSameDate(data.selectedDate));
                bool isAchievedWeeksGoal = checkIsAchieveWeeksGoal(
                    challenge, successDates);
                return ChallengeItem(
                  task: challenge,
                  index: index,
                  onTap: () async {
                    await notifier
                        .handleAction(FindChallengeAction(challenge.id));
                    context.push('/main/challenge/${challenge.id}');
                  },
                  onClickAchieveButton: () async {
                    if (!isAchieved && isAchievedWeeksGoal) {
                      showConfirmModal(
                          context: context,
                          content: Text('이번주 목표를 모두 달성했어요'),
                          confirmText: "확인",
                          onClickConfirm: (){},
                          isCancelButton: false);
                      return;
                    }
                    await notifier.handleAction(AchieveChallengeAction(
                      id: challenge.id,
                      context: context,
                      isCancel: isAchieved,
                    ));
                  },
                  isAchieved: isAchieved,
                );
              });
        },
        error: (Object error, StackTrace stackTrace) => SizedBox(),
        loading: () => SizedBox());
  }

  bool checkIsAchieveWeeksGoal(ChallengeModel challenge,
      List<String> successDates) {
    final int elapsedWeeks = challenge.startDateTime.calculateWeeksBetween(
        DateTime.now()) + 1;
    print(elapsedWeeks);
    final int thisWeekGoal = elapsedWeeks * challenge.weekGoalCount;
    return successDates.length >= thisWeekGoal;
  }
}
