import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import '../../../model/challenge/challenge_model.dart';
import '../../../widgets/widget_progress_indicator.dart';

class ChallengeItem extends StatelessWidget {
  final ChallengeModel task;
  final int index;
  final bool isEditing;
  final VoidCallback? onTap;

  const ChallengeItem({
    Key? key,
    required this.task,
    required this.index,
    required this.isEditing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      key: ValueKey(task),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: WProgressIndicator(
            percentage: task.period.getProgress(task.progress),
          ),
          title: Text(task.title),
          subtitle: Text(
              '${task.startDate} ~ ${task.startDate.toDateTime.addDaysToDate(task.period).formattedDate}'
          ),
          trailing: ReorderableDragStartListener(
            index: index,
            child: isEditing
                ? Icon(Icons.drag_handle)
                : Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ),
    );
  }
}

