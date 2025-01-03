import 'dart:convert';

import 'package:dailystep/data/api/api_client.dart';
import 'package:dailystep/feature/mypage/action/mypage_action.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../../../config/shared_preferences_storage/fcm_token_store.dart';
import '../model/mypage_model.dart';
import '../model/push_setting_response.dart';

class MyPageViewModel extends StateNotifier<MyPageModel?> with EventMixin<MyPageAction> {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;
  final FcmTokenStore _fcmTokenStore;


  // 생성자에서 ApiClient와 SecureStorageService 주입
  MyPageViewModel(this._apiClient, this._secureStorageService, this._fcmTokenStore) : super(null) {
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
  void loadDummyUserData() async {
    final isEnabled = await loadPushNotificationState();

    state = MyPageModel(
      nickname: "챌린저123",
      profileImageUrl: "",
      ongoingChallenges: 3,
      completedChallenges: 1,
      totalChallenges: 4,
      isPushNotificationEnabled: isEnabled,
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

  Future<void> savePushNotificationState(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushNotificationEnabled', isEnabled);
  }

  Future<bool> loadPushNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPushNotificationEnabled') ?? true; // 기본값 true
  }

  Future<void> togglePushNotification() async {
    final currentState = state;
    if (currentState == null) return; // Prevent null state access

    final newStatus = !currentState.isPushNotificationEnabled; // Toggle status

    try {
      if (newStatus) {
        await handleFcmToken(); // Enable FCM
      } else {
        await deleteFcmToken(); // Disable FCM
      }

      state = currentState.copyWith(isPushNotificationEnabled: newStatus);
    } catch (e) {
      print('Error toggling push notifications: $e');
    }
  }

  Future<void> handleFcmToken() async {
    try {
      // FCM 토큰 가져오기
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        // 토큰 저장
        await _fcmTokenStore.saveFcmToken(fcmToken);
        print('FCM 토큰 저장 완료: $fcmToken');

        // 서버로 토큰 전송
        await _apiClient.post('fcm', data: {'token': fcmToken});
        print('FCM 토큰 서버에 전송 완료');

        // 상태 업데이트
        state = state?.copyWith(isPushNotificationEnabled: true);
        print('FCM 토큰 가져오기 실패');
      }
    } catch (e) {
      print('FCM 토큰 처리 중 오류: $e');
    }
  }

  // FCM 토큰 삭제 처리
  Future<void> deleteFcmToken() async {
    try {
      // 저장된 FCM 토큰 가져오기
      final fcmToken = await _fcmTokenStore.getFcmToken();
      if (fcmToken != null) {
        // 서버에서 토큰 삭제
        await _apiClient.delete('fcm');
        print('FCM 토큰 서버에서 삭제 완료: $fcmToken');

        // 로컬 저장소에서 토큰 삭제
        await _fcmTokenStore.deleteFcmToken();
        print('로컬 저장소에서 FCM 토큰 삭제 완료');

        // 상태 업데이트
        state = state?.copyWith(isPushNotificationEnabled: false);
      }
    } catch (e) {
      print('FCM 토큰 삭제 중 오류: $e');
    }
  }

  // FCM 토큰 갱신 이벤트 처리
}

// Provider 정의
final fcmTokenStoreProvider = Provider((ref) => FcmTokenStore());
final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, MyPageModel?>((ref) {
  final apiClient = ApiClient();
  final secureStorageService = ref.read(secureStorageServiceProvider);
  final fcmTokenStore = ref.read(fcmTokenStoreProvider);
  return MyPageViewModel(apiClient, secureStorageService, fcmTokenStore);
});
