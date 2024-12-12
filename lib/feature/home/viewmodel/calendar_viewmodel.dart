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
      isUserTriggeredPageChange: true,
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
        ? DateTime.now().add(Duration(days: action.addPage!))
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
    state = state.copyWith(
        firstDateOfMonth: newFirstDateOfMonth, isUserTriggeredPageChange: true);
  }

  Future<void> _handleChangeExpandAction(ChangeExpandAction action) async {
    state = state.copyWith(isExpanded: !state.isExpanded);
    if (state.isExpanded) {
      ///week -> month로 전환시
      ///현재 firstDateOfWeek의 month가 현재 month로부터 얼마나 떨어져 있는지 확인한 후 해당 month로 컨트롤러 이동
      ///firstDateOfMonth - currentMonth = -1
      // DateTime firstDateOfMonth =
      //     DateTime(state.firstDateOfWeek.year, state.firstDateOfWeek.month, 1);
      // state = state.copyWith(firstDateOfMonth: firstDateOfMonth);

      ///page [1,2,3,4,5,6]
    } else {
      ///month -> week로 전환시
      ///현재 시간 기준 첫번째 week로부터 selected week가 얼마나 떨어져 있는지 계산 후 해당 week로 컨트롤러 이동
      DateTime currentFirstDateOfWeek = state.firstDateOfWeek;
      DateTime selectedDateOfWeek = state.selectedDate.getStartOfWeek();
      Duration weeksBetween =
          selectedDateOfWeek.difference(currentFirstDateOfWeek);
      int calcWeeks = (weeksBetween.inDays / 7).floor();
      print(currentFirstDateOfWeek);
      print(selectedDateOfWeek);
      print(calcWeeks);

      ///현재 시점을 기준으로 몇페이지나 뒤로 이동 했는지 역산하여 날짜를 계산함
      ///max 페이지를 고정해야 현재 페이지 이후로 이동하지 못하게 막을 수 있음
      ///캘린더 타입을 바꿀 때 역산이 제대로 동작하려면 화면에 렌더링하는 날짜들만 바꿔주는 게 아니라 페이지 컨트롤러 자체를 이동시켜야 함
      ///expanded로 인해 화면이 새로 그려지는 시점에서 컨트롤러를 조작하면 해당 pageView가 생성되기전에 page가 그려져 에러가 나기 때문에
      ///아래와 같이 delayed로 처리함
      Future.delayed(Duration(seconds: 1), () {
        int currentPage = action.controller.page?.round() ?? 0;
        action.controller.jumpToPage(currentPage + calcWeeks);
      });
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
