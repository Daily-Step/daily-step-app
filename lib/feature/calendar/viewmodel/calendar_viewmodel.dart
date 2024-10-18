import 'package:dailystep/feature/calendar/action/calendar_action.dart';
import 'package:dailystep/feature/calendar/model/calendar_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarViewModel extends StateNotifier<List<CalendarModel>> {
  CalendarViewModel() : super([]);

  void handleAction(CalendarAction action) {
    if (action is AddEventAction) {
      _addEvent(action.event);
    } else if (action is UpdateEventAction) {
      _updateEvent(action.oldEvent, action.newEvent);
    } else if (action is ClearSelectionEvent) {
      _clearEvents();
    }
  }

  void _addEvent(CalendarModel event) {
    state = [...state, event];
  }

  void _updateEvent(CalendarModel oldEvent, CalendarModel newEvent) {
    state = [
      for (final e in state)
        if (e == oldEvent) newEvent else e,
    ];
  }

  void _clearEvents() {
    state = [];
  }
}

final calendarViewModelProvider =
    StateNotifierProvider<CalendarViewModel, List<CalendarModel>>((ref) {
  return CalendarViewModel();
});
