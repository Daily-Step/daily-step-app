import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/list_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/widget_card.dart';
import '../../../widgets/widget_confirm_modal.dart';
import '../../../widgets/widget_month_calendar.dart';
import '../../../widgets/widget_progress_indicator.dart';
import '../action/challenge_list_action.dart';
import '../viewmodel/challenge_viewmodel.dart';

class ChallengeDetailScreen extends ConsumerWidget {
  final int id;

  ChallengeDetailScreen(this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChallengeState = ref.watch(challengeViewModelProvider);
    final notifier = ref.read(challengeViewModelProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Align(
              alignment: Alignment.center,
              child: Text(selectedChallengeState.when(
                  data: (state) => state.selectedChallenge!.title,
                  error: (Object error, StackTrace stackTrace) => '',
                  loading: () => ''))),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (String value) {
                if (value == '수정하기') {
                  context.go('/main/challenge/edit/${id}');
                } else if (value == '삭제하기') {
                  showConfirmModal(
                    context: context,
                    content: Column(
                      children: [
                        Text(
                          '정말로 삭제하시겠어요?',
                          style: boldTextStyle,
                        ),
                        height5,
                        Text(
                          '한번 삭제하면 복구가 힘들어요',
                          style: subTextStyle,
                        )
                      ],
                    ),
                    confirmText: '챌린지삭제',
                    onClickConfirm: () {
                      notifier.handleAction(DeleteChallengeAction(id));
                      Navigator.pop(context);
                      showConfirmModal(
                          context: context,
                          content: Column(
                            children: [
                              Text(
                                '챌린지가 삭제되었습니다',
                                style: boldTextStyle,
                              ),
                              height5,
                              Text(
                                '다른 챌린지를 만들어보세요!',
                                style: subTextStyle,
                              )
                            ],
                          ),
                          confirmText: '닫기',
                          onClickConfirm: () {
                            Navigator.pop(context);
                          },
                          isCancelButton: false);
                    },
                    isCancelButton: true,
                  );
                }
              },
              itemBuilder: (BuildContext context) =>
              [
                PopupMenuItem(
                  value: '수정하기',
                  child: Text('수정하기'),
                ),
                PopupMenuItem(
                  value: '삭제하기',
                  child: Text('삭제하기'),
                ),
              ],
            ),
          ],
        ),
        body: selectedChallengeState.when(
            data: (ChallengesState data) {
              final selectedChallenge = data.selectedChallenge;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 달성도 Progress Indicator
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Text('달성도',
                                      style: TextStyle(color: Colors.grey)),
                                  height40,
                                  Align(
                                    alignment: Alignment.center,
                                    child: WProgressIndicator(
                                        percentage: selectedChallenge
                                            !.totalGoalCount
                                            .getProgress(selectedChallenge
                                            .record.successDates.length),
                                        width: 100,
                                        height: 100,
                                        strokeWidth: 12,
                                        fontSize: 26,
                                        color:
                                        Color(
                                            int.parse(selectedChallenge.color)),
                                        subString: '%'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('챌린지 시작일',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(selectedChallenge.startDatetime
                                        .formattedDate,
                                        style: boldTextStyle),
                                    height10,
                                    Text('챌린지 기간',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(
                                        selectedChallenge.durationInWeeks
                                            .toString() +
                                            '주 챌린지',
                                        style: boldTextStyle),
                                    height10,
                                    Text('실천 횟수',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(
                                        selectedChallenge.weekGoalCount
                                            .toString() +
                                            '회 실천',
                                        style: boldTextStyle),
                                    height10,
                                    Text('카테고리',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(
                                        data.categories
                                            .firstWhere((category) =>
                                        category.id ==
                                            selectedChallenge.category.id).name,
                                        style: boldTextStyle),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      height2,
                      Row(
                        children: [
                          _card(
                              '달성한 날',
                              _textWithSubText(
                                  selectedChallenge.record.successDates.length
                                      .toString() +
                                      '일',
                                  ' /' +
                                      (selectedChallenge.startDatetime
                                          .goalDays(
                                          selectedChallenge.endDatetime,
                                          selectedChallenge.weekGoalCount)
                                          .toString())),
                              'assets/icons/success.svg'),
                          width2,
                          _card(
                              '미달성한 날',
                              _textWithSubText(
                                  selectedChallenge.startDatetime
                                      .failDays(
                                      selectedChallenge.endDatetime,
                                      selectedChallenge.weekGoalCount,
                                      selectedChallenge
                                          .record.successDates.length)
                                      .toString() +
                                      '일',
                                  ' /' +
                                      (selectedChallenge.startDatetime
                                          .goalDays(
                                          selectedChallenge.endDatetime,
                                          selectedChallenge.weekGoalCount)
                                          .toString())),
                              'assets/icons/fail.svg'),
                        ],
                      ),
                      height2,
                      Row(
                        children: [
                          _card(
                              '최대 연속 성공 횟수',
                              Text(
                                  selectedChallenge.record.successDates
                                      .countLongestSuccessDays()
                                      .toString() +
                                      '일',
                                  style: boldTextStyle),
                              'assets/icons/medal.svg'),
                          width2,
                          _card(
                              '남은 기간',
                              Text(
                                  selectedChallenge.endDatetime.lastDays()
                                      .toString() +
                                      '일',
                                  style: boldTextStyle),
                              'assets/icons/calendar.svg'),
                        ],
                      ),
                      height2,
                      WCard(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/achieved.svg',
                                    width: 18,
                                    height: 18,
                                    allowDrawingOutsideViewBox: true,
                                    cacheColorFilter: false,
                                  ),
                                  Text('달성한 날',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  onPressed: () =>
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return WMonthModal(
                                              successList:
                                              selectedChallenge.record
                                                  .successDates,
                                            );
                                          }))
                            ],
                          )),
                      WCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('상세 내용', style: TextStyle(
                                  color: Colors.grey)),
                              SizedBox(height: 8),
                              Text(selectedChallenge.content),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
            error: (Object error, StackTrace stackTrace)=> SizedBox(),
            loading: ()=> SizedBox(),
        )
    );
  }

  Expanded _card(String title, Widget contents, String iconPath) {
    return Expanded(
      child: WCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 18,
                    height: 18,
                    allowDrawingOutsideViewBox: true,
                    cacheColorFilter: false,
                  ),
                  Text(title, style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 8),
              Align(alignment: Alignment.centerRight, child: contents)
            ],
          )),
    );
  }
}

Widget _textWithSubText(String text, String subText) {
  return RichText(
    text: TextSpan(
        text: text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: detailDataFontSize,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: subText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: subFontSize,
              color: subTextColor,
            ),
          )
        ]),
  );
}
