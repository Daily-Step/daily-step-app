
import 'dart:math';

import 'package:dailystep/common/extension/string_extension.dart';

extension ListExtension<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(T value, int index) f) {
    return asMap().entries.map((entry) => f(entry.value, entry.key));
  }
}

extension ListStringDateExtension on List<String> {
  int countLongestSuccessDays() {
    if (isEmpty) return 0;

    // 문자열 리스트를 DateTime 리스트로 변환 후, 정렬
    List<DateTime> dateList = map((date) => date.toDateTime.onlyDate()).toList();
    dateList.sort((a, b) => a.compareTo(b));

    int longestStreak = 0;
    int currentStreak = 1;

    for (int i = 1; i < dateList.length; i++) {
      // 날짜가 연속된 경우
      if (dateList[i].difference(dateList[i - 1]).inDays == 1) {
        currentStreak++;
      } else {
        // 연속되지 않으면 현재 streak을 최대값과 비교 후 초기화
        longestStreak = max(longestStreak, currentStreak);
        currentStreak = 1;
      }
    }

    // 마지막 streak까지 고려
    longestStreak = max(longestStreak, currentStreak);
    return longestStreak;
  }
}

// `onlyDate()` 확장 함수 추가 (시간 정보 제거)
extension DateTimeExtension on DateTime {
  DateTime onlyDate() {
    return DateTime(year, month, day);
  }
}