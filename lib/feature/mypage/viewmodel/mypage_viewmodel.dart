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
    loadUserData();
  }

  @override
  void handleEvent(MyPageAction action) {
    switch (action.runtimeType) {
      case FetchUserDataAction:
        loadUserData();
        break;
      case UpdateUserProfileAction:
        final updateAction = action as UpdateUserProfileAction;
        updateUserProfile(updateAction.newUserName, updateAction.birth, updateAction.gender);
        break;
      case TogglePushNotificationAction:
        togglePushNotification();
        break;
    }
  }

  // 유저 정보 가져오기
  Future<void> loadUserData() async {
    try {
      final accessToken = await _secureStorageService.getAccessToken();
      if (accessToken != null) {
        // API 호출하여 유저 데이터 가져오기
        final response = await _apiClient.get(
          'member',
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response != null) {
          state = MyPageModel.fromJson(response.data);;
        }
      }
    } catch (e) {
      print('Failed to load user data: $e');
    }
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
