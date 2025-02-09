import 'dart:async';
import 'dart:io';

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
    await _initializePushNotification();
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
      final prefs = await SharedPreferences.getInstance();
      final storedPushState = prefs.getBool('isPushNotificationEnabled') ?? false;

      final response = await _apiClient.get('member/mypage');
      if (response.statusCode == 200 && response.data != null) {
        final myPageModel = MyPageModel.fromJson(response.data);

        // SharedPreferences 값이 더 최신일 수 있으므로 적용
        state = myPageModel.copyWith(isPushNotificationEnabled: storedPushState);
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
  Future<void> _initializePushNotification({bool forceInit = false}) async {
    if (!forceInit) return;

    final prefs = await SharedPreferences.getInstance();
    bool? isPushEnabled = prefs.getBool('isPushNotificationEnabled');

    if (isPushEnabled == null) {
      final settings = await FirebaseMessaging.instance.getNotificationSettings();
      isPushEnabled = settings.authorizationStatus == AuthorizationStatus.authorized;

      // 최신 기기(Android 13 이상)에서 권한 요청 추가
      if (!isPushEnabled) {
        if (Platform.isAndroid) {
          await requestNotificationPermission();
        }

        // 요청 후 다시 상태 확인
        final newSettings = await FirebaseMessaging.instance.getNotificationSettings();
        isPushEnabled = newSettings.authorizationStatus == AuthorizationStatus.authorized;
      }

      await prefs.setBool('isPushNotificationEnabled', isPushEnabled);
    }

    print("🔹 초기화 시 불러온 푸시 설정: $isPushEnabled");
    state = state?.copyWith(isPushNotificationEnabled: isPushEnabled);

    if (isPushEnabled) {
      await _handleFcmToken();
    } else {
      await _deleteFcmToken();
    }
  }

  Future<void> requestNotificationPermission() async {
    if (Platform.isAndroid && (await Permission.notification.status.isDenied || await Permission.notification.status.isRestricted)) {
      final status = await Permission.notification.request();
      if (status.isGranted) {
        print(" 알림 권한이 허용되었습니다.");
      } else if (status.isPermanentlyDenied) {
        print(" 사용자가 알림 권한을 영구적으로 거부했습니다. 설정에서 직접 변경해야 합니다.");
      } else {
        print(" 알림 권한 요청이 거부되었습니다.");
      }
    } else {
      print(" 알림 권한이 이미 허용되어 있습니다.");
    }
  }

  /// FCM 리스너 초기화
  void _initializeFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('푸시 알림 수신: ${message.notification?.title}, ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('알림 클릭으로 앱 열림: ${message.notification?.title}');
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print("FCM 토큰이 갱신됨: $newToken");
      await _handleFcmToken(); // 새로운 토큰을 서버에 저장
    });
  }

  /// 푸시 알림 활성화/비활성화
  Future<bool> togglePushNotification(BuildContext context, {required bool value}) async {
    final currentState = state;
    if (currentState == null || !mounted) return false;

    final prefs = await SharedPreferences.getInstance();
    bool userConsented = prefs.getBool('userConsentedForPush') ?? false;
    bool isGranted = value;

    if (value) {
      // 사용자가 직접 동의한 적이 없으면 다이얼로그 호출
      if (!userConsented) {
        print("📢 showPermissionDialog 호출 전");
        bool userConsent = await showPermissionDialog(context);
        print("📢 사용자 동의 결과: $userConsent");

        if (!userConsent) {
          return false;
        }
        await prefs.setBool('userConsentedForPush', true);
      }

      isGranted = true;

      //  FCM 알림 권한 요청 (비동기 작업을 기다림)
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      print(" FirebaseMessaging 설정 결과: ${settings.authorizationStatus}");

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print(" 사용자가 알림 권한을 거부했습니다.");
        _showPushEnabledDialog(context, isEnabled: false);
        return false;
      }

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print(" FCM 알림 권한 허용됨");

        //  **FCM 토큰 요청 및 서버 등록 (순차적으로 실행)**
        await _handleFcmToken(); //  토큰 요청 후 서버 저장

        //  SharedPreferences에도 저장
        await prefs.setBool('isPushNotificationEnabled', true);

        //  MyPageViewModel 상태 업데이트
        state = state?.copyWith(isPushNotificationEnabled: true);
      } else {
        print(" FCM 알림 권한을 허용하지 않음");
        return false;
      }
    } else {
      await _deleteFcmToken();
      isGranted = false;
      await prefs.setBool('isPushNotificationEnabled', false);
      state = state?.copyWith(isPushNotificationEnabled: false);
    }

    // ** 여기서 비동기 작업이 모두 끝난 후 다이얼로그 실행**
    print(" _showPushEnabledDialog 호출 ");
    _showPushEnabledDialog(context, isEnabled: isGranted);

    return isGranted;
  }

  /// notify 알람 다이얼로그
  Future<bool> showPermissionDialog(BuildContext context) async {
    return await showDialog<bool>(
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
                            Navigator.pop(context, false);
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

                            Navigator.pop(context, true);
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
    ) ?? false; // 사용자가 아무것도 선택하지 않으면 기본값 `false` 반환
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
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print(' 현재 FCM 토큰: $fcmToken');

      if (fcmToken == null) {
        print(' FCM 토큰이 없음. 삭제 후 재발급 시도...');
        fcmToken = await _forceRefreshFcmToken();
      }

      final response = await _apiClient.post('fcm', data: {'token': fcmToken});

      if (response.statusCode == 401 && response.data['code'] == 'AUTH_4006') {
        print(' 서버에서 FCM 토큰이 만료되었다고 응답함. 재발급 중...');

        //  FCM 토큰을 강제 삭제 후 새로 발급
        fcmToken = await _forceRefreshFcmToken();

        //  로그인 토큰도 갱신

        if (fcmToken != null) {
          print(' 새로운 FCM 토큰으로 다시 등록 중...');
          final retryResponse = await _apiClient.post('fcm', data: {'token': fcmToken});

          //  그래도 실패하면 로그아웃 처리
          if (retryResponse.statusCode == 401) {
            print(' 인증 실패! 로그아웃 처리');
          }
        } else {
          print(' FCM 토큰 갱신 실패.');
        }
      }

      //  토큰 저장
      if (fcmToken != null) {
        await _fcmTokenStore.saveFcmToken(fcmToken);
        state = state?.copyWith(isPushNotificationEnabled: true);
      }
    } catch (e) {
      print('⚠ FCM 토큰 처리 중 오류 발생: $e');
    }
  }

  /// FCM 토큰을 강제 삭제 후 재발급
  Future<String?> _forceRefreshFcmToken() async {
    try {
      print(" 기존 FCM 토큰 삭제 중...");
      await FirebaseMessaging.instance.deleteToken();
      await Future.delayed(Duration(seconds: 2)); // 딜레이 후 다시 요청
      String? newToken = await FirebaseMessaging.instance.getToken();
      print(" 새 FCM 토큰 발급 완료: $newToken");
      return newToken;
    } catch (e) {
      print(' FCM 토큰 강제 삭제 후 재발급 실패: $e');
      return null;
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

  /// 푸시 알림 상태 로드
  Future<bool> _loadPushNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('hasAskedNotificationPermission')) {
      return prefs.getBool('hasAskedNotificationPermission')!;
    }

    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    final isAuthorized = settings.authorizationStatus == AuthorizationStatus.authorized;
    await prefs.setBool('hasAskedNotificationPermission', isAuthorized);
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

  void updatePushState(bool isEnabled) async {
    if (!mounted || state == null) return; //  ViewModel이 살아있을 때만 실행

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushNotificationEnabled', isEnabled); //  상태 저장

    if (state!.isPushNotificationEnabled != isEnabled) {
      state = state!.copyWith(isPushNotificationEnabled: isEnabled);
    }
  }
}

/// Provider 정의
final fcmTokenStoreProvider = Provider<FcmTokenStore>((ref) {
  return FcmTokenStore();
});

final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, MyPageModel?>((ref) {
  final apiClient = ApiClient();
  final secureStorageService = ref.read(secureStorageServiceProvider);
  final fcmTokenStore = ref.read(fcmTokenStoreProvider);

  final viewModel = MyPageViewModel(apiClient, secureStorageService, fcmTokenStore);

  // 상태가 유지되도록 `keepAlive` 설정
  ref.keepAlive();

  return viewModel;
});