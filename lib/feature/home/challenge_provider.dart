import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/challenge/challenge_dummies.dart';
import '../../model/challenge/challenge_model.dart';

part 'challenge_provider.g.dart';

@riverpod
class ChallengeNotifier extends _$ChallengeNotifier {
  ChallengesState build() {
    return ChallengesState(
      tasks: dummyChallenges.where((item)=> item.isCompleted == false).toList(),
      endTasks: dummyChallenges.where((item)=> item.isCompleted == true).toList(),
      isEditing: false,
      isCompleted: false,
    );
  }

  bool get isCompleted => state.isCompleted;
  List<Challenge> get task => state.tasks;
  List<Challenge> get endTask => state.endTasks;

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

  Future<Challenge?> removeTaskByTitle(String title) async {
    final tasks = [...state.tasks];

    final removedTask = tasks.firstWhere((task) => task.title == title);
    tasks.remove(removedTask);
    state = state.copyWith(tasks: tasks);
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
  final List<Challenge> endTasks;
  final bool isEditing;
  final bool isCompleted;

  ChallengesState({
    required this.tasks,
    required this.endTasks,
    required this.isEditing,
    required this.isCompleted,
  });

  ChallengesState copyWith({
    List<Challenge>? tasks,
    bool? isEditing,
    bool? isCompleted,
  }) {
    return ChallengesState(
      tasks: this.tasks,
      endTasks: this.endTasks,
      isEditing: isEditing ?? this.isEditing,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
