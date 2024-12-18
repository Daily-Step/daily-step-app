import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/home/calendar_day_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../feature/home/action/challenge_list_action.dart';
import '../feature/home/view/home/calendar_label.dart';
import '../feature/home/view/home/home_fragment.dart';
import '../feature/home/viewmodel/challenge_viewmodel.dart';

class WWeekPageView extends ConsumerStatefulWidget {
  final PageController weekPageController;
  final List<DateTime> successList;

  const WWeekPageView({
    super.key,
    required this.weekPageController,
    required this.successList,
  });

  @override
  _WWeekPageViewState createState() => _WWeekPageViewState();
}

class _WWeekPageViewState extends ConsumerState<WWeekPageView> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(challengeViewModelProvider.notifier);

    return PageView.builder(
      controller: widget.weekPageController,
      onPageChanged: (page) {
        notifier.handleAction(ChangeFirstDateOfWeekAction(
          addPage: page - WEEK_TOTAL_PAGE,
        ));
      },
      itemCount: WEEK_TOTAL_PAGE + 1,
      itemBuilder: (context, index) {
        return WWeekCalendar(
          successDates: widget.successList,
        );
      },
    );
  }
}

class WWeekCalendar extends ConsumerWidget {
  final List<DateTime> successDates;

  WWeekCalendar({
    super.key,
    required this.successDates,
  });

  List<DateTime> _getWeekDays(DateTime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeViewModelProvider);
    final notifier = ref.read(challengeViewModelProvider.notifier);
    List<DateTime> weekDays = _getWeekDays(state.firstDateOfWeek);


    return Column(children: [
      CalendarLabel(),
      SizedBox(height: 4),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 20,
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            final date = weekDays[index];
            final isSelected = date.isSameDate(state.selectedDate);
            final isCurrentPeriod = date.isSameMonth(state.firstDateOfWeek) &&
                date.isBefore(DateTime.now());;
            final isSuccess = successDates
                .any((successDate) => successDate.isSameDate(date));

            return InkWell(
              onTap: (){
                if(date.isAfter(DateTime.now())){
                  return;
                }
                notifier.handleAction(ChangeSelectedDateAction(
                  selectedDate: date,
                ));
              },
              child: CalendarDayContainer(
                isSelected: isSelected,
                isSuccess: isSuccess,
                date: date,
                isCurrentPeriod: isCurrentPeriod,
              ),
            );
          },
        ),
      )
    ]);
  }
}
