import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get apiFormattedDate => DateFormat('yyyy-MM-dd').format(this);
  String get formattedDate => DateFormat('yyyy.MM.dd').format(this);
  String get formattedMonth => DateFormat('yyyy.MM').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('yyyy.MM.dd HH:mm').format(this);

  int calculateWeeksBetween(DateTime endDttm) {
    try {
      Duration difference = endDttm.difference(this);
      return (difference.inDays / 7).ceil();
    } catch (e) {
      return -1;
    }
  }

  bool isSameDate(DateTime date){
    return this.year == date.year && this.month == date.month && this.day == date.day;
  }
  bool isSameMonth(DateTime date){
    return this.year == date.year && this.month == date.month;
  }
  List<int> getDaysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return List.generate(lastDay, (index) => index + 1);
  }

  int goalDays(DateTime endDttm, int weeklyGoalCount){
    return calculateWeeksBetween(endDttm) * weeklyGoalCount;
  }

  int failDays(DateTime endDttm, int weeklyGoalCount, int successDayCount){
    return (calculateWeeksBetween(endDttm) * weeklyGoalCount) -  successDayCount;
  }

  int lastDays(){
    final today = DateTime.now();
    Duration difference = this.difference(today);
    return difference.inDays;
  }

  DateTime getStartOfWeek(){
    return this.subtract(Duration(days: this.weekday % 7));
  }

  DateTime getLastDayOfMonth(){
    return DateTime(this.year, this.month + 1, 0);
  }
}
