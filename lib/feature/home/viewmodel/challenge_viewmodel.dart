import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/string_extension.dart';
import 'package:dailystep/data/api/challenge_api.dart';
import 'package:dailystep/feature/home/view/settings/toast_msg.dart';
import 'package:dailystep/model/category/category_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/util/size_util.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../../../model/challenge/challenge_model.dart';
import '../../../widgets/widget_confirm_modal.dart';
import '../../../widgets/widget_constant.dart';
import '../../../widgets/widget_toast.dart';
import '../action/challenge_list_action.dart';

part 'challenge_viewmodel.g.dart';

@riverpod
class ChallengeViewModel extends _$ChallengeViewModel {
  ChallengeApi _challengeApi = ChallengeApi();
  final _secureStorageService = SecureStorageService();

  String? profileImageUrl;

  @override
  Future<ChallengesState> build() async {
    DateTime today = DateTime.now();
    final categories = await _fetchCategories();
    final initialChallenges = await _fetchChallenges(today);
    final List<ChallengeModel> selectedChallenges =
        _filterChallenges(initialChallenges, today);
    final List<DateTime> initialSuccessList =
        _setSuccessList(initialChallenges);
    final onGoingChallengeCount = _ongoingChallengeCount(initialChallenges);

    profileImageUrl = await _fetchProfileImage();

    return ChallengesState(
      initialChallengeList: initialChallenges,
      challengeList: selectedChallenges,
      successList: initialSuccessList,
      selectedChallenge: null,
      firstDateOfWeek: today.getStartOfWeek(),
      firstDateOfMonth: DateTime(today.year, today.month, 1),
      selectedDate: today,
      categories: categories,
      onGoingChallengeCount: onGoingChallengeCount,
      profileImageUrl: profileImageUrl,
    );
  }

