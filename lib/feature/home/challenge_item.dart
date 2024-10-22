import 'package:flutter/material.dart';
import '../../widgets/widget_progress_indicator.dart';

class ChallengeItem extends StatelessWidget {
  const ChallengeItem({
    super.key,
    required this.task,
    required this.index,
    required this.isEditing,
  });

  final Map<String, dynamic> task;
  final int index;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      key: ValueKey(task),
      child: ListTile(
          leading: WProgressIndicator(
            percentage: task['progress'],
          ),
          title: Text(task['title']),
          subtitle: Text(task['period']),
          trailing: ReorderableDragStartListener(
            index: index,
            child: isEditing? Icon(Icons.drag_handle) : Icon(Icons.arrow_forward_ios_outlined),
          )
      ),
    );
  }
}