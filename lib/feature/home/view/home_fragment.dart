import 'package:dailystep/feature/home/view/reorderable_item.dart';
import 'package:dailystep/feature/home/view/reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../action/category_list_action.dart';
import '../action/challenge_list_action.dart';
import '../viewmodel/category_viewmodel.dart';
import 'challenge_item.dart';
import '../viewmodel/challenge_viewmodel.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(challengeViewModelProvider);
    final notifier = ref.read(challengeViewModelProvider.notifier);
    final categoryNotifier = ref.watch(categoryViewModelProvider.notifier);

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
                  list: state.challengeList,
                  itemBuilder: (BuildContext context, item, index) {
                    return ReorderableItem(
                      key: ValueKey('task_${item.id}'),
                      task: item,
                      index: index,
                      isEditing: isEditing,
                      onDismissed: (id) async {
                        await notifier.handleAction(RemoveTaskAction(id));
                      },
                      onTap: () {},
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    notifier
                        .handleAction(ReorderTasksAction(oldIndex, newIndex));
                  },
                )
              : ListView.builder(
                  itemCount: state.challengeList.length,
                  itemBuilder: (context, index) {
                    final task = state.challengeList[index];
                    return ChallengeItem(
                      task: task,
                      index: index,
                      isEditing: isEditing,
                      onTap: () async {
                        await notifier.handleAction(FindTaskAction(task.id));
                        categoryNotifier.handleAction(FindItemAction(task.categoryId));
                        context.push('/main/home/${task.id}');
                      },
                    );
                  }),
        ),
      ],
    );
  }
}
