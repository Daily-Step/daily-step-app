import 'dart:convert';

import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/mypage/action/mypage_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../model/mypage_model.dart';
import '../model/push_setting_response.dart';

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

  Future<void> updatePushSetting(bool enabled) async {
    final response = await _apiClient.put(
      'member/push',
      data: jsonEncode({
        'enabled': enabled,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.data);
      // 응답을 PushSettingResponse로 파싱
      final result = PushSettingResponse.fromJson(responseBody);

      // status, code 등에 따라 추가 로직 수행
      if (result.status == 0) {
        print('푸시 설정 업데이트 성공! code: ${result.code}, message: ${result.message}');
      } else {
        // status가 0이 아닐 경우 에러로 처리할 수도 있음
        throw Exception('푸시 설정 실패: ${result.message}');
      }
    } else {
      throw Exception('푸시 설정 요청 실패: statusCode=${response.statusCode}, body=${response.data}');
    }
  }

  // Push 알림 토글
  void togglePushNotification() async {
    if (state != null) {
      final newValue = !state!.isPushNotificationEnabled;
      // 먼저 로컬 State를 업데이트
      state = state!.copyWith(isPushNotificationEnabled: newValue);

      try {
        // 위에서 만든 updatePushSetting 호출
        await updatePushSetting(newValue);
      } catch (e) {
        // 서버 업데이트 실패 시 처리 (롤백 등)
        state = state!.copyWith(isPushNotificationEnabled: !newValue);
        print('푸시 알림 설정 업데이트 실패: $e');
      }
    }
  }
}


// Provider 정의
final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, MyPageModel?>((ref) {
  final apiClient = ApiClient();
  final secureStorageService = ref.read(secureStorageServiceProvider);
  return MyPageViewModel(apiClient, secureStorageService);
});
