import 'dart:async';

import 'package:dailystep/widgets/widget_confirm_modal.dart';
import 'package:dailystep/widgets/widget_constant.dart';
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
  Timer? _midnightTimer;
  bool _isLoaded = false;

  MyPageViewModel(
      this._apiClient,
      this._secureStorageService,
      this._fcmTokenStore,
      ) : super(null) {
    _initialize();
    _scheduleMidnightUpdate(); // 자정 업데이트 스케줄링
  }

  void _scheduleMidnightUpdate() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    final durationUntilMidnight = nextMidnight.difference(now);

    _midnightTimer = Timer(durationUntilMidnight, () {
      print("자정이 되어 챌린지 상태 업데이트 중...");
      refreshUserData(); // 서버에서 최신 데이터 가져와 업데이트
      _scheduleMidnightUpdate(); // 다시 스케줄링
    });
  }

  /// 초기화
  Future<void> _initialize() async {
    await loadUserDataOnce();
    await _loadPushNotificationState(); // 권한 상태 체크 및 저장
    _initializeFCMListeners();
  }

  @override
  void handleEvent(MyPageAction action) {
    if (action is FetchUserDataAction) {
      loadUserData();
    } else if (action is UpdateUserProfileAction) {
      _updateUserProfile(action.newUserName, action.birth, action.gender);
    }
  }

  /// 유저 데이터를 한 번만 불러오기
  Future<void> loadUserDataOnce() async {
    if (_isLoaded) return;
    _isLoaded = true;
    await loadUserData();
  }

  /// 유저 데이터 로드
  Future<void> loadUserData() async {
    try {
      final response = await _apiClient.get('member/mypage');
      if (response.statusCode == 200 && response.data != null) {
        final prefs = await SharedPreferences.getInstance();
        final isPushEnabled = prefs.getBool('isPushNotificationEnabled') ?? false;
        state = MyPageModel.fromJson(response.data).copyWith(isPushNotificationEnabled: isPushEnabled);;
        print("데이트된 유저 데이터: ${state.toString()}"); // 디버깅 출력
      } else {
        throw Exception('데이터 로드 실패');
      }
    } catch (e) {
      print('사용자 데이터 로드 실패: $e');
    }
  }

  /// 챌린지 등록 후 최신 데이터 반영
  Future<void> refreshUserData() async {
    await loadUserData(); // 서버에서 다시 불러오기
  }

  /// 프로필 업데이트
  void _updateUserProfile(String newUserName, DateTime birth, String gender) {
    if (state != null) {
      state = state!.copyWith(
        nickname: newUserName,
        birth: birth,
        gender: gender,
      );
    }
  }

  /// 푸시 알림 초기화
  Future<void> _initializePushNotification() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    final isAuthorized = settings.authorizationStatus == AuthorizationStatus.authorized;

    await _savePushNotificationState(isAuthorized);

    if (isAuthorized) {
      await _handleFcmToken();
    } else {
      await _deleteFcmToken();
    }

    state = state?.copyWith(isPushNotificationEnabled: isAuthorized);
  }

  /// FCM 리스너 초기화
  void _initializeFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('푸시 알림 수신: ${message.notification?.title}, ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('알림 클릭으로 앱 열림: ${message.notification?.title}');
    });
  }

  /// 푸시 알림 활성화/비활성화
  Future<void> togglePushNotification(BuildContext context, {required bool value}) async {
    final currentState = state;
    if (currentState == null) return;

    try {
      /// 현재 푸시 알림 권한 상태 확인 (자동 요청 )
      final settings = await FirebaseMessaging.instance.getNotificationSettings();
      final isAuthorized = settings.authorizationStatus == AuthorizationStatus.authorized;

      if (value) {
        if (isAuthorized) {
          /// 이미 권한이 허용된 상태 → FCM 토큰 저장
          await _handleFcmToken();
        } else {
          /// 푸시 알림이 비활성화 상태 → 설정 화면으로 이동 유도
          _showPermissionDialog(context);
          return;
        }
      } else {
        /// 푸시 알림 비활성화 → FCM 토큰 삭제
        await _deleteFcmToken();
      }

      state = currentState.copyWith(isPushNotificationEnabled: value);
      await _savePushNotificationState(value);
    } catch (e) {
      print('푸시 알림 설정 중 오류 발생: $e');
    }
  }

  /// notify 알람 다이얼로그
  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * su),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 * su, vertical: 20 * su),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\'데일리스텝\'에서 알림을 보내고자 합니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24 * su, color: Colors.black, fontWeight: FontWeight.w800, height: 1.5),
                ),
                SizedBox(height: 8 * su), // 간격 추가
                Text(
                  '푸시 알림을 통해 고객님의 챌린지 알림, 이벤트와 업데이트 소식 등을 전송하려고 합니다.\n앱 푸시에 수신 동의 하시겠습니까?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13 * su, color: Colors.black54),
                ),
                SizedBox(height: 20 * su),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50 * su,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: WAppColors.gray03,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14 * su),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // 다이얼로그 닫기
                            _showPushEnabledDialog(context, isEnabled: false);
                          },
                          child: Text(
                            '미동의',
                            style: TextStyle(color: WAppColors.gray05),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    Expanded(
                      child: Container(
                        height: 50 * su,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: WAppColors.secondary1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14 * su),
                            ),
                          ),
                          onPressed: () async {
                            PermissionStatus status = await Permission.notification.request();
                            Navigator.pop(context); // 다이얼로그 닫기

                            if (status.isGranted) {
                              _showPushEnabledDialog(context, isEnabled: true);
                            } else {
                              _showPushEnabledDialog(context, isEnabled: false);
                            }
                          },
                          child: Text(
                            '동의',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 알림 수신 동의 다이얼로그
  void _showPushEnabledDialog(BuildContext context, {required bool isEnabled}) {
    if (!context.mounted) return;

    String title = isEnabled ? '알림 수신 동의가 완료되었습니다.' : '알림 수신 동의가 거부되었습니다.';
    String message = '앱 푸시 수신 동의는 마이 > [매일 챌린지 알림]에서 변경 가능합니다.';

    showConfirmModal(
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          height20,
          Text(title, textAlign: TextAlign.center, style: WAppFontSize.titleL()),
          height10,
          Text(message, textAlign: TextAlign.center, style: WAppFontSize.values()),
          height20,
        ],
      ),
      confirmText: '닫기',
      onClickConfirm: () {
        if (context.mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      isCancelButton: false,
    );
  }

  /// FCM 토큰 처리
  Future<void> _handleFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await _fcmTokenStore.saveFcmToken(fcmToken);
        await _apiClient.post('fcm', data: {'token': fcmToken});
        state = state?.copyWith(isPushNotificationEnabled: true);
      }
    } catch (e) {
      print('FCM 토큰 처리 중 오류 발생: $e');
    }
  }

  /// FCM 토큰 삭제
  Future<void> _deleteFcmToken() async {
    try {
      await _apiClient.delete('fcm');
      await _fcmTokenStore.deleteFcmToken();
      state = state?.copyWith(isPushNotificationEnabled: false);
    } catch (e) {
      print('FCM 토큰 삭제 중 오류 발생: $e');
    }
  }

  /// 푸시 알림 상태 저장
  Future<void> _savePushNotificationState(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushNotificationEnabled', isEnabled);
  }

  /// 푸시 알림 상태 로드
  Future<bool> _loadPushNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isPushNotificationEnabled')) {
      return prefs.getBool('isPushNotificationEnabled')!;
    }


    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    final isAuthorized = settings.authorizationStatus == AuthorizationStatus.authorized;
    await prefs.setBool('isPushNotificationEnabled', isAuthorized);
    return isAuthorized;
  }

  void updateUserState(MyPageModel updatedUser) {
    if (state != null) {
      state = state!.copyWith(
        ongoingChallenges: updatedUser.ongoingChallenges,
        completedChallenges: updatedUser.completedChallenges,
        totalChallenges: updatedUser.totalChallenges,
        isPushNotificationEnabled: updatedUser.isPushNotificationEnabled,
      );
    }
  }
}

/// Provider 정의
final fcmTokenStoreProvider = Provider<FcmTokenStore>((ref) {
  return FcmTokenStore();
});

final myPageViewModelProvider = StateNotifierProvider.autoDispose<MyPageViewModel, MyPageModel?>((ref) {
  final apiClient = ApiClient();
  final secureStorageService = ref.read(secureStorageServiceProvider);
  final fcmTokenStore = ref.read(fcmTokenStoreProvider);
  return MyPageViewModel(apiClient, secureStorageService, fcmTokenStore);
});
