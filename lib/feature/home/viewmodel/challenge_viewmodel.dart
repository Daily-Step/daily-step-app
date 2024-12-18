import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../model/challenge/challenge_dummies.dart';
import '../../../model/challenge/challenge_model.dart';
import '../action/challenge_list_action.dart';

part 'challenge_viewmodel.g.dart';

@riverpod
class ChallengeViewModel extends _$ChallengeViewModel {
  late final List<ChallengeModel> _initialTasks;
  late List<DateTime> _initialSuccessList = [];

  ChallengesState build() {
    _initialTasks = _setChallengeList(DateTime.now());

    DateTime today = DateTime.now();

    //오늘 부터 2주 전 까지 캘린더 데이터 생성
    for (int i = 1; i <= 60; i++) {
      DateTime targetDate = today.subtract(Duration(days: i));
      bool allChallengesSuccess = true;

      for (int j = 0; j < _initialTasks.length; j++) {
        bool hasSuccessDate = _initialTasks[j].record.successDates.any(
              (el) => el.isSameDate(targetDate),
        );

        if (!hasSuccessDate) {
          allChallengesSuccess = false;
          break;
        }
      }

      if (allChallengesSuccess) {
        _initialSuccessList.add(targetDate);
      }
    }
    return ChallengesState(
      challengeList: _initialTasks,
      successList: _initialSuccessList,
      selectedChallenge: null,
      firstDateOfWeek: DateTime.now().getStartOfWeek(),
      firstDateOfMonth: DateTime(DateTime.now().year, DateTime.now().month, 1),
      selectedDate: DateTime.now(),
    );
  }

  Future<void> handleAction(ChallengeListAction action) async {
    if (action is AddChallengeAction) {
      _handleAddChallenge(action);
    } else if (action is UpdateChallengeAction) {
      _handleUpdateChallenge(action);
    } else if (action is AchieveChallengeAction) {
      _handleAchieveChallenge(action);
    } else if (action is DeleteChallengeAction) {
      await _handleRemoveTask(action);
    } else if (action is FindChallengeAction) {
      _handleFindChallenge(action);
    } else if (action is ChangeSelectedDateAction) {
      _handleChangeSelectedDate(action);
    } else if (action is ChangeFirstDateOfWeekAction) {
      _handleChangeFirstDateOfWeekAction(action);
    }
  }

  void _handleAddChallenge(AddChallengeAction action) {
    final newChallengeList = List<ChallengeModel>.from(state.challengeList);
    newChallengeList.add(action.challengeModel);

    state = state.copyWith(challengeList: newChallengeList);
  }

  void _handleUpdateChallenge(UpdateChallengeAction action) {
    final updatedTasks = state.challengeList.map((task) {
      if (task.id == action.id) {
        return action.challengeModel;
      }
      return task;
    }).toList();

    state = state.copyWith(challengeList: updatedTasks);
  }

  void _handleAchieveChallenge(AchieveChallengeAction action) {
    final updatedTasks = state.challengeList.map((task) {
      if (task.id == action.id) {
        return action.challengeModel;
      }
      return task;
    }).toList();

    state = state.copyWith(challengeList: updatedTasks);
  }

  Future<void> _handleRemoveTask(DeleteChallengeAction action) async {
    final newChallengeList = List.of(state.challengeList);
    newChallengeList.removeWhere((task) => task.id == action.id);

    state = state.copyWith(
      challengeList: newChallengeList,
    );
  }

  Future<void> _handleFindChallenge(FindChallengeAction action) async {
    final challenges = List.of(state.challengeList);
    final selectedChallenge =
        challenges.firstWhere((challenge) => challenge.id == action.id);
    state = state.copyWith(
      selectedChallenge: selectedChallenge,
    );
  }

  void _handleChangeSelectedDate(ChangeSelectedDateAction action) {
    List<ChallengeModel> newChallengeList =
        _setChallengeList(action.selectedDate);
    state = state.copyWith(
        selectedDate: action.selectedDate, challengeList: newChallengeList);
  }

  void _handleChangeFirstDateOfWeekAction(ChangeFirstDateOfWeekAction action) {
    DateTime newFirstDateOfWeek = DateTime.now()
        .getStartOfWeek()
        .add(Duration(days: action.addPage! * 7));
    int daysOff = state.selectedDate.difference(state.firstDateOfWeek).inDays;
    DateTime newSelectedDate = newFirstDateOfWeek.add(Duration(days: daysOff));
    if (newSelectedDate.isAfter(DateTime.now())) {
      newSelectedDate = DateTime.now();
    }
    List<ChallengeModel> newChallengeList = _setChallengeList(newSelectedDate);
    state = state.copyWith(
        firstDateOfWeek: newFirstDateOfWeek.getStartOfWeek(),
        selectedDate: newSelectedDate,
        challengeList: newChallengeList);
  }

  List<ChallengeModel> _setChallengeList(DateTime selectedDate) {
    return dummyChallenges.where((challenge) {
      DateTime today = selectedDate;
      DateTime startDttm = challenge.startDatetime;
      DateTime endDttm = challenge.endDatetime;

      return (today.isAfter(startDttm) && today.isBefore(endDttm)) ||
          today.isSameDate(startDttm) ||
          today.isSameDate(endDttm);
    }).toList();
  }

  bool _checkIsFirstAchieved() {
    final challenges = List.of(state.challengeList);
    for (int j = 0; j < challenges.length; j++) {
      bool hasSuccessDate = challenges[j].record.successDates.any(
            (el) => el.isSameDate(state.selectedDate),
          );
      if (hasSuccessDate) {
        return false;
      }
    }
    return true;
  }
}

class ChallengesState {
  final List<ChallengeModel> challengeList;
  final List<DateTime> successList;
  final ChallengeModel? selectedChallenge;

  final DateTime firstDateOfWeek;
  final DateTime firstDateOfMonth;
  final DateTime selectedDate;

  const ChallengesState({
    required this.challengeList,
    required this.successList,
    this.selectedChallenge,
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
  });

  ChallengesState copyWith({
    List<ChallengeModel>? challengeList,
    List<DateTime>? successList,
    ChallengeModel? selectedChallenge,
    bool? firstAchieve,
    DateTime? firstDateOfWeek,
    DateTime? firstDateOfMonth,
    DateTime? selectedDate,
  }) {
    return ChallengesState(
      challengeList: challengeList != null
          ? List<ChallengeModel>.from(
              challengeList.map((challenge) => challenge.copyWith()))
          : this.challengeList,
      successList: successList ?? this.successList,
      selectedChallenge: selectedChallenge ?? this.selectedChallenge,
      firstDateOfWeek: firstDateOfWeek ?? this.firstDateOfWeek,
      firstDateOfMonth: firstDateOfMonth ?? this.firstDateOfMonth,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
