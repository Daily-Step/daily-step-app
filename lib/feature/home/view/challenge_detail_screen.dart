import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/common/extension/mun_duration_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/widget_progress_indicator.dart';
import '../viewmodel/challenge_viewmodel.dart';

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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 달성도 Progress Indicator
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('달성도', style: TextStyle(color: Colors.grey)),
                          Align(
                            alignment: Alignment.center,
                            child: WProgressIndicator(
                              percentage: state.selectedTask!.totalGoalCount
                                  .getProgress(
                                      state.selectedTask!.achievedTotalGoalCount),
                              width: 80,
                              height: 80,
                              strokeWidth: 12, fontSize: 20,
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
                          Text('2주 챌린지',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          height10,
                          Text('실천 횟수', style: TextStyle(color: Colors.grey)),
                          Text('주 3회',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height10,
            // 달성 횟수와 카테고리 카드
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('달성 횟수', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 8),
                          Text('3일',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                width10,
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('카테고리', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 8),
                          Text('운동 🏃',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height10,
            // 상세 내용 카드
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('상세 내용', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('• 적어도 일주일에 3번 이상은 헬스장 가기\n• 근력운동 위주로'),
                  ],
                ),
              ),
            ),
            Spacer(),
            // 수정하기 버튼
            ElevatedButton(
              onPressed: () {
                // 수정하기 버튼 동작 추가
              },
              child: Text('수정하기', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
