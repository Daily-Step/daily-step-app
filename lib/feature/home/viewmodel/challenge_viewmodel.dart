import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../model/challenge/challenge_dummies.dart';
import '../../../model/challenge/challenge_model.dart';
import '../action/challenge_list_action.dart';

part 'challenge_viewmodel.g.dart';

@riverpod
class ChallengeViewModel extends _$ChallengeViewModel {
  late final List<ChallengeModel> _initialTasks;

  ChallengesState build() {
    _initialTasks = dummyChallenges.where((challenge) {
      DateTime today = DateTime.now();
      DateTime startDttm = challenge.startDatetime;
      DateTime endDttm = challenge.endDatetime;

      return today.isAfter(startDttm) && today.isBefore(endDttm) ||
          today.isAtSameMomentAs(startDttm) ||
          today.isAtSameMomentAs(endDttm);
    }).toList();

    return ChallengesState(
      challengeList: _initialTasks,
      selectedTask: null,
    );
  }

  Future<void> handleAction(ChallengeListAction action) async {
    if (action is ReorderTasksAction) {
      _handleReorderTasks(action);
    } else if (action is AddTaskAction) {
      _handleAddTask(action);
    } else if (action is UpdateTaskAction) {
      _handleUpdateTask(action);
    } else if (action is DeleteTaskAction) {
      await _handleRemoveTask(action);
    } else if (action is FindTaskAction) {
      _handleFindTask(action);
    }
  }

  void _handleReorderTasks(ReorderTasksAction action) {
    if (action.oldIndex == action.newIndex) return;

    final newTasks = List.of(state.challengeList);
    final item = newTasks.removeAt(action.oldIndex);
    newTasks.insert(action.newIndex, item);

    state = state.copyWith(tasks: newTasks);
  }

  void _handleAddTask(AddTaskAction action) {
    final newTasks = List<ChallengeModel>.from(state.challengeList);
    newTasks.add(action.challengeModel);

    state = state.copyWith(tasks: newTasks);
  }

  void _handleUpdateTask(UpdateTaskAction action) {
    final updatedTasks = state.challengeList.map((task) {
      if (task.id == action.id) {
        return action.challengeModel;
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedTasks);
  }

  Future<void> _handleRemoveTask(DeleteTaskAction action) async {
    final tasks = List.of(state.challengeList);
    tasks.removeWhere((task) => task.id == action.id);

    state = state.copyWith(
      tasks: tasks,
    );
  }

  Future<void> _handleFindTask(FindTaskAction action) async {
    final tasks = List.of(state.challengeList);
    final selectedTask = tasks.firstWhere((task) => task.id == action.id);
    state = state.copyWith(
      selectedTask: selectedTask,
    );
  }

  Future<void> _handleCheckFirstAchieve(FindTaskAction action) async {
    final tasks = List.of(state.challengeList);
    final selectedTask = tasks.firstWhere((task) => task.id == action.id);
    state = state.copyWith(
      selectedTask: selectedTask,
    );
  }
}

class ChallengesState {
  final List<ChallengeModel> challengeList;
  final ChallengeModel? selectedTask;
  final bool? firstAchieve;

  const ChallengesState({
    required this.challengeList,
    this.selectedTask,
    this.firstAchieve,
  });

  ChallengesState copyWith({
    List<ChallengeModel>? tasks,
    ChallengeModel? selectedTask,
    bool? firstAchieve,
  }) {
    return ChallengesState(
      challengeList: tasks != null
          ? List<ChallengeModel>.from(tasks.map((task) => task.copyWith()))
          : this.challengeList,
      selectedTask: selectedTask ?? this.selectedTask,
      firstAchieve: firstAchieve ?? this.firstAchieve,
    );
  }
}
