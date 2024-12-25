import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/model/record/record_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    return ListView.builder(
        itemCount: state.challengeList.length,
        itemBuilder: (context, index) {
          final challenge = state.challengeList[index];
          final bool isAchieved = challenge.record.successDates
              .any((date) => date.isSameDate(state.selectedDate));
          return ChallengeItem(
            task: challenge,
            index: index,
            onTap: () async {
              await notifier.handleAction(FindChallengeAction(challenge.id));
              context.push('/main/challenge/${challenge.id}');
            },
            onClickAchieveButton: () async {
              List<DateTime> copiedChallengeSuccessList =
                  List<DateTime>.from(challenge.record.successDates);
              if (isAchieved == false) {
                copiedChallengeSuccessList.add(state.selectedDate);
              } else {
                copiedChallengeSuccessList.removeLast();
              }
              final newChallenge = challenge.copyWith(
                  record:
                      RecordModel(successDates: copiedChallengeSuccessList));
              await notifier.handleAction(AchieveChallengeAction(
                  id: challenge.id,
                  challengeModel: newChallenge,
                  context: context,
                  isCancel: isAchieved));
            },
            isAchieved: isAchieved,
          );
        });
  }
}
