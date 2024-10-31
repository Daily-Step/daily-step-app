import 'package:dailystep/feature/calendar/model/calendar_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../action/calendar_action.dart';

class CalendarViewModel extends StateNotifier<List<CalendarModel>> with EventMixin<CalendarAction> {
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime.utc(1900, 1, 1);
  DateTime _lastDay = DateTime.utc(2099, 12, 31);

  // 이벤트 캐시
  final Map<DateTime, List<CalendarModel>> _eventCache = {};

  CalendarViewModel() : super([]) {
    handleEvent(LoadDummyDataAction()); // 더미 데이터 로드
  }

  DateTime get focusedDay => _focusedDay;

  DateTime get firstDay => _firstDay;

  DateTime get lastDay => _lastDay;

  @override
  void handleEvent(CalendarAction event) {
    if (event is LoadDummyDataAction) {
      loadDummyData();
    } else if (event is AddEventAction) {
      addEvent(event.event);
    } else if (event is UpdateEventAction) {
      updateEvent(event.oldEvent, event.newEvent);
    } else if (event is ClearEventsAction) {
      clearEvents();
    }
  }

  void loadDummyData() {
    state = [
      CalendarModel(
        title: "챌린지 1",
        progress: 50,
        dateTime: DateTime(2024, 1, 1),
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 11, 10),
      ),
      CalendarModel(
        title: "챌린지 2",
        progress: 20,
        dateTime: DateTime(2024, 1, 11),
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 11, 10),
      ),
      CalendarModel(
        title: "챌린지 3",
        progress: 75,
        dateTime: DateTime(2024, 1, 21),
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 11, 10),
      ),
      CalendarModel(
        title: "챌린지 4",
        progress: 90,
        dateTime: DateTime(2024, 2, 1),
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 11, 10),
      ),
      CalendarModel(
        title: "챌린지 5",
        progress: 40,
        dateTime: DateTime(2024, 2, 11),
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 11, 10),
      ),
    ];
  }

  void updateFocusedDay(DateTime newFocusedDay) {
    if (newFocusedDay.isBefore(_firstDay)) {
      _focusedDay = _firstDay;
    } else if (newFocusedDay.isAfter(_lastDay)) {
      _focusedDay = _lastDay;
    } else {
      _focusedDay = newFocusedDay;
    }
    state = state; // 불필요한 상태 업데이트 방지
  }

  void previousMonth() {
    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
    state = [...state];
  }

  void nextMonth() {
    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
    state = [...state];
  }

  void addEvent(CalendarModel event) {
    state = [...state, event];
  }

  void updateEvent(CalendarModel oldEvent, CalendarModel newEvent) {
    state = [
      for (final e in state)
        if (e == oldEvent) newEvent else e,
    ];
  }

  void clearEvents() {
    state = [];
    _eventCache.clear();
  }

// 특정 날짜의 이벤트를 로드하는 메서드
  List<CalendarModel> loadEventsForDay(DateTime day) {
    if (_eventCache.containsKey(day)) {
      return _eventCache[day]!;
    }

    final eventsForDay = state.where((event) {
      return (day.isAfter(event.startDate) || isSameDay(day, event.startDate)) &&
          (day.isBefore(event.endDate.add(Duration(days: 1))) || isSameDay(day, event.endDate));
    }).toList();

    _eventCache[day] = eventsForDay; // 캐시에 저장
    return eventsForDay;
  }

  // 날짜가 같은지 비교하는 메서드
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  // 상태 업데이트 후 캐시를 갱신하는 메서드
  void _updateEventCache() {
    _eventCache.clear();
  }
}

// 상태 관리에 사용할 프로바이더 정의
final calendarViewModelProvider = StateNotifierProvider<CalendarViewModel, List<CalendarModel>>((ref) {
  return CalendarViewModel();
});
