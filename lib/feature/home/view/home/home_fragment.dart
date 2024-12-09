import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/challenge/challenge_dummies.dart';
import '../../../../widgets/widget_constant.dart';
import '../../../../widgets/widget_month_calendar.dart';
import '../../../../widgets/widget_week_calendar.dart';
import 'challenge_empty.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'challenge_list.dart';

const int DAY_TOTAL_PAGE = 180;
const int WEEK_TOTAL_PAGE = 26;
const int MONTH_TOTAL_PAGE = 6;

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool _isExpanded = false;
  DateTime firstDateOfRange = DateTime.now().getStartOfWeek();
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  final PageController weekPageController =
      PageController(initialPage: WEEK_TOTAL_PAGE);
  final PageController monthPageController =
      PageController(initialPage: MONTH_TOTAL_PAGE);

  @override
  void dispose() {
    weekPageController.dispose();
    monthPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(challengeViewModelProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  firstDateOfRange.formattedMonth,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(_isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  onPressed: () => setState(() {
                    _isExpanded = !_isExpanded;
                    firstDateOfRange = _isExpanded
                        ? DateTime(selectedDate.year, selectedDate.month, 1)
                        : selectedDate.getStartOfWeek();
                    print(firstDateOfRange);
                  }),
                ),
              ]),
              Spacer(),
              CircleAvatar(
                backgroundColor: Color(0xff2257FF),
                child: Text(
                  '🥰',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _isExpanded ? 240 : 80,
          curve: Curves.easeInOut,
          child: _isExpanded
              ? WMonthPageView(
                  monthPageController: monthPageController,
                  successList: dummySuccessList,
                  firstDateOfRange: firstDateOfRange,
                  onPageChanged: (page) {
                    setState(() {
                      firstDateOfRange = DateTime(selectedDate.year,
                          selectedDate.month + (page - MONTH_TOTAL_PAGE), 1);
                    });
                  },
                )
              : WWeekPageView(
                  weekPageController: weekPageController,
                  successList: dummySuccessList,
                  firstDateOfRange: firstDateOfRange,
                  selectedDate: selectedDate,
                  onPageChanged: (page) {
                    setState(() {
                      firstDateOfRange = selectedDate
                          .add(Duration(days: (page - WEEK_TOTAL_PAGE) * 7))
                          .getStartOfWeek();
                    });
                  },
                ),
        ),
        height20,
        state.challengeList.length == 0
            ? ChallengeEmpty()
            : Expanded(
                child: ChallengeListPageView(
                  onPageChanged: (page) {
                    setState(() {
                      selectedDate = currentDate
                          .add(Duration(days: page - DAY_TOTAL_PAGE));

                      ///현재 페이지가 달력 첫날짜 이전에 있을 때 페이지를 수정함
                      if (selectedDate.isBefore(firstDateOfRange)) {
                        if (_isExpanded) {
                          int currentPage =
                              monthPageController.page?.round() ?? 0;
                          monthPageController.jumpToPage(currentPage - 1);
                        } else {
                          int currentPage =
                              weekPageController.page?.round() ?? 0;
                          weekPageController.jumpToPage(currentPage - 1);
                        }
                        print('back');
                        return;
                      }

                      ///현재 페이지가 달력 마지막 날짜 이후에 있을 때 페이지를 수정함
                      ///TODO: 앞으로 갈때 달력 변동 버그 수정
                      DateTime lastDateOfRange = _isExpanded
                          ? firstDateOfRange.getLastDayOfMonth()
                          : firstDateOfRange.add(Duration(days: 6));
                      print(lastDateOfRange);
                      // if (selectedDate.isAfter(lastDateOfRange)) {
                      //   if (_isExpanded) {
                      //     int currentPage =
                      //         monthPageController.page?.round() ?? 0;
                      //     monthPageController.jumpToPage(currentPage + 1);
                      //   } else {
                      //     int currentPage =
                      //         weekPageController.page?.round() ?? 0;
                      //     weekPageController.jumpToPage(currentPage + 1);
                      //   }
                      //   print('after');
                      // }
                    });
                  },
                ),
              ),
      ],
    );
  }
}
