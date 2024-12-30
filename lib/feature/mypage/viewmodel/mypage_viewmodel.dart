import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/mypage/action/mypage_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../model/mypage_model.dart';

class MyPageViewModel extends StateNotifier<MyPageModel?> with EventMixin<MyPageAction> {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;

  // 생성자에서 ApiClient와 SecureStorageService 주입
  MyPageViewModel(this._apiClient, this._secureStorageService) : super(null) {
    loadDummyUserData(); // 초기화 시 실제 유저 데이터 로드
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

  // 실제 유저 데이터 가져오기 (API 호출)
  // TODO : 실제 유저로 바꾸기 api가 만들어 지면
  void loadDummyUserData() {
    state = MyPageModel(
      nickname: "챌린저123",
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
        nickname: newUserName,
        birth: birth,
        gender: gender,
      );
    }
  }

  // Push 알림 토글
  void togglePushNotification() {
    if (state != null) {
      state = state!.copyWith(
        isPushNotificationEnabled: !state!.isPushNotificationEnabled,
      );
    }
  }
}


// Provider 정의
final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, MyPageModel?>((ref) {
  final apiClient = ApiClient();
  final secureStorageService = ref.read(secureStorageServiceProvider);
  return MyPageViewModel(apiClient, secureStorageService);
});
