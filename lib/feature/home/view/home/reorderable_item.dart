import 'package:dailystep/model/challenge/challenge_model.dart';
import 'package:flutter/material.dart';

import 'challenge_item.dart';

class ReorderableItem extends StatelessWidget {
  final ChallengeModel task;
  final int index;
  final bool isEditing;
  final Future<void> Function(int id) onDismissed;
  final VoidCallback? onTap;

  const ReorderableItem({
    super.key,
    required this.task,
    required this.index,
    required this.isEditing,
    required this.onDismissed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('task_${task.id}'),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await onDismissed(task.id);
      },
      child: ChallengeItem(
        task: task,
        index: index,
        isEditing: isEditing,
        onTap: onTap,
      ),
    );
  }
}
