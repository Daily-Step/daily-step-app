import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/data/api/firebase_api.dart';
import 'package:dailystep/widgets/widget_confirm_modal.dart';
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
    _checkNotificationPermission(); // 앱 실행 시 알림 요청 여부 확인
  }

  Future<void> _checkNotificationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasAsked = prefs.getBool('hasAskedNotificationPermission') ?? false;

    if (!hasAsked) {
      // 한 번도 요청한 적이 없으면 다이얼로그 실행
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPermissionDialog(context);
      });

      // 이후 다시 뜨지 않도록 저장
      await prefs.setBool('hasAskedNotificationPermission', true);
    }
  }

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
                            Navigator.pop(context, true); // 다이얼로그 닫기
                            final prefs = await SharedPreferences.getInstance();
                            // 사용자가 동의했음을 별도의 키(userConsentedForPush)에 저장
                            await prefs.setBool('userConsentedForPush', true);
                            // MyPageViewModel의 togglePushNotification을 호출하면 내부에서 FCM 토큰 등록(_handleFcmToken)이 실행됩니다.
                            bool result = await ref.read(myPageViewModelProvider.notifier)
                                .togglePushNotification(context, value: true);
                            // result가 true이면, 푸시 알림 활성화가 성공적으로 완료된 상태입니다.
                            _showPushEnabledDialog(context, isEnabled: result);
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

  void _showPushEnabledDialog(BuildContext context, {required bool isEnabled}) {
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
    final state = ref.watch(challengeViewModelProvider);
    final user = ref.read(myPageViewModelProvider);

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
                      child: user!.profileImageUrl.isNotEmpty
                          ? ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/ellipse.png',
                                image: user.profileImageUrl,
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
                                color: WAppColors.secondary1,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '🥰',
                                style: TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 66 * su,
                curve: Curves.easeInOut,
                child: WWeekPageView(
                  weekPageController: weekPageController,
                  successList: data.successList,
                ),
              ),
                /**
                 *  그라데이션 이전 코드
                data.challengeList.length == 0
                  ? ChallengeEmpty()
                  : Expanded(
                      child: ChallengeList(),
                    ),*/
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter, // 하단 배경으로 배치
                  children: [
                    /// 챌린지 리스트 (배경 위에 올라올 콘텐츠)
                    Column(
                      children: [
                        height10,
                        data.challengeList.isEmpty == 0
                            ? ChallengeEmpty()
                            : Expanded(child: ChallengeList()), // Expanded로 남은 공간 채우기
                      ],
                    ),

                    /// 배경 Gradient Container
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
