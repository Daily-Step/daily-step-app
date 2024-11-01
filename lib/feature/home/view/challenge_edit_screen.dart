import 'package:dailystep/feature/home/action/challenge_list_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/challenge_viewmodel.dart';

class ChallengeDetailScreen extends ConsumerStatefulWidget {
  final int id;
  ChallengeDetailScreen(this.id);

  @override
  _ChallengeDetailScreenState createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends ConsumerState<ChallengeDetailScreen> {
  bool pushEnabled = true;
  DateTime selectedDate = DateTime(2024, 9, 1);
  int weeks = 2;
  List<bool> selectedDays = [false, true, true, true, true, true, false];

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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 진행도 섹션
              Text('진행', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildProgressBar('달성도', 0.85, Colors.grey.shade400),

              // 기록 섹션
              SizedBox(height: 24),
              Text('기록', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('달력 보기'),
                trailing: Icon(Icons.calendar_today),
                contentPadding: EdgeInsets.zero,
              ),

              // 챌린지 기간 섹션
              SizedBox(height: 16),
              Text('챌린지 기간', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('시작'),
                          Text('2024.09.01'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('주 반복 횟수'),
                          Row(
                            children: [
                              Text('2주'),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 실천일 설정
              SizedBox(height: 24),
              Text('실천일 설정', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildWeekdaySelector(),

              // PUSH 알림
              SizedBox(height: 24),
              Text('PUSH 알림', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('알림여부'),
                          Switch(
                            value: pushEnabled,
                            onChanged: (value) {
                              setState(() => pushEnabled = value);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('시간'),
                          Text('매일 20:00'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 챌린지 카테고리
              SizedBox(height: 24),
              Text('챌린지 카테고리', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('카테고리'),
                trailing: Text('운동'),
                contentPadding: EdgeInsets.zero,
              ),

              // 노트
              SizedBox(height: 24),
              Text('노트', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: '챌린지 상세 내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),

              // 수정하기 버튼
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('수정하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('${(value * 100).toInt()}%'),
          ],
        ),
        SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildWeekdaySelector() {
    final weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return Container(
          width: 40,
          height: 40,
          child: Material(
            color: selectedDays[index] ? Colors.grey : Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedDays[index] = !selectedDays[index];
                });
              },
              child: Center(
                child: Text(
                  weekdays[index],
                  style: TextStyle(
                    color: selectedDays[index] ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}