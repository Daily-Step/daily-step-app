import 'package:flutter/cupertino.dart';

abstract class CustomCalendarAction {
  const CustomCalendarAction();
}

class ChangeSelectedDateAction extends CustomCalendarAction {
  final PageController controller;
  final int addPage;
  const ChangeSelectedDateAction({required this.controller, required this.addPage});
}

class ChangeFirstDateOfWeekAction extends CustomCalendarAction {
  final int? addPage;

  const ChangeFirstDateOfWeekAction({this.addPage});
}

class ChangeFirstDateOfMonthAction extends CustomCalendarAction {
  final int? addPage;

  const ChangeFirstDateOfMonthAction({this.addPage});
}

class ChangeExpandAction extends CustomCalendarAction {
  final PageController controller;
  const ChangeExpandAction({required this.controller});
}

