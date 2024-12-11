import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../action/calendar_action.dart';

part 'calendar_viewmodel.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  CalendarState build() {
    return CalendarState(
      isExpanded: false,
      firstDateOfWeek: DateTime.now().getStartOfWeek(),
      firstDateOfMonth: DateTime(DateTime.now().year, DateTime.now().month, 1),
      selectedDate: DateTime.now(),
      isUserTriggeredPageChange: false,
      isBeforePage: true,
    );
  }

  Future<void> handleAction(CustomCalendarAction action) async {
    if (action is ChangeSelectedDateAction) {
      _handleChangeSelectedDate(action);
    } else if (action is ChangeFirstDateOfWeekAction) {
      _handleChangeFirstDateOfWeekAction(action);
    } else if (action is ChangeFirstDateOfMonthAction) {
      _handleChangeFirstDateOfMonthAction(action);
    } else if (action is ChangeExpandAction) {
      await _handleChangeExpandAction(action);
    }
  }

  void _handleChangeSelectedDate(ChangeSelectedDateAction action) {
    DateTime newSelectedDate =
        DateTime.now().add(Duration(days: action.addPage));
    state = state.copyWith(selectedDate: newSelectedDate);

    DateTime firstDateOfRange =
        state.isExpanded ? state.firstDateOfMonth : state.firstDateOfWeek;
    int currentPage = action.controller.page?.round() ?? 0;

    ///현재 페이지가 달력 첫날짜 이전에 있을 때 페이지를 수정함
    if (newSelectedDate.isBefore(firstDateOfRange)) {
      state = state.copyWith(isUserTriggeredPageChange: false);
      state = state.copyWith(isBeforePage: true);
      action.controller.jumpToPage(currentPage - 1);
    }

    ///현재 페이지가 달력 마지막 날짜 이후에 있을 때 페이지를 수정함
    DateTime lastDateOfRange = state.isExpanded
        ? firstDateOfRange.getLastDayOfMonth()
        : firstDateOfRange.add(Duration(days: 6));
    if (newSelectedDate.isAfter(lastDateOfRange)) {
      state = state.copyWith(isUserTriggeredPageChange: false);
      state = state.copyWith(isBeforePage: false);
      action.controller.jumpToPage(currentPage + 1);
    }
  }

  void _handleChangeFirstDateOfWeekAction(ChangeFirstDateOfWeekAction action) {
    DateTime newFirstDateOfWeek = state.isUserTriggeredPageChange
        ? state.selectedDate.add(Duration(days: action.addPage!))
        : state.selectedDate.add(Duration(days: state.isBeforePage ? -1 : 1));
    state = state.copyWith(
        firstDateOfWeek: newFirstDateOfWeek.getStartOfWeek(),
        isUserTriggeredPageChange: true);
  }

  void _handleChangeFirstDateOfMonthAction(
      ChangeFirstDateOfMonthAction action) {
    DateTime newFirstDateOfMonth = state.isUserTriggeredPageChange
        ? DateTime(
            DateTime.now().year, DateTime.now().month + action.addPage!, 1)
        : DateTime(state.selectedDate.year, state.selectedDate.month, 1);
    state = state.copyWith(firstDateOfMonth: newFirstDateOfMonth);
  }

  Future<void> _handleChangeExpandAction(ChangeExpandAction action) async {
    state = state.copyWith(isExpanded: action.isExpanded);
    if(action.isExpanded){
      DateTime firstDateOfMonth = DateTime(state.firstDateOfWeek.year, state.firstDateOfWeek.month, 1);
      state = state.copyWith(firstDateOfMonth: firstDateOfMonth);
    } else {
      DateTime firstDateOfWeek = state.selectedDate.getStartOfWeek();
      state = state.copyWith(firstDateOfWeek: firstDateOfWeek);
    }
  }

}

class CalendarState {
  final bool isExpanded;
  final DateTime firstDateOfWeek;
  final DateTime firstDateOfMonth;
  final DateTime selectedDate;
  final bool isUserTriggeredPageChange;
  final bool isBeforePage;

  const CalendarState({
    required this.isExpanded,
    required this.firstDateOfWeek,
    required this.firstDateOfMonth,
    required this.selectedDate,
    required this.isUserTriggeredPageChange,
    required this.isBeforePage,
  });

  CalendarState copyWith({
    bool? isExpanded,
    DateTime? firstDateOfWeek,
    DateTime? firstDateOfMonth,
    DateTime? selectedDate,
    bool? isUserTriggeredPageChange,
    bool? isBeforePage,
  }) {
    return CalendarState(
      isExpanded: isExpanded ?? this.isExpanded,
      firstDateOfWeek: firstDateOfWeek ?? this.firstDateOfWeek,
      firstDateOfMonth: firstDateOfMonth ?? this.firstDateOfMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      isUserTriggeredPageChange:
          isUserTriggeredPageChange ?? this.isUserTriggeredPageChange,
      isBeforePage: isBeforePage ?? this.isBeforePage,
    );
  }
}
