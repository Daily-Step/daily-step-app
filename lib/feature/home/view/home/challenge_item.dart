import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/widgets/widget_card.dart';
import 'package:flutter/material.dart';
import '../../../../model/challenge/challenge_model.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_progress_indicator.dart';

class ChallengeItem extends StatelessWidget {
  final ChallengeModel task;
  final int index;
  final bool isAchieved;
  final bool isExpired;
  final VoidCallback? onTap;
  final VoidCallback? onClickAchieveButton;

  const ChallengeItem({
    Key? key,
    required this.task,
    required this.index,
    required this.onTap,
    required this.onClickAchieveButton,
    required this.isAchieved,
    required this.isExpired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WCard(
        key: ValueKey(task.id),
        padding: 10.0,
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: ListTile(
                leading: WProgressIndicator(
                  percentage: task.totalGoalCount.getProgress(task.record?.successDates.length ?? 0),
                  width: 40,
                  height: 40,
                  strokeWidth: 6,
                  fontSize: 14,
                  color: Color(int.parse(task.color)),
                ),
                title: Text(
                  task.title,
                  style: contentTextStyle.copyWith(color: Colors.black),
                ),
                subtitle: Text(
                  '${task.startDateTime.formattedDate} ~ | ${task.durationInWeeks}주 챌린지',
                  style: subTextStyle,
                ),
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: Container(
                      height: 23 * su,
                      width: 23 * su,
                      decoration: BoxDecoration(color: bgGreyColor, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_forward_ios_outlined, size: 12, color: Colors.white),
                      )),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onClickAchieveButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAchieved
                    ? primaryColor
                    : isExpired
                        ? subTextColor
                        : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: globalBorderRadius,
                ),
                minimumSize: Size(double.infinity, 40),
              ),
              child: Text(
                isAchieved
                    ? '챌린지 달성 완료!'
                    : isExpired
                        ? '만료된 챌린지'
                        : '챌린지 달성',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
