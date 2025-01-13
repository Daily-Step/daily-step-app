import 'package:dailystep/widgets/widget_confirm_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../common/util/size_util.dart';
import '../../../config/secure_storage/secure_storage_provider.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../../../config/shared_preferences_storage/fcm_token_store.dart';
import '../../../data/api/api_client.dart';
import '../model/mypage_model.dart';
import '../action/mypage_action.dart';

class MyPageViewModel extends StateNotifier<MyPageModel?> with EventMixin<MyPageAction> {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;
  final FcmTokenStore _fcmTokenStore;

  MyPageViewModel(
      this._apiClient,
      this._secureStorageService,
      this._fcmTokenStore,
      ) : super(null) {
    _initialize();
  }

  Future<void> _initialize() async {
    _loadDummyUserData();
    await _initializePushNotification();
    _initializeFCMListeners();
  }

  @override
  void handleEvent(MyPageAction action, ) {
    if (action is FetchUserDataAction) {
      _loadDummyUserData();
    } else if (action is UpdateUserProfileAction) {
      _updateUserProfile(action.newUserName, action.birth, action.gender);
    }
  }

  // 사용자 데이터 초기화
  void _loadDummyUserData() async {
    final isEnabled = await _loadPushNotificationState();
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
  void _updateUserProfile(String newUserName, DateTime birth, String gender) {
    if (state != null) {
      state = state!.copyWith(
        nickname: newUserName,
        birth: birth,
        gender: gender,
      );
    }
  }

  // 푸시 알림 초기화
  Future<void> _initializePushNotification() async {
    final permissionStatus = await FirebaseMessaging.instance.requestPermission();
    final isAuthorized = permissionStatus.authorizationStatus == AuthorizationStatus.authorized;

    await _savePushNotificationState(isAuthorized);

    if (isAuthorized) {
      await _handleFcmToken();
    } else {
      await _deleteFcmToken();
    }

    state = state?.copyWith(isPushNotificationEnabled: isAuthorized);
  }

  // FCM 리스너 초기화
  void _initializeFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('푸시 알림 수신: ${message.notification?.title}, ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('알림 클릭으로 앱 열림: ${message.notification?.title}');
    });
  }

  // 푸시 알림 활성화/비활성화
  Future<void> togglePushNotification(BuildContext context, {required bool value}) async {
    final currentState = state;
    if (currentState == null) return;

    final newStatus = value;

    try {
      if (newStatus) {
        // 권한 요청
        final permissionStatus = await FirebaseMessaging.instance.requestPermission();
        if (permissionStatus.authorizationStatus == AuthorizationStatus.authorized) {
          // 권한이 승인되면 FCM 토큰 처리
          await _handleFcmToken();
        } else {
          // 권한이 거부된 경우 다이얼로그 표시
          _showPermissionDialog(context);
          return; // 알림을 활성화할 수 없으므로 종료
        }
      } else {
        // 알림 비활성화 시 FCM 토큰 삭제
        await _deleteFcmToken();
      }

      // 상태 업데이트 및 저장
      state = currentState.copyWith(isPushNotificationEnabled: newStatus);
      await _savePushNotificationState(newStatus);
    } catch (e) {
      print('푸시 알림 설정 중 오류 발생: $e');
      rethrow;
    }
  }


  void _showPermissionDialog(BuildContext context) {
    showConfirmModal(
      context: context,
      content: Text(
        '알림을 활성화하려면 설정에서 권한을 허용해주세요.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16 * su,
          color: Colors.black,
        ),
      ),
      confirmText: '설정 열기',
      onClickConfirm: () {
        openAppSettings(); // 앱 설정 화면 열기
      },
      isCancelButton: true, // 취소 버튼 표시
    );
  }


  // FCM 토큰 처리
  Future<void> _handleFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await _fcmTokenStore.saveFcmToken(fcmToken);
        print('FCM 토큰 저장 완료: $fcmToken');

        await _apiClient.post('fcm', data: {'token': fcmToken});
        print('FCM 토큰 서버 전송 완료');
        state = state?.copyWith(isPushNotificationEnabled: true);
      }
    } catch (e) {
      print('FCM 토큰 처리 중 오류 발생: $e');
    }
  }

  // FCM 토큰 삭제
  Future<void> _deleteFcmToken() async {
    try {
      final fcmToken = await _fcmTokenStore.getFcmToken();
      if (fcmToken != null) {
        await _apiClient.delete('fcm');
        print('FCM 토큰 서버 삭제 완료: $fcmToken');

        await _fcmTokenStore.deleteFcmToken();
        print('로컬 저장소 FCM 토큰 삭제 완료');
        state = state?.copyWith(isPushNotificationEnabled: false);
      }
    } catch (e) {
      print('FCM 토큰 삭제 중 오류 발생: $e');
    }
  }

  // 푸시 알림 상태 저장
  Future<void> _savePushNotificationState(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushNotificationEnabled', isEnabled);
  }

  // 푸시 알림 상태 로드
  Future<bool> _loadPushNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isPushNotificationEnabled')) {
      return prefs.getBool('isPushNotificationEnabled')!;
    }

    final permissionStatus = await FirebaseMessaging.instance.requestPermission();
    final isAuthorized = permissionStatus.authorizationStatus == AuthorizationStatus.authorized;

    await prefs.setBool('isPushNotificationEnabled', isAuthorized);
    return isAuthorized;
  }
}


// Provider 정의
final fcmTokenStoreProvider = Provider((ref) => FcmTokenStore());
final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, MyPageModel?>((ref) {
  final apiClient = ApiClient();
  final secureStorageService = ref.read(secureStorageServiceProvider);
  final fcmTokenStore = ref.read(fcmTokenStoreProvider);
  return MyPageViewModel(apiClient, secureStorageService, fcmTokenStore);
});
