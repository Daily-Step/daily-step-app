import 'dart:math';

import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/string_extension.dart';
import 'package:dailystep/data/api/challenge_api.dart';
import 'package:dailystep/feature/home/view/settings/toast_msg.dart';
import 'package:dailystep/model/category/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../../../model/challenge/challenge_model.dart';
import '../../../widgets/widget_toast.dart';
import '../action/challenge_list_action.dart';

part 'challenge_viewmodel.g.dart';

@riverpod
class ChallengeViewModel extends _$ChallengeViewModel {
  ChallengeApi _challengeApi = ChallengeApi();
  final _secureStorageService = SecureStorageService();

  @override
  Future<ChallengesState> build() async {
    DateTime today = DateTime.now();

    final categoryResult = await _challengeApi.getCategories() as List;
    List<CategoryModel> categories = categoryResult.map((el) {
      return CategoryModel.fromJson(el as Map<String, dynamic>);
    }).toList();

    final initialChallenges = await _handleGetChallenge(today);
    final List<ChallengeModel> selectedChallenges =
        _setChallengeList(challenges: initialChallenges, selectedDate: today);
    final List<DateTime> initialSuccessList = _setSuccessList(initialChallenges);
    return ChallengesState(
      initialChallengeList: initialChallenges,
      challengeList: selectedChallenges,
      successList: initialSuccessList,
      selectedChallenge: null,
      firstDateOfWeek: today.getStartOfWeek(),
      firstDateOfMonth: DateTime(today.year, today.month, 1),
      selectedDate: today,
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
      _handleRemoveChallenge(action);
    } else if (action is FindChallengeAction) {
      _handleFindChallenge(action);
    } else if (action is ChangeSelectedDateAction) {
      _handleChangeSelectedDate(action);
    } else if (action is ChangeFirstDateOfWeekAction) {
      _handleChangeFirstDateOfWeekAction(action);
    }
  }
  Future<List<ChallengeModel>> _handleGetChallenge(DateTime date) async {
    List<dynamic> challengeResult = await _challengeApi.getChallenges(date.apiFormattedDate) as List;
    List<ChallengeModel> result = challengeResult.map((el) {
      return ChallengeModel.fromJson(el);
    }).toList();
    return result;
  }

  void _handleAddChallenge(AddChallengeAction action){
    state.whenData((currentState) async {
      await _challengeApi.addChallenge(action.data);
      final newChallengeList = await _handleGetChallenge(DateTime.now());
      state = AsyncValue.data(
        currentState.copyWith(challengeList: newChallengeList),
      );
    });
  }

  void _handleUpdateChallenge(UpdateChallengeAction action) {
    state.whenData((currentState) async {
      await _challengeApi.updateChallenge(action.id,action.data);
      final newChallengeList = await _handleGetChallenge(DateTime.now());
      state =
          AsyncValue.data(currentState.copyWith(challengeList: newChallengeList));
    });
  }

  void _handleAchieveChallenge(AchieveChallengeAction action) {
    state.whenData((currentState) async {
      if (!action.isCancel) {
        _checkIsFirstAchieved(
            List.of(currentState.challengeList), action.context);
        await _challengeApi.achieveChallenge(action.id, DateTime.now().apiFormattedDate);
      } else {
        await _challengeApi.deleteAchieveChallenge(action.id, DateTime.now().apiFormattedDate);
      }
      final newChallengeList = await _handleGetChallenge(DateTime.now());
      state =
          AsyncValue.data(currentState.copyWith(challengeList: newChallengeList));
    });
  }

  void _handleRemoveChallenge(DeleteChallengeAction action) {
    state.whenData((currentState) async {
      await _challengeApi.deleteChallenge(action.id);
      final newChallengeList = await _handleGetChallenge(DateTime.now());
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
      final challenges = List.of(currentState.initialChallengeList);
      List<ChallengeModel> newChallengeList = _setChallengeList(
          challenges: challenges, selectedDate: action.selectedDate);
      state = AsyncValue.data(currentState.copyWith(
          selectedDate: action.selectedDate, challengeList: newChallengeList));
    });
  }

  void _handleChangeFirstDateOfWeekAction(ChangeFirstDateOfWeekAction action) {
    state.whenData((currentState) {
      final challenges = List.of(currentState.initialChallengeList);
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
        bool hasSuccessDate = challengeList[j].record?.successDates.any(
              (el) => el.toDateTime.isSameDate(targetDate),
            ) ?? false;
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
      DateTime startDttm = challenge.startDateTime;
      DateTime endDttm = challenge.endDateTime;

      return (today.isAfter(startDttm) && today.isBefore(endDttm)) ||
          today.isSameDate(startDttm) ||
          today.isSameDate(endDttm);
    }).toList();
  }

  void _checkIsFirstAchieved(
      List<ChallengeModel> challenges, BuildContext context) {
    state.whenData((currentState) async {
      String? isFirstAchieved = await _secureStorageService.getIsFirstAchieve();

      //가입 후 첫 달성
      if(isFirstAchieved == '0'){
        ToastMsg toastMsg = _setToastMsg(0);
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
        await _secureStorageService.saveIsFirstAchieve('1');
        return;
      }

      int successDate = 0;
      for (int j = 0; j < challenges.length; j++) {
        bool hasSuccessDate = challenges[j].record?.successDates.any(
              (el) => el.toDateTime.isSameDate(currentState.selectedDate),
            )?? false;
        if (hasSuccessDate) {
          successDate += 1;
        }
      }
      if (successDate == 0) {
        //하루 첫 달성
        ToastMsg toastMsg = _setToastMsg(1);
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
      } else {
        //일반 달성
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
  final List<ChallengeModel> initialChallengeList;
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
    required this.initialChallengeList,
    required this.challengeList,
    required this.successList,
    this.selectedChallenge,
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
    required this.categories,
  });

  ChallengesState copyWith({
    List<ChallengeModel>? initialChallengeList,
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
      initialChallengeList: initialChallengeList != null
          ? List<ChallengeModel>.from(
          initialChallengeList.map((challenge) => challenge.copyWith()))
          : this.challengeList,
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
