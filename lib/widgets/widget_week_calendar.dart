import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/home/calendar_day_container.dart';
import 'package:dailystep/widgets/widget_constant.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.weekPageController.hasClients) {
        widget.weekPageController.jumpToPage(WEEK_START_PAGE); // 특정 페이지로 이동
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(challengeViewModelProvider.notifier);

    return PageView.builder(
      controller: widget.weekPageController,
      onPageChanged: (page) {
        notifier.handleAction(ChangeFirstDateOfWeekAction(
          addPage: page - WEEK_START_PAGE ,
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

    return state.when(
        data: (data) {
          List<DateTime> weekDays = _getWeekDays(data.firstDateOfWeek);
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
                  final isSelected = date.isSameDate(data.selectedDate);
                  final isToday = date.isSameDate(DateTime.now());
                  final isSuccess = successDates
                      .any((successDate) => successDate.isSameDate(date));

                  Color containerColor = Colors.transparent;
                  Color textColor = WAppColors.black;
/*                  if(isSuccess){
                    containerColor = WAppColors.secondary;
                    textColor = WAppColors.white;
                  }*/
                  if(isToday){
                    containerColor = WAppColors.gray04;
                    textColor = WAppColors.black;
                  }
                  if(isSelected){
                    containerColor = WAppColors.black;
                    textColor = WAppColors.white;
                  }

                  return InkWell(
                    onTap: () {
                      notifier.handleAction(ChangeSelectedDateAction(
                        selectedDate: date,
                      ));
                    },
                    child: CalendarDayContainer(
                      containerColor: containerColor,
                      textColor: textColor,
                      date: date,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  );
                },
              ),
            ),
          ]);
        },
        error: (Object error, StackTrace stackTrace) => SizedBox(),
        loading: () => SizedBox());
  }
}
