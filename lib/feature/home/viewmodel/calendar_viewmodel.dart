import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../action/calendar_action.dart';

part 'calendar_viewmodel.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  CalendarState build() {
    return CalendarState(
      firstDateOfWeek: DateTime.now().getStartOfWeek(),
      firstDateOfMonth: DateTime(DateTime.now().year, DateTime.now().month, 1),
      selectedDate: DateTime.now(),
    );
  }

  Future<void> handleAction(CustomCalendarAction action) async {
    if (action is ChangeSelectedDateAction) {
      _handleChangeSelectedDate(action);
    } else if (action is ChangeFirstDateOfWeekAction) {
      _handleChangeFirstDateOfWeekAction(action);
    }
  }

  void _handleChangeSelectedDate(ChangeSelectedDateAction action) {
    state = state.copyWith(selectedDate: action.selectedDate);
  }

  void _handleChangeFirstDateOfWeekAction(ChangeFirstDateOfWeekAction action) {
    DateTime newFirstDateOfWeek = DateTime.now().add(Duration(days: action.addPage!));
    int daysOff = state.selectedDate.difference(state.firstDateOfWeek).inDays - 1;
    DateTime newSelectedDate = newFirstDateOfWeek.add(Duration(days: daysOff));
    if(newSelectedDate.isAfter(DateTime.now())){
      newSelectedDate = DateTime.now();
    }
    state = state.copyWith(
        firstDateOfWeek: newFirstDateOfWeek.getStartOfWeek(),
        selectedDate: newSelectedDate
    );
  }
}

class CalendarState {
  final DateTime firstDateOfWeek;
  final DateTime firstDateOfMonth;
  final DateTime selectedDate;

  const CalendarState({
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
  });

  CalendarState copyWith({
    DateTime? firstDateOfWeek,
    DateTime? firstDateOfMonth,
    DateTime? selectedDate,
  }) {
    return CalendarState(
      firstDateOfWeek: firstDateOfWeek ?? this.firstDateOfWeek,
      firstDateOfMonth: firstDateOfMonth ?? this.firstDateOfMonth,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
