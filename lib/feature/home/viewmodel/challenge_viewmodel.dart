import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/challenge/challenge_dummies.dart';
import '../../../model/challenge/challenge_model.dart';
import '../action/challenge_list_action.dart';

part 'challenge_viewmodel.g.dart';

@riverpod
class ChallengeViewModel extends _$ChallengeViewModel {
  late final List<ChallengeModel> _initialTasks;

  ChallengesState build() {
    _initialTasks = dummyChallenges
        .where((item) => item.isCompleted == false)
        .map((item) => item.copyWith())
        .toList();

    return ChallengesState(
      challengeList: _initialTasks,
      selectedTask: null,
    );
  }

  Future<void> handleAction(ChallengeListAction action) async {
    if (action is ReorderTasksAction) {
      _handleReorderTasks(action);
    } else if (action is RemoveTaskAction) {
      await _handleRemoveTask(action);
    } else if (action is FindTaskAction) {
      await _handleFindTask(action);
    }
  }

  void _handleReorderTasks(ReorderTasksAction action) {
    if (action.oldIndex == action.newIndex) return;

    final newTasks = List.of(state.challengeList);
    final item = newTasks.removeAt(action.oldIndex);
    newTasks.insert(action.newIndex, item);

    state = state.copyWith(tasks: newTasks);
  }

  Future<void> _handleRemoveTask(RemoveTaskAction action) async {
    final tasks = List.of(state.challengeList);
    final removedTask = tasks.firstWhere((task) => task.id == action.id);
    tasks.removeWhere((task) => task.id == action.id);

    state = state.copyWith(
      tasks: tasks,
      selectedTask: removedTask,
    );
  }

  Future<void> _handleFindTask(FindTaskAction action) async {
    final tasks = List.of(state.challengeList);
    final selectedTask = tasks.firstWhere((task) => task.id == action.id);

    state = state.copyWith(
      tasks: tasks,
      selectedTask: selectedTask,
    );
  }
}

class ChallengesState {
  final List<ChallengeModel> challengeList;
  final ChallengeModel? selectedTask;

  const ChallengesState({
    required this.challengeList,
    this.selectedTask,
  });

  ChallengesState copyWith({
    List<ChallengeModel>? tasks,
    ChallengeModel? selectedTask,
  }) {
    return ChallengesState(
      challengeList: tasks != null
          ? List<ChallengeModel>.from(tasks.map((task) => task.copyWith()))
          : this.challengeList,
      selectedTask: selectedTask ?? this.selectedTask,
    );
  }
}

