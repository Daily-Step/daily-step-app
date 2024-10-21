import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'challenge_filter.dart';
import 'challenge_list_item.dart';

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

  Map<String, dynamic> toMap() =>
      {
        'title': title,
        'period': period,
        'progress': progress,
        'isSelected': isSelected,
      };
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
  bool _isCompleted = false;

  void onShowActionsChanged(int index, bool value) {
    setState(() {
      for (int i = 0; i < _showActions.length; i++) {
        _showActions[i] = i == index ? value : false;
      }
    });
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
              IconButton(
                icon: Icon(isEditing ? Icons.done : Icons.edit),
                onPressed: () => setState(() => isEditing = !isEditing),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: ChallengeFilter(isSelected:_isCompleted, onChanged: (value) {
            setState(() {
              _isCompleted = value;
            });
          }),
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
              itemBuilder: (context, index) =>
                  ListTile(
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
                      )
                  )
          )
              : ChallengeList(
            showActions: _showActions,
            onShowActionsChanged: onShowActionsChanged,
          ),
        ),
        if(isEditing) WCtaButton('삭제', onPressed: () {},)
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
      itemBuilder: (context, index) =>
          ChallengeListItem(
            index: index,
            showAction: showActions[index],
            onShowActionChanged: (value) => onShowActionsChanged(index, value),
          ),
    );
  }
}

class CustomSegmentControl extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onChanged;

  const CustomSegmentControl({
    super.key,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    '진행완료',
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight
                          .normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    '진행중',
                    style: TextStyle(
                      fontWeight: !isSelected ? FontWeight.bold : FontWeight
                          .normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



