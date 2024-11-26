
import 'dart:math';

extension ListExtension<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(T value, int index) f) {
    return asMap().entries.map((entry) => f(entry.value, entry.key));
  }

  // 최대 연속 성공 횟수 (DateTime 전용)
  int countLongestSuccessDays() {
    if (T != DateTime) {
      throw ArgumentError('This method only works with DateTime lists');
    }
    if (isEmpty) return 0;

    List<DateTime> dateList = cast<DateTime>();

    int longestStreak = 0;
    int currentStreak = 1;

    for (int i = 1; i < dateList.length; i++) {
      if (dateList[i].difference(dateList[i - 1]).inDays == 1) {
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