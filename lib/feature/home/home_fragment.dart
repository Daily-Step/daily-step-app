import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widget_progress_indicator.dart';

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
}

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  List<Map<String, dynamic>> tasks = [
    {
      'title': '주 3회 이상 헬스장 가기',
      'period': '2024.09.29~2024.11.29',
      'progress': 0.98,
      'isSelected': false,
    },
    {
      'title': '매일 일기쓰기',
      'period': '2024.09.29~2024.11.29',
      'progress': 0.50,
      'isSelected': false,
    },
    {
      'title': '숫풀 컨텐츠 끝내기',
      'period': '2024.09.29~2024.11.29',
      'progress': 0.20,
      'isSelected': false,
    },
  ];
  final List<bool> _showActions = List.generate(3, (_) => false);
  bool isEditing = false;

  void onShowActionsChanged(int index, bool value) {
    setState(() {
      for (int i = 0; i < _showActions.length; i++) {
        _showActions[i] = i == index ? value : false;
      }
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '00님의 챌린지',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              PopupMenuButton<String>(
                initialValue: "진행중",
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "진행중",
                    child: Text("진행중"),
                  ),
                  const PopupMenuItem(
                    value: "완료",
                    child: Text("완료"),
                  ),
                ],
                child: Row(
                  children: [
                    Text("진행중"),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isEditing ? Icons.done : Icons.edit),
                onPressed: () => setState(() => isEditing = !isEditing),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(const Duration(days: 1));
                  });
                },
              ),
              GestureDetector(
                onLongPress: () => _selectDate(context),
                child: Text(
                  '${selectedDate.month}월 ${selectedDate.day}일',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.add(const Duration(days: 1));
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
            child: isEditing
                ? ReorderableListView.builder(
                    itemCount: tasks.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = tasks.removeAt(oldIndex);
                        tasks.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) => ListTile(
                        key: Key('$index'),
                        leading: Checkbox(
                          value: tasks[index]['isSelected'],
                          onChanged: (value) {
                            setState(() {
                              tasks[index]['isSelected'] = value;
                            });
                          },
                        ),
                        title: Text(tasks[index]['title']),
                        subtitle: Text(tasks[index]['period']),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: Icon(Icons.drag_handle),
                        )))
                : ChallengeList(
                    showActions: _showActions,
                    onShowActionsChanged: onShowActionsChanged,
                  )),
        if(isEditing) WCtaButton('삭제', onPressed: (){}, )
      ],
    );
  }
}

class ChallengeList extends StatelessWidget {
  final List<bool> showActions;
  final void Function(int, bool) onShowActionsChanged;

  const ChallengeList({
    super.key,
    required this.showActions,
    required this.onShowActionsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => ChallengeListItem(
        index: index,
        showAction: showActions[index],
        onShowActionChanged: (value) => onShowActionsChanged(index, value),
      ),
    );
  }
}

class ChallengeListItem extends StatelessWidget {
  final int index;
  final bool showAction;
  final ValueChanged<bool> onShowActionChanged;

  const ChallengeListItem({
    super.key,
    required this.index,
    required this.showAction,
    required this.onShowActionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          onShowActionChanged(true);
        } else if (details.primaryDelta! > 0) {
          onShowActionChanged(false);
        }
      },
      child: Stack(
        children: [
          if (showAction) const ActionButtons(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              showAction ? -100.0 : 0.0,
              0,
              0,
            ),
            child: ListTile(
              leading: WProgressIndicator(
                percentage: (index + 1) * 25,
              ),
              title: Text('Task ${index + 1}'),
              subtitle: const Text('2024.09.29~2024.11.29'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}


