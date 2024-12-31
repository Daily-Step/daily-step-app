import 'dart:math';

import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/data/api/challenge_api.dart';
import 'package:dailystep/feature/home/view/settings/toast_msg.dart';
import 'package:dailystep/model/category/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../model/challenge/challenge_dummies.dart';
import '../../../model/challenge/challenge_model.dart';
import '../../../widgets/widget_toast.dart';
import '../action/challenge_list_action.dart';

part 'challenge_viewmodel.g.dart';

@riverpod
class ChallengeViewModel extends _$ChallengeViewModel {
  ChallengeApi _challengeApi = ChallengeApi();

  @override
  Future<ChallengesState> build() async {
    DateTime _today = DateTime.now();
    final result = await _challengeApi.getCategories() as List;
      List<CategoryModel> categories = result.map((el) {
        return CategoryModel.fromJson(el as Map<String, dynamic>);
      }).toList();

    final List<ChallengeModel> _initialChallenges =
        _setChallengeList(challenges: dummyChallenges, selectedDate: _today);
    final List<DateTime> _initialSuccessList = _setSuccessList(dummyChallenges);
    return ChallengesState(
      challengeList: _initialChallenges,
      successList: _initialSuccessList,
      selectedChallenge: null,
      firstDateOfWeek: _today.getStartOfWeek(),
      firstDateOfMonth: DateTime(_today.year, _today.month, 1),
      selectedDate: _today,
      categories: categories,
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
    state.whenData((currentState) {
      final newChallengeList =
          List<ChallengeModel>.from(currentState.challengeList);
      newChallengeList.add(action.challengeModel);

      state = AsyncValue.data(
        currentState.copyWith(challengeList: newChallengeList),
      );
    });
  }

  void _handleUpdateChallenge(UpdateChallengeAction action) {
    state.whenData((currentState) {
      final updatedTasks = currentState.challengeList.map((task) {
        if (task.id == action.id) {
          return action.challengeModel;
        }
        return task;
      }).toList();
      state =
          AsyncValue.data(currentState.copyWith(challengeList: updatedTasks));
    });
  }

  void _handleAchieveChallenge(AchieveChallengeAction action) {
    state.whenData((currentState) {
      if (!action.isCancel) {
        _checkIsFirstAchieved(
            List.of(currentState.challengeList), action.context);
      }
      final updatedTasks = currentState.challengeList.map((task) {
        if (task.id == action.id) {
          return action.challengeModel;
        }
        return task;
      }).toList();
      state =
          AsyncValue.data(currentState.copyWith(challengeList: updatedTasks));
    });
  }

  Future<void> _handleRemoveTask(DeleteChallengeAction action) async {
    state.whenData((currentState) {
      final newChallengeList = List.of(currentState.challengeList);
      newChallengeList.removeWhere((task) => task.id == action.id);

      state = AsyncValue.data(currentState.copyWith(
        challengeList: newChallengeList,
      ));
    });
  }

  Future<void> _handleFindChallenge(FindChallengeAction action) async {
    state.whenData((currentState) {
      final challenges = List.of(currentState.challengeList);
      final selectedChallenge =
          challenges.firstWhere((challenge) => challenge.id == action.id);
      state = AsyncValue.data(currentState.copyWith(
        selectedChallenge: selectedChallenge,
      ));
    });
  }

  void _handleChangeSelectedDate(ChangeSelectedDateAction action) {
    state.whenData((currentState) {
      final challenges = List.of(currentState.challengeList);
      List<ChallengeModel> newChallengeList = _setChallengeList(
          challenges: challenges, selectedDate: action.selectedDate);
      state = AsyncValue.data(currentState.copyWith(
          selectedDate: action.selectedDate, challengeList: newChallengeList));
    });
  }

  void _handleChangeFirstDateOfWeekAction(ChangeFirstDateOfWeekAction action) {
    state.whenData((currentState) {
      final challenges = List.of(currentState.challengeList);
      DateTime newFirstDateOfWeek = DateTime.now()
          .getStartOfWeek()
          .add(Duration(days: action.addPage! * 7));
      int daysOff = currentState.selectedDate
          .difference(currentState.firstDateOfWeek)
          .inDays;
      DateTime newSelectedDate =
          newFirstDateOfWeek.add(Duration(days: daysOff));
      if (newSelectedDate.isAfter(DateTime.now())) {
        newSelectedDate = DateTime.now();
      }
      List<ChallengeModel> newChallengeList = _setChallengeList(
          challenges: challenges, selectedDate: newSelectedDate);
      state = AsyncValue.data(currentState.copyWith(
          firstDateOfWeek: newFirstDateOfWeek.getStartOfWeek(),
          selectedDate: newSelectedDate,
          challengeList: newChallengeList));
    });
  }

  List<DateTime> _setSuccessList(List<ChallengeModel> challenges) {
    final List<DateTime> successList = [];

    for (int i = 1; i <= 60; i++) {
      DateTime targetDate = DateTime.now().subtract(Duration(days: i));
      List<ChallengeModel> challengeList =
          _setChallengeList(challenges: challenges, selectedDate: targetDate);
      bool allChallengesSuccess = true;

      for (int j = 0; j < challengeList.length; j++) {
        bool hasSuccessDate = challengeList[j].record.successDates.any(
              (el) => el.isSameDate(targetDate),
            );
        if (!hasSuccessDate) {
          allChallengesSuccess = false;
          break;
        }
      }

      if (allChallengesSuccess && challengeList.length != 0) {
        successList.add(targetDate);
      }
    }
    return successList;
  }

  List<ChallengeModel> _setChallengeList(
      {required List<ChallengeModel> challenges,
      required DateTime selectedDate}) {
    return challenges.where((challenge) {
      DateTime today = selectedDate;
      DateTime startDttm = challenge.startDatetime;
      DateTime endDttm = challenge.endDatetime;

      return (today.isAfter(startDttm) && today.isBefore(endDttm)) ||
          today.isSameDate(startDttm) ||
          today.isSameDate(endDttm);
    }).toList();
  }

  void _checkIsFirstAchieved(
      List<ChallengeModel> challenges, BuildContext context) {
    state.whenData((currentState) {
      int successDate = 0;
      print(challenges[0].record.successDates);
      for (int j = 0; j < challenges.length; j++) {
        bool hasSuccessDate = challenges[j].record.successDates.any(
              (el) => el.isSameDate(currentState.selectedDate),
            );
        if (hasSuccessDate) {
          successDate += 1;
        }
      }
      if (successDate == 0) {
        ToastMsg toastMsg = _setToastMsg(1); //하루 첫 달성
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
      } else {
        ToastMsg toastMsg = _setToastMsg(2);
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
      }
    });
  }

  ToastMsg _setToastMsg(int type) {
    if (type == 1) {
      return toastMsg.firstWhere((el) => el.type == 1);
    } else {
      int randomNum = 3 + Random().nextInt((7 + 1) - 3);
      return toastMsg.firstWhere((el) => el.id == randomNum);
    }
  }
}

class ChallengesState {
  ///챌린지 변수
  final List<ChallengeModel> challengeList;
  final List<DateTime> successList;
  final ChallengeModel? selectedChallenge;

  ///캘린더 변수
  final DateTime firstDateOfWeek;
  final DateTime firstDateOfMonth;
  final DateTime selectedDate;

  ///카테고리 변수
  final List<CategoryModel> categories;

  const ChallengesState({
    required this.challengeList,
    required this.successList,
    this.selectedChallenge,
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
    required this.categories,
  });

  ChallengesState copyWith({
    List<ChallengeModel>? challengeList,
    List<DateTime>? successList,
    ChallengeModel? selectedChallenge,
    bool? firstAchieve,
    DateTime? firstDateOfWeek,
    DateTime? firstDateOfMonth,
    DateTime? selectedDate,
    List<CategoryModel>? categories,
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
      categories: categories ?? this.categories,
    );
  }
}
