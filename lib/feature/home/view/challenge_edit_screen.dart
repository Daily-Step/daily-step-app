import 'dart:math';

import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/feature/home/view/settings/category_dummies.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/challenge/challenge_model.dart';
import '../../../widgets/widget_confirm_modal.dart';
import '../action/challenge_list_action.dart';
import 'settings/custom_color_dummies.dart';
import '../../../widgets/widget_buttons.dart';
import '../../../widgets/widget_scroll_picker.dart';
import '../../../widgets/widget_select_input.dart';
import '../viewmodel/challenge_viewmodel.dart';

class ChallengeEditScreen extends ConsumerStatefulWidget {
  final int? id;

  const ChallengeEditScreen(int? this.id, {Key? key}) : super(key: key);

  @override
  _ChallengeCreationScreenState createState() =>
      _ChallengeCreationScreenState();
}

class _ChallengeCreationScreenState extends ConsumerState<ChallengeEditScreen> {
  int? challengeWeeks;
  int? weeklyGoal;
  int? selectedCategory;
  int? selectedColor;
  ChallengeModel? selectedChallenge;

  // 에러 상태
  Map<String, bool> errors = {
    'title': false,
    'challengeWeeks': false,
    'weeklyGoal': false,
    'category': false,
    'color': false,
  };

  //컨트롤러
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final int maxCharacters = 500;

