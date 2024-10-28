import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/challenge/challenge_dummies.dart';
import '../../model/challenge/challenge_model.dart';

part 'challenge_provider.g.dart';

@riverpod
class ChallengeNotifier extends _$ChallengeNotifier {
  late final List<Challenge> _initialTasks;

  ChallengesState build() {
    _initialTasks = dummyChallenges
        .where((item) => item.isCompleted == false)
        .map((item) => item.copyWith())
        .toList();

    return ChallengesState(
      tasks: _initialTasks,
    );
  }

  void reorderTasks(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;

    final newTasks = List.of(state.tasks);

    final item = newTasks.removeAt(oldIndex);
    newTasks.insert(newIndex, item);
    state = state.copyWith(tasks: newTasks);
  }

  Future<Challenge?> removeTaskByTitle(String title) async {
    final tasks = List.of(state.tasks);

    final removedTask = tasks.firstWhere((task) => task.title == title);
    tasks..removeWhere((task) => task.title == title);
    print(tasks);

    state = state.copyWith(tasks: tasks);
    print(state.tasks);
    return removedTask;
  }

  void undoRemoveTask(int index, Challenge task) {
    final tasks = [...state.tasks];
    tasks.insert(index, task);
    state = state.copyWith(tasks: tasks);
  }
}

// 상태 클래스
class ChallengesState {
  final List<Challenge> tasks;

  ChallengesState({
    required this.tasks,
  });

  ChallengesState copyWith({
    required List<Challenge> tasks,
  }) {
    return ChallengesState(
      tasks: List<Challenge>.from(tasks.map((task) => task.copyWith())),
    );
  }
}
