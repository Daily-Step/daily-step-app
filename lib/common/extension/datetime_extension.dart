import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get apiFormattedDate => DateFormat('yyyy-MM-dd').format(this);
  String get formattedDate => DateFormat('yyyy.MM.dd').format(this);
  String get formattedMonth => DateFormat('yyyy.MM').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('yyyy.MM.dd HH:mm').format(this);

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

  int lastDays(){
    final today = DateTime.now();
    Duration difference = this.difference(today);
    int result = difference.inDays;
    if(result < 0) return 0;
    return result;
  }

  DateTime getStartOfWeek(){
    return this.subtract(Duration(days: this.weekday % 7));
  }

  DateTime getLastDayOfMonth(){
    return DateTime(this.year, this.month + 1, 0);
  }
}
