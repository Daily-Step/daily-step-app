import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  itemCount: challengeNotifier.filteredTasks.length,
                  onReorder: challengeNotifier.reorderTasks,
                  itemBuilder: (context, index) => Dismissible(
                    key: Key(challengeState.tasks[index]['title']),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      final removedTask = challengeNotifier.filteredTasks[index];
                      challengeNotifier.removeTask(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${removedTask['title']} 삭제됨'),
                          action: SnackBarAction(
                            label: '실행 취소',
                            onPressed: () {
                              final removedTaskTitle =
                              challengeNotifier.filteredTasks[index]['title'];
                              final removedTask = {
                                'title': removedTaskTitle,
                                'period': challengeNotifier.filteredTasks[index]['period'],
                                'progress': challengeNotifier.filteredTasks[index]
                                    ['progress'],
                                'isSelected': challengeNotifier.filteredTasks[index]
                                    ['isSelected'],
                              };
                              challengeNotifier.undoRemoveTask(
                                  index, removedTask);
                            },
                          ),
                        ),
                      );
                    },
                    child: ChallengeItem(
                      task: challengeNotifier.filteredTasks[index],
                      index: index,
                      isEditing: challengeState.isEditing,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: challengeNotifier.filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = challengeNotifier.filteredTasks[index];
                    return ChallengeItem(
                      task: task,
                      index: index,
                      isEditing: challengeState.isEditing,
                    );
                  }),
        ),
      ],
    );
  }
}
