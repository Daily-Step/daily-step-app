import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/widget_buttons.dart';
import '../../../widgets/widget_card.dart';
import '../../../widgets/widget_progress_indicator.dart';
import '../viewmodel/challenge_viewmodel.dart';
import 'settings/category_dummies.dart';

class ChallengeDetailScreen extends ConsumerStatefulWidget {
  final int id;

  ChallengeDetailScreen(this.id);

  @override
  _ChallengeDetailScreenState createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends ConsumerState<ChallengeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(challengeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(state.selectedTask!.title),
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
                        height15,
                        Align(
                          alignment: Alignment.center,
                          child: WProgressIndicator(
                            percentage: state.selectedTask!.totalGoalCount
                                .getProgress(
                                    state.selectedTask!.achievedTotalGoalCount),
                            width: 80,
                            height: 80,
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
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        height10,
                        Text('챌린지 기간', style: TextStyle(color: Colors.grey)),
                        Text(
                            state.selectedTask!.startDatetime
                                    .calculateWeeksBetween(
                                        state.selectedTask!.endDatetime)
                                    .toString() +
                                '주 챌린지',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        height10,
                        Text('실천 횟수', style: TextStyle(color: Colors.grey)),
                        Text(
                            state.selectedTask!.weeklyGoalCount.toString() +
                                '회 실천',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            height10,
            // 달성 횟수와 카테고리 카드
            Row(
              children: [
                Expanded(
                  child: WCard(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('달성 횟수', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            state.selectedTask!.achievedTotalGoalCount
                                    .toString() +
                                '일',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
                ),
                width10,
                Expanded(
                  child: WCard(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('카테고리', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            dummyCategories
                                .firstWhere((category) =>
                                    category.id ==
                                    state.selectedTask?.categoryId)
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
                ),
              ],
            ),
            height10,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: WCtaButton(
          '수정하기',
          onPressed: () {
            context.go('/main/home/challenge/edit/${widget.id}');
          },
        ),
      ),
    );
  }
}