  Future<String?> _fetchProfileImage() async {
    return await _challengeApi.fetchProfileImage();
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

  Future<List<CategoryModel>> _fetchCategories() async {
    final categoryResult = await _challengeApi.getCategories() as List;
    return categoryResult.map((el) => CategoryModel.fromJson(el)).toList();
  }

  Future<List<ChallengeModel>> _fetchChallenges(DateTime date) async {
    final challengeResult =
        await _challengeApi.getChallenges(date.apiFormattedDate) as List;
    return challengeResult.map((el) => ChallengeModel.fromJson(el)).toList();
  }

  List<ChallengeModel> _filterChallenges(
      List<ChallengeModel> challenges, DateTime selectedDate) {
    return challenges.where((challenge) {
      final startDttm = challenge.startDateTime;
      final endDttm = challenge.endDateTime;
      return (selectedDate.isAfter(startDttm) &&
              selectedDate.isBefore(endDttm)) ||
          selectedDate.isSameDate(startDttm) ||
          selectedDate.isSameDate(endDttm);
    }).toList();
  }

  void _handleAddChallenge(AddChallengeAction action) {
    state.whenData((currentState) async {
      try {
        await _challengeApi.addChallenge(action.data);
        await _refreshState();
        showConfirmModal(
            context: action.context,
            content: Column(
              children: [
                Text(
                  '챌린지 등록이 완료되었습니다',
                  style: boldTextStyle,
                ),
                height5,
                Text(
                  '닫기버튼을 누르면 홈으로 이동합니다',
                  style: subTextStyle,
                )
              ],
            ),
            confirmText: '닫기',
            onClickConfirm: () {
              Navigator.pop(action.context);
              ToastMsg toastMsg = ToastMsg.create(3);
              WToast.show(action.context, toastMsg.title,
                  subMessage: toastMsg.content);
            },
            isCancelButton: false);
      } catch (e) {
        debugPrint('$e');
      }
    });
  }

  void _handleUpdateChallenge(UpdateChallengeAction action) {
    state.whenData((currentState) async {
      await _challengeApi.updateChallenge(action.id, action.data);
      await _refreshState();
    });
  }

  void _handleAchieveChallenge(AchieveChallengeAction action) {
    state.whenData((currentState) async {
      try {
        if (!action.isCancel) {
          await _challengeApi.achieveChallenge(
              action.id, currentState.selectedDate.apiFormattedDate);
          _checkIsFirstAchieved(
              List.of(currentState.challengeList), action.context);
        } else {
          await _challengeApi.deleteAchieveChallenge(
              action.id, currentState.selectedDate.apiFormattedDate);
        }
        await _refreshState();
      } catch (e) {
        debugPrint('$e');
      }
    });
  }

  void _handleRemoveChallenge(DeleteChallengeAction action) {
    state.whenData((currentState) async {
      try{
        await _challengeApi.deleteChallenge(action.id);
        await _refreshState();
        Navigator.pop(action.context);
        showConfirmModal(
            context: action.context,
            content: Column(
              children: [
                Text(
                  '챌린지가 삭제되었습니다',
                  style: boldTextStyle,
                ),
                height5,
                Text(
                  '다른 챌린지를 만들어보세요!',
                  style: subTextStyle,
                )
              ],
            ),
            confirmText: '닫기',
            onClickConfirm: () {
              Navigator.pop(action.context);
            },
            isCancelButton: false);
      } catch(e) {
        debugPrint('$e');
      }
    });
  }

  Future<void> _refreshState() async {
    state.whenData((currentState) async {
      final newInitialChallenges = await _fetchChallenges(DateTime.now());
      final newFilteredChallenges =
          _filterChallenges(newInitialChallenges, currentState.selectedDate);
      final newSuccessList = _setSuccessList(newInitialChallenges);
      final onGoingChallengeCount =
          _ongoingChallengeCount(newInitialChallenges);

      state = AsyncValue.data(currentState.copyWith(
        initialChallengeList: newInitialChallenges,
        challengeList: newFilteredChallenges,
        successList: newSuccessList,
        onGoingChallengeCount: onGoingChallengeCount,
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
      List<ChallengeModel> newChallengeList =
          _filterChallenges(challenges, action.selectedDate);
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
      List<ChallengeModel> newChallengeList =
          _filterChallenges(challenges, newSelectedDate);
      state = AsyncValue.data(currentState.copyWith(
          firstDateOfWeek: newFirstDateOfWeek.getStartOfWeek(),
          selectedDate: newSelectedDate,
          challengeList: newChallengeList));
    });
  }

  List<DateTime> _setSuccessList(List<ChallengeModel> challenges) {
    final List<DateTime> successList = [];

    for (int i = 0; i <= 60; i++) {
      DateTime targetDate = DateTime.now().subtract(Duration(days: i));
      List<ChallengeModel> challengeList =
          _filterChallenges(challenges, targetDate);
      bool allChallengesSuccess = true;

      for (int j = 0; j < challengeList.length; j++) {
        bool hasSuccessDate = challengeList[j].record?.successDates.any(
                  (el) => el.toDateTime.isSameDate(targetDate),
                ) ??
            false;
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

  void _checkIsFirstAchieved(
      List<ChallengeModel> challenges, BuildContext context) {
    state.whenData((currentState) async {
      String? isFirstAchieved = await _secureStorageService.getIsFirstAchieve();

      //가입 후 첫 달성
      if (isFirstAchieved == '0') {
        ToastMsg toastMsg = ToastMsg.create(0);
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
        await _secureStorageService.saveIsFirstAchieve('1');
        return;
      }

      int successDate = 0;
      for (int j = 0; j < challenges.length; j++) {
        bool hasSuccessDate = challenges[j].record?.successDates.any(
                  (el) => el.toDateTime.isSameDate(currentState.selectedDate),
                ) ??
            false;
        if (hasSuccessDate) {
          successDate += 1;
        }
      }
      if (successDate == 0) {
        //하루 첫 달성
        ToastMsg toastMsg = ToastMsg.create(1);
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
      } else {
        //일반 달성
        ToastMsg toastMsg = ToastMsg.create(2);
        WToast.show(context, toastMsg.title, subMessage: toastMsg.content);
      }
    });
  }

  int _ongoingChallengeCount(List<ChallengeModel> challenges) {
    int result = 0;
    for (int i = 0; i < challenges.length; i++) {
      if (challenges[i].status == 'ONGOING') {
        result += 1;
      }
    }
    return result;
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

  ///챌린지 달성 개수
  final int onGoingChallengeCount;

  final String? profileImageUrl;

  const ChallengesState({
    required this.initialChallengeList,
    required this.challengeList,
    required this.successList,
    this.selectedChallenge,
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
    required this.categories,
    required this.onGoingChallengeCount,
    this.profileImageUrl,
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
    int? onGoingChallengeCount,
    String? profileImageUrl,
  }) {
    return ChallengesState(
      initialChallengeList: initialChallengeList != null
          ? List<ChallengeModel>.from(
              initialChallengeList.map((challenge) => challenge.copyWith()))
          : this.initialChallengeList,
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
      onGoingChallengeCount:
          onGoingChallengeCount ?? this.onGoingChallengeCount,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
