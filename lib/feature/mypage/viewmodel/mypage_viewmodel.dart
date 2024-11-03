import 'package:dailystep/feature/mypage/action/mypage_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';

class MyPageViewModel extends StateNotifier<UserModel?> with EventMixin<MyPageAction> {
  MyPageViewModel() : super(null) {
    loadDummyUserData(); 
  }

  @override
  void handleEvent(MyPageAction action) {
    if (action is FetchUserDataAction) {
      loadDummyUserData();
    } else if (action is UpdateUserProfileAction) {
      updateUserProfile(action.newUserName, action.birth, action.gender);
    } else if (action is TogglePushNotificationAction) {
      togglePushNotification();
    }
  }

  // 유저 정보 가져오기
  // TODO : 실제 유저로 바꾸기 api가 만들어 지면
  void loadDummyUserData() {
    state = UserModel(
      userName: "챌린저123",
      profileImageUrl: "",
      ongoingChallenges: 3,
      completedChallenges: 1,
      totalChallenges: 4,
      isPushNotificationEnabled: true,
      birth: DateTime(1999, 1, 1),
      gender: "남성",
    );
  }

  // 프로필 업데이트
  void updateUserProfile(String newUserName, DateTime birth, String gender) {
    if (state != null) {
      state = state!.copyWith(
        userName: newUserName,
        birth: birth,
        gender: gender,
      );
    }
  }

  // Push 알림 토글
  void togglePushNotification() {
    if (state != null) {
      state = state!.copyWith(isPushNotificationEnabled: !state!.isPushNotificationEnabled);
    }
  }
}

// Provider 정의
final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, UserModel?>((ref) {
  return MyPageViewModel();
});