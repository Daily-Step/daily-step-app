import 'dart:math';

import 'package:dailystep/common/extension/datetime_extension.dart';
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
  late final List<ChallengeModel> _initialChallenges;
  late List<DateTime> _initialSuccessList = [];

  ChallengesState build() {
    _initialChallenges = _setChallengeList(DateTime.now());
    DateTime _today = DateTime.now();

    //오늘 부터 2달 전 까지 캘린더 데이터 생성
    for (int i = 1; i <= 60; i++) {
      DateTime targetDate = _today.subtract(Duration(days: i));
      List<ChallengeModel> challenges = _setChallengeList(targetDate);
      bool allChallengesSuccess = true;

      for (int j = 0; j < challenges.length; j++) {
        bool hasSuccessDate = challenges[j].record.successDates.any(
              (el) => el.isSameDate(targetDate),
            );
        if (!hasSuccessDate) {
          allChallengesSuccess = false;
          break;
        }
      }

      if (allChallengesSuccess && challenges.length != 0) {
        _initialSuccessList.add(targetDate);
      }
    }
    return ChallengesState(
      challengeList: _initialChallenges,
      successList: _initialSuccessList,
      selectedChallenge: null,
      firstDateOfWeek: _today.getStartOfWeek(),
      firstDateOfMonth: DateTime(_today.year, _today.month, 1),
      selectedDate: _today,
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
    if(!action.isCancel){
      _checkIsFirstAchieved(List.of(state.challengeList), action.context);
    }
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

  void _checkIsFirstAchieved(
      List<ChallengeModel> challenges, BuildContext context) {
    int successDate = 0 ;
    print(challenges[0].record.successDates);
    for (int j = 0; j < challenges.length; j++) {
      bool hasSuccessDate = challenges[j].record.successDates.any(
            (el) => el.isSameDate(state.selectedDate),
          );
      if(hasSuccessDate){
        successDate += 1;
      }
    }
    print(successDate);
    if (successDate == 0) {
      ToastMsg toastMsg = _setToastMsg(1);//하루 첫 달성
      WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
    } else {
      ToastMsg toastMsg = _setToastMsg(2);
      WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
    }
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
  //final List<CategoryModel> categories;
  const ChallengesState({
    required this.challengeList,
    required this.successList,
    this.selectedChallenge,
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
    //required this.categories,
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
      //categories: categories ?? this.categories,
    );
  }
}
