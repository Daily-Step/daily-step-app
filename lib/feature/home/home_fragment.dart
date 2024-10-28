import 'package:dailystep/feature/home/reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
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
        Expanded(
          child: isEditing
              ? CachedReorderableListView(
                  list: challengeState.tasks,
                  itemBuilder: (BuildContext context, item, index) {
                    return Dismissible(
                      key: ValueKey('task_${item.id}'),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        final removedTask = item;
                        await challengeNotifier
                            .removeTaskByTitle(removedTask.title);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${removedTask.title} 삭제됨'),
                          action: SnackBarAction(
                            label: '실행 취소',
                            onPressed: () {
                              challengeNotifier.undoRemoveTask(
                                  index, removedTask);
                            },
                          ),
                        ));
                      },
                      child: ChallengeItem(
                        task: item,
                        index: index,
                        isEditing: isEditing,
                        onTap: () {},
                      ),
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    challengeNotifier.reorderTasks(oldIndex, newIndex);
                  },
                )
              : ListView.builder(
                  itemCount: challengeState.tasks.length,
                  itemBuilder: (context, index) {
                    final task = challengeState.tasks[index];
                    return ChallengeItem(
                      task: task,
                      index: index,
                      isEditing: isEditing,
                      onTap: () {
                        context.push('/main/home/${task.id}');
                      },
                    );
                  }),
        ),
      ],
    );
  }
}
