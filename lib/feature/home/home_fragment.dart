import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/challenge/challenge_model.dart';
import 'challenge_filter.dart';
import 'challenge_item.dart';
import 'challenge_provider.dart';

class Task {
  final String title;
  final String period;
  final double progress;
  bool isSelected;

  Task({
    required this.title,
    required this.period,
    required this.progress,
    this.isSelected = false,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'period': period,
        'progress': progress,
        'isSelected': isSelected,
      };
}

class HomeFragment extends ConsumerWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeState = ref.watch(challengeNotifierProvider);
    final challengeNotifier = ref.read(challengeNotifierProvider.notifier);
    List<Challenge> tasks = challengeNotifier.isCompleted? challengeNotifier.endTask :challengeNotifier.task;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '00님의 챌린지',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(challengeState.isEditing ? Icons.done : Icons.edit),
                onPressed: () => challengeNotifier.toggleEditing(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: ChallengeFilter(
            isSelected: challengeState.isCompleted,
            onChanged: challengeNotifier.toggleCompleted,
          ),
        ),
        Expanded(
          child: challengeState.isEditing
              ? ReorderableListView.builder(
                  itemCount: tasks.length,
                  onReorder: challengeNotifier.reorderTasks,
                  itemBuilder: (context, index) => Dismissible(
                    key: Key(challengeState.tasks[index].id.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      final removedTask = tasks[index];
                      await challengeNotifier.removeTaskByTitle(removedTask.title);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${removedTask.title} 삭제됨'),
                          action: SnackBarAction(
                            label: '실행 취소',
                            onPressed: () {
                              challengeNotifier.undoRemoveTask(
                                  index, removedTask);
                            },
                          ),
                        ),
                      );
                    },
                    child: ChallengeItem(
                      task: tasks[index],
                      index: index,
                      isEditing: challengeState.isEditing, onTap: () {  },
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ChallengeItem(
                      task: task,
                      index: index,
                      isEditing: challengeState.isEditing, onTap: () {
                      context.push('/main/home/${task.id}');
                    },
                    );
                  }),
        ),
      ],
    );
  }
}
