import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('yyyy/MM/dd').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('yyyy/MM/dd HH:mm').format(this);
}
