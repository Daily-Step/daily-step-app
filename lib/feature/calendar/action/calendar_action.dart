import 'package:dailystep/feature/calendar/model/calendar_model.dart';

abstract class CalendarAction {}

class AddEventAction extends CalendarAction {
  final CalendarModel event;
  AddEventAction(this.event);
}

class UpdateEventAction extends CalendarAction {
  final CalendarModel oldEvent;
  final CalendarModel newEvent;
  UpdateEventAction(this.oldEvent, this.newEvent);
}