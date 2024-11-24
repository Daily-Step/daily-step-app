import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/widget_card.dart';
import '../../../widgets/widget_progress_indicator.dart';
import '../action/challenge_list_action.dart';
import '../viewmodel/challenge_viewmodel.dart';
import 'settings/category_dummies.dart';

class ChallengeDetailScreen extends ConsumerWidget {
  final int id;

  ChallengeDetailScreen(this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeViewModelProvider);
    final notifier = ref.read(challengeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Align(alignment: Alignment.center,child: Text(state.selectedTask!.title)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              if (value == '수정하기') {
                context.go('/main/home/challenge/edit/${id}');
              } else if (value == '삭제하기') {
                notifier.handleAction(DeleteTaskAction(id));
                Navigator.pop(context);
              }
            },
            itemBuilder: (BuildContext context) => [
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
      body: Padding(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('달성도', style: TextStyle(color: Colors.grey)),
                        height40,
                        Align(
                          alignment: Alignment.center,
                          child: WProgressIndicator(
                            percentage: state.selectedTask!.totalGoalCount
                                .getProgress(
                                    state.selectedTask!.successList.length),
                            width: 100,
                            height: 100,
                            strokeWidth: 12,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('챌린지 시작일', style: TextStyle(color: Colors.grey)),
                        Text(state.selectedTask!.startDatetime.formattedDate,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: detailDataFontSize)),
                        height10,
                        Text('챌린지 기간', style: TextStyle(color: Colors.grey)),
                        Text(
                            state.selectedTask!.startDatetime
                                    .calculateWeeksBetween(
                                        state.selectedTask!.endDatetime)
                                    .toString() +
                                '주 챌린지',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: detailDataFontSize)),
                        height10,
                        Text('실천 횟수', style: TextStyle(color: Colors.grey)),
                        Text(
                            state.selectedTask!.weeklyGoalCount.toString() +
                                '회 실천',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: detailDataFontSize)),
                        height10,
                        Text('카테고리', style: TextStyle(color: Colors.grey)),
                        Text(
                            dummyCategories
                                .firstWhere((category) =>
                                    category.id ==
                                    state.selectedTask?.categoryId)
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: detailDataFontSize)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            height2,
            // 달성 횟수와 카테고리 카드
            Row(
              children: [
                _card(state,'달성한 날',Text(state.selectedTask!.successList.length.toString() + '일',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: detailDataFontSize)),
            ),
                width2,
                _card(state,'미달성한 날',Text(state.selectedTask!.successList.length.toString() + '일',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: detailDataFontSize)),
                ),
              ],
            ),
            height2,
            Row(
              children: [
                _card(state,'최대 연속 성공 횟수',Text(state.selectedTask!.successList.length.toString() + '일',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: detailDataFontSize)),
                ),
                width2,
                _card(state,'남은 기간',Text(state.selectedTask!.successList.length.toString() + '일',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: detailDataFontSize)),
                ),
              ],
            ),
            height2,
            WCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('달성한 날', style: TextStyle(color: Colors.grey)),
                    IconButton(
                      icon: Icon(Icons.calendar_today_outlined),
                      onPressed: (){},
                    )
                  ],
                )),
            WCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('상세 내용', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text(state.selectedTask!.content),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Expanded _card(ChallengesState state, String title, Widget contents) {
    return Expanded(
      child: WCard(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: contents)
        ],
      )),
    );
  }
}
