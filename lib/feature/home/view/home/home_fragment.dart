import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_confirm_modal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/util/size_util.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_week_calendar.dart';
import '../../../mypage/viewmodel/mypage_viewmodel.dart';
import 'challenge_empty.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'challenge_list.dart';

const int WEEK_TOTAL_PAGE = 104;
const int WEEK_START_PAGE = 26;
const int numberOfColumns = 7;
const double crossAxisSpacing = 20;


class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final PageController weekPageController = PageController(initialPage: WEEK_TOTAL_PAGE);

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission(); // ✅ 앱 실행 시 알림 요청 여부 확인
  }

  Future<void> _checkNotificationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasAsked = prefs.getBool('hasAskedNotificationPermission') ?? false;

    if (!hasAsked) {
      bool? userConsent = await _showPermissionDialog(context);

      if (userConsent == true) {
        await _requestNotificationPermission(); // ✅ FCM 알림 요청
      }

      await prefs.setBool('hasAskedNotificationPermission', true);
    }
  }

  Future<bool?> _showPermissionDialog(BuildContext context) async {
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
                SizedBox(height: 8 * su),
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
                            Navigator.pop(context, false); // ✅ `await` 제거
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
                          onPressed: () {
                            Navigator.pop(context, true); // ✅ `await` 제거
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


  Future<void> _requestNotificationPermission() async {
    print("🔹 FCM 알림 권한 요청 시작");

    final settings = await FirebaseMessaging.instance.requestPermission();
    final prefs = await SharedPreferences.getInstance();

    bool isEnabled = settings.authorizationStatus == AuthorizationStatus.authorized;

    // ✅ 푸시 알림 상태 SharedPreferences에 저장
    await prefs.setBool('isPushNotificationEnabled', isEnabled);

    // ✅ MyPageViewModel에서 상태 업데이트
    ref.read(myPageViewModelProvider.notifier).updatePushState(isEnabled);

    if (isEnabled) {
      print("✅ 알림 권한이 허용되었습니다.");
      _showPushEnabledDialog(context, isEnabled: true);
    } else {
      print("🚫 사용자가 알림 권한을 거부했습니다.");
      _showPushEnabledDialog(context, isEnabled: false);
    }
  }

  void _showPushEnabledDialog(BuildContext context, {required bool isEnabled}) {
    if (!context.mounted) return; // ✅ context가 유효할 때만 실행

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

  @override
  void dispose() {
    weekPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final state = ref.watch(challengeViewModelProvider);
    final calendarContainerHeight = (screenWidth - 20 - (numberOfColumns - 1) * crossAxisSpacing) / numberOfColumns;
    final calendarLabelHeight = 17 + 4; // 라벨 높이 + 마진 높이
    return state.when(
        data: (data) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(
                        data.selectedDate.formattedMonth,
                        style: boldTextStyle.copyWith(fontSize: 20),
                      ),
                    ]),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: data!.profileImageUrl != null
                          ? ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/ellipse.png',
                                image: data.profileImageUrl!,
                                fit: BoxFit.cover,
                                fadeInDuration: const Duration(milliseconds: 700),
                                width: 80 * su,
                                height: 80 * su,
                              ),
                            )
                          : Container(
                              width: 80 * su,
                              height: 80 * su,
                              decoration: BoxDecoration(
                                color: WAppColors.mPrimary,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '🥰',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: calendarContainerHeight + calendarLabelHeight,
                curve: Curves.easeInOut,
                child: WWeekPageView(
                  weekPageController: weekPageController,
                  successList: data.successList,
                ),
              ),
              height10,
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter, // ✅ 하단 배경으로 배치
                  children: [
                    /// ✅ 챌린지 리스트 (배경 위에 올라올 콘텐츠)
                    Padding(
                      padding: globalMargin,
                      child: Column(
                        children: [
                          height10,
                          data.challengeList.isEmpty
                              ? ChallengeEmpty()
                              : Expanded(child: ChallengeList()), // ✅ Expanded로 남은 공간 채우기
                        ],
                      ),
                    ),
                    /// ✅ 배경 Gradient Container
                    Positioned(
                      child: Container(
                        height: 60 * su,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0x00F8F8F8), Color(0xFFF8F8F7)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (Object error, StackTrace stackTrace) => SizedBox(),
        loading: () => SizedBox());
  }
}
