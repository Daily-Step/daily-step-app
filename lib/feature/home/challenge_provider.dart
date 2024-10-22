import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'challenge_provider.g.dart';

@riverpod
class ChallengeNotifier extends _$ChallengeNotifier {
  ChallengesState build() {
    return ChallengesState(
      tasks: [
        {
          'title': '주 3회 이상 헬스장 가기',
          'period': '2024.09.29~2024.11.29',
          'progress': 98.0,
          'isCompleted': false,
        },
        {
          'title': '매일 일기쓰기',
          'period': '2024.09.29~2024.11.29',
          'progress': 50.0,
          'isCompleted': true,
        },
        {
          'title': '숫풀 컨텐츠 끝내기',
          'period': '2024.09.29~2024.11.29',
          'progress': 20.0,
          'isCompleted': false,
        },
      ],
      isEditing: false,
      isCompleted: false,
    );
  }
  List<Map<String, dynamic>> get filteredTasks {
    return state.tasks.where((task) =>
    task['isCompleted'] == state.isCompleted
    ).toList();
  }

  void toggleEditing() {
    state = state.copyWith(isEditing: !state.isEditing);
  }

  void toggleCompleted(bool value) {
    state = state.copyWith(isCompleted: value);
  }

  void reorderTasks(int oldIndex, int newIndex) {
    final tasks = [...state.tasks];
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);
    state = state.copyWith(tasks: tasks);
  }

  Future<Map<String,dynamic>> removeTask(int index) async {
    final tasks = [...state.tasks];
    final removedTask = tasks.removeAt(index);
    state = state.copyWith(tasks: tasks);
    return removedTask;
  }

  void undoRemoveTask(int index, Map<String, dynamic> task) {
    final tasks = [...state.tasks];
    tasks.insert(index, task);
    state = state.copyWith(tasks: tasks);
  }
}

// 상태 클래스
class ChallengesState {
  final List<Map<String, dynamic>> tasks;
  final bool isEditing;
  final bool isCompleted;

  ChallengesState({
    required this.tasks,
    required this.isEditing,
    required this.isCompleted,
  });

  ChallengesState copyWith({
    List<Map<String, dynamic>>? tasks,
    bool? isEditing,
    bool? isCompleted,
  }) {
    return ChallengesState(
      tasks: tasks ?? this.tasks,
      isEditing: isEditing ?? this.isEditing,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}