abstract class CustomCalendarAction {
  const CustomCalendarAction();
}

class ChangeSelectedDateAction extends CustomCalendarAction {
  final DateTime selectedDate;
  const ChangeSelectedDateAction({required this.selectedDate});
}

class ChangeFirstDateOfWeekAction extends CustomCalendarAction {
  final int? addPage;

  const ChangeFirstDateOfWeekAction({this.addPage});
}