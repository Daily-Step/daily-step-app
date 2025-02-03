import 'package:dailystep/common/extension/datetime_extension.dart';
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
      // 한 번도 요청한 적이 없으면 다이얼로그 실행
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPermissionDialog(context);
      });

      // 이후 다시 뜨지 않도록 저장
      await prefs.setBool('hasAskedNotificationPermission', true);
    }
  }

  /// 푸시 알림 권한 요청 다이얼로그 (한 번만 실행됨)
  void _showPermissionDialog(BuildContext context) {
    showConfirmModal(
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 내용 크기만큼만 차지하도록 설정
        children: [
          Text(
            '\'DailyStep\'에서 알림을 보내고자 합니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16 * su, color: Colors.black),
          ),
          SizedBox(height: 8 * su), // 간격 추가
          Text(
            '푸시 알림을 통해 고객님의 챌린지 알림, 이벤트와 업데이트 소식 등을 전송하려고 합니다. 앱 푸시에 수신 동의 하시겠습니까?.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14 * su, color: Colors.black54),
          ),
        ],
      ),
      confirmText: '설정 열기',
      onClickConfirm: () {
        openAppSettings(); // 앱 설정 화면 열기
      },
      isCancelButton: true,
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
    final user = ref.watch(myPageViewModelProvider);
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

                    /// ✅ 챌린지 리스트 (배경 위에 올라올 콘텐츠)
                    Column(
                      children: [
                        height10,
                        data.challengeList.isEmpty == 0
                            ? ChallengeEmpty()
                            : Expanded(child: ChallengeList()), // ✅ Expanded로 남은 공간 채우기
                      ],
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