  @override
  void initState() {
    super.initState();
    _noteController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  void _initializeData() async {
    if (widget.id != null) {
      final state = ref.watch(challengeViewModelProvider);
      if (state.selectedTask != null) {
        setState(() {
          selectedChallenge = state.selectedTask;
          _titleController.text = state.selectedTask!.title;
          challengeWeeks = state.selectedTask!.startDatetime
              .calculateWeeksBetween(state.selectedTask!.endDatetime);
          weeklyGoal = state.selectedTask!.weeklyGoalCount;
          selectedCategory = state.selectedTask!.categoryId;
          selectedColor = state.selectedTask!.colorId;
          _noteController.text = state.selectedTask!.content;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(challengeViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id != null ? '챌린지 수정' : '새로운 챌린지 추가',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height20,
            WTextField(
              controller: _titleController,
              hintText: '챌린지 이름을 입력하세요',
              label: '챌린지 이름',
              onChanged: (String value) {
                if(value != '') {
                  setState(() {
                    errors['title'] = false;
                  });
                }
              },
              isEnable: !errors['title']!,
              errorMessage: '챌린지 이름을 입력하세요',
            ),
            height20,
            WSelectInputWithLabel(
              onTap: () => _showModal(WScrollPicker(
                value: challengeWeeks != null ? challengeWeeks! : 1,
                subText: '주',
                childCount: 4,
                onSelected: (int) {
                  setState(() {
                    errors['challengeWeeks'] = false;
                    challengeWeeks = int + 1;
                  });
                },
              )),
              label: '챌린지 기간',
              child: challengeWeeks != null
                  ? Text(
                      '${challengeWeeks}주',
                      style: contentTextStyle,
                    )
                  : Text(
                      '선택',
                      style: hintTextStyle,
                    ),
              hasError: errors['challengeWeeks']!,
              errorMessage: '챌린지 기간을 선택해주세요',
            ),
            height20,
            WSelectInputWithLabel(
              onTap: () => _showModal(WScrollPicker(
                value: weeklyGoal != null ? weeklyGoal! : 1,
                subText: '회',
                childCount: 7,
                onSelected: (int) {
                  setState(() {
                    errors['weeklyGoal'] = false;
                    weeklyGoal = int + 1;
                  });
                },
              )),
              label: '실천 횟수',
              child: weeklyGoal != null
                  ? Text(
                      '주 ${weeklyGoal} 회',
                      style: contentTextStyle,
                    )
                  : Text(
                      '선택',
                      style: hintTextStyle,
                    ),
              hasError: errors['weeklyGoal']!,
              errorMessage: '실천 횟수를 선택해주세요',
            ),
            height20,
            WSelectInputWithLabel(
              onTap: () => _showModal(WScrollPicker(
                value: selectedCategory != null ? selectedCategory! : 1,
                childCount: dummyCategories.length,
                childList:
                    dummyCategories.map((item) => item.toString()).toList(),
                onSelected: (int) {
                  setState(() {
                    errors['category'] = false;
                    selectedCategory = int;
                  });
                },
              )),
              label: '카테고리',
              child: selectedCategory != null
                  ? Text(
                      dummyCategories[selectedCategory!].toString(),
                      style: contentTextStyle,
                    )
                  : Text(
                      '선택',
                      style: hintTextStyle,
                    ),
              hasError: errors['category']!,
              errorMessage: '카테고리를 선택해주세요',
            ),
            height20,
            WSelectInputWithLabel(
              onTap: () => _showModal(WScrollPicker(
                  value: selectedColor != null ? selectedColor! : 1,
                  childCount: customColors.length,
                  childList: customColors,
                  onSelected: (int) {
                    setState(() {
                      errors['color'] = false;
                      selectedColor = int;
                    });
                  },
                  itemBuilder: (context, index, bool) {
                    return customColors[index].widget;
                  })),
              label: '컬러',
              child: selectedColor != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: customColors[selectedColor!].widget,
                       )
                  : Text(
                      '선택',
                      style: hintTextStyle,
                    ),
              hasError: errors['color']!,
              errorMessage: '색상을 선택해주세요',
            ),
            height30,
            WTextField(
              controller: _noteController,
              label: '상세 내용',
              maxCharacters: maxCharacters,
              maxLines: 5,
              counterText: '${_noteController.text.length}/$maxCharacters자 이내',
              hintText: '챌린지에 대한 상세 내용을 입력하세요',
              isBox: true,
              onChanged: (text) {
                final lines = text.split('\n');
                final modifiedLines = lines.map((line) {
                  if (line.isEmpty) return line;
                  return line;
                }).join('\n');

                if (modifiedLines != text) {
                  _noteController.value = TextEditingValue(
                    text: modifiedLines,
                    selection:
                        TextSelection.collapsed(offset: modifiedLines.length),
                  );
                }
              },
            ),
            height30,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: WCtaButton('저장하기', onPressed: () {
          if (_validateInputs() == true) {
            final Duration challengeDays = Duration(days: challengeWeeks! * 7);
            Random random = Random();
            final challenge = ChallengeModel(
              id: widget.id ?? random.nextInt(999999),
              memberId: 0,
              categoryId: selectedCategory!,
              title: _titleController.text,
              content: _noteController.text,
              colorId: selectedColor!,
              weeklyGoalCount: weeklyGoal!,
              totalGoalCount: weeklyGoal! * challengeWeeks!,
              startDatetime: selectedChallenge?.startDatetime ?? DateTime.now(),
              endDatetime:
                  selectedChallenge?.startDatetime.add(challengeDays) ??
                      DateTime.now().add(challengeDays),
              createdAt: selectedChallenge?.createdAt ?? DateTime.now(),
              updatedAt: DateTime.now(),
              successList: selectedChallenge?.successList ?? [],
            );
            if (widget.id != null) {
              notifier.handleAction(UpdateTaskAction(widget.id, challenge));
              Navigator.pop(context);
              context.push('/main/home/${widget.id}');
            } else {
              notifier.handleAction(AddTaskAction(challenge));
              showConfirmModal(context: context,
                  content: Column(
                    children: [
                      Text('챌린지 등록이 완료되었습니다', style: boldTextStyle,),
                      height5,
                      Text(
                        '닫기버튼을 누르면 홈으로 이동합니다',
                        style: subTextStyle,
                      )
                    ],
                  ),
                  confirmText: '닫기',
                  onClickConfirm: (){
                    Navigator.pop(context);
                  },
                  isCancelButton: false);
            }
          }
        }),
      ),
    );
  }

  void _showModal(Widget child) {
    showModalBottomSheet(context: context, builder: (context) => child);
  }

  bool _validateInputs() {
    setState(() {
      errors['title'] = _titleController.text.isEmpty;
      errors['challengeWeeks'] = challengeWeeks == null;
      errors['weeklyGoal'] = weeklyGoal == null;
      errors['category'] = selectedCategory == null;
      errors['color'] = selectedColor == null;
    });
    if (!errors.values.contains(true)) {
      return true;
    }
    return false;
  }
}
