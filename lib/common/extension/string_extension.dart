extension StringExtension on String {
  DateTime get toDateTime => DateTime.parse(this);
}