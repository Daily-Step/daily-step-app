
import 'dart:math';

import 'package:dailystep/common/extension/string_extension.dart';

extension ListExtension<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(T value, int index) f) {
    return asMap().entries.map((entry) => f(entry.value, entry.key));
  }

  // 최대 연속 성공 횟수 (DateTime 전용)
  int countLongestSuccessDays() {
    if (T != String) {
      throw ArgumentError('This method only works with String lists');
    }
    if (isEmpty) return 0;

    List<String> dateList = cast<String>();

    int longestStreak = 0;
    int currentStreak = 1;

    for (int i = 1; i < dateList.length; i++) {
      if (dateList[i].toDateTime.difference(dateList[i - 1].toDateTime).inDays == 1) {
        currentStreak++;
      } else {
        longestStreak = max(longestStreak, currentStreak);
        currentStreak = 1;
      }
    }

    longestStreak = max(longestStreak, currentStreak);
    return longestStreak;
  }
}