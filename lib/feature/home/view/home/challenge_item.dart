import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:flutter/material.dart';
import '../../../../model/challenge/challenge_model.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_progress_indicator.dart';
import '../settings/custom_color_dummies.dart';

class ChallengeItem extends StatelessWidget {
  final ChallengeModel task;
  final int index;
  final bool isAchieved;
  final VoidCallback? onTap;
  final VoidCallback? onClickAchieveButton;

  const ChallengeItem({
    Key? key,
    required this.task,
    required this.index,
    required this.onTap,
    required this.onClickAchieveButton,
    required this.isAchieved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      key: ValueKey(task),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: ListTile(
              leading: WProgressIndicator(
                percentage: task.totalGoalCount
                    .getProgress(task.successList.length),
                width: 40,
                height: 40,
                strokeWidth: 6,
                fontSize: 14,
                color: customColors[task.colorId].color,
              ),
              title: Text(task.title),
              subtitle: Text(
                  '${task.startDatetime.formattedDate} ~ ${task.endDatetime.formattedDate}'),
              trailing: ReorderableDragStartListener(
                index: index,
                child: Container(
                        decoration: BoxDecoration(
                            color: disabledColor, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              size: 12, color: Colors.white),
                        )),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: onClickAchieveButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAchieved? primaryColor : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: globalBorderRadius,
                ),
                minimumSize: Size(double.infinity, 40),
              ),
              child: Text(
                isAchieved? '챌린지 달성 완료!':'챌린지 달성',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}