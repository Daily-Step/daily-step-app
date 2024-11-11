import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/model/challenge/challenge_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekCalendar extends StatelessWidget {
  final List<ChallengeModel> challengeList;

  WeekCalendar({super.key, required this.challengeList});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    List<DateTime> daysOfWeek =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: daysOfWeek.map((date) {
          String day = DateFormat('E').format(date);
          String dayNumber = DateFormat('d').format(date);
          bool isSelected = date.day == now.day &&
              date.month == now.month &&
              date.year == now.year;

          // 해당 날짜에 모든 챌린지를 달성했는지 확인
          bool isAllAchieved = _isAllChallengesAchieved(date, challengeList);
          bool isAnyAchieved = _isAnyChallengesAchieved(date, challengeList);

          Color indicatorColor;
          indicatorColor = Colors.transparent;
          if (isSelected) {
            // 오늘 날짜는 검은색 원
            indicatorColor = Colors.black;
          } else if (date.isBefore(now)) {
            if (isAllAchieved) {
              // 모든 챌린지가 달성된 날짜는 파란색 원
              indicatorColor = Colors.blue;
            } else if (isAnyAchieved) {
              // 일부만 달성된 날짜는 회색 원
              indicatorColor = Colors.grey;
            }
          }
          return _buildDay(day, dayNumber, isSelected, indicatorColor);
        }).toList(),
      ),
    );
  }

  Widget _buildDay(
      String day, String date, bool isSelected, Color indicatorColor) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
              color: day == "Sun"
                  ? Colors.red
                  : (day == "Sat" ? Colors.blue : Colors.black)),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: indicatorColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            date,
            style: TextStyle(
              color: indicatorColor == Colors.transparent
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  bool _isAllChallengesAchieved(
      DateTime date, List<ChallengeModel> challengeList) {
    for (ChallengeModel challenge in challengeList) {
      if (!challenge.successList
          .any((successDate) => successDate.isSameDate(date))) {
        return false;
      }
    }
    return true;
  }

  bool _isAnyChallengesAchieved(
      DateTime date, List<ChallengeModel> challengeList) {
    for (ChallengeModel challenge in challengeList) {
      if (challenge.successList
          .any((successDate) => successDate.isSameDate(date))) {
        return true;
      }
    }
    return false;
  }
}
