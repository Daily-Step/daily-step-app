import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/model/category/category_dummies.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/custom_color/custom_color_dummies.dart';
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

  // 에러 상태
  Map<String, bool> errors = {
    'title': false,
    'challengeWeeks': false,
    'weeklyGoal': false,
    'category': false,
    'color': false,
  };

  //컨트롤러
  final TextEditingController titleController = TextEditingController();
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
      print(state.selectedTask.toString());
      if (state.selectedTask != null) {
        setState(() {
          titleController.text = state.selectedTask!.title;
          challengeWeeks = state.selectedTask!.startDatetime
              .calculateWeeksBetween(state.selectedTask!.endDatetime);
          weeklyGoal = state.selectedTask!.weeklyGoalCount;
          selectedCategory = state.selectedTask!.categoryId;
          selectedColor = state.selectedTask!.color;
          _noteController.text = state.selectedTask!.content;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WTextField(
              titleController,
              hintText: '제목을 입력해주세요',
              label: '제목',
              onChanged: (String value) {},
              hasError: errors['title']!,
              errorMessage: '제목을 입력해주세요',
            ),
            height20,
            WSelectInput(
              onTap: () => _showModal(WScrollPickerModal(
                value: challengeWeeks != null ? challengeWeeks! : 1,
                subText: '주',
                childCount: 4,
                onSelected: (int) {
                  setState(() {
                    challengeWeeks = int + 1;
                  });
                },
              )),
              label: '챌린지 기간',
              child: challengeWeeks != null
                  ? Text(
                      '${challengeWeeks}주 챌린지',
                      style: contentTextStyle,
                    )
                  : Text(
                      '몇주동안 챌린지를 할지 입력하세요',
                      style: hintTextStyle,
                    ),
              hasError: errors['challengeWeeks']!,
              errorMessage: '챌린지 기간을 선택해주세요',
            ),
            height20,
            WSelectInput(
              onTap: () => _showModal(WScrollPickerModal(
                value: weeklyGoal != null ? weeklyGoal! : 1,
                subText: '회',
                childCount: 7,
                onSelected: (int) {
                  setState(() {
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
                      '챌린지를 한주에 몇회 실천할지 입력하세요',
                      style: hintTextStyle,
                    ),
              hasError: errors['weeklyGoal']!,
              errorMessage: '실천 횟수를 선택해주세요',
            ),
            height20,
            WSelectInput(
              onTap: () => _showModal(WScrollPickerModal(
                value: selectedCategory != null ? selectedCategory! : 1,
                childCount: dummyCategories.length,
                childList: dummyCategories.map((item) => item.title).toList(),
                onSelected: (int) {
                  setState(() {
                    selectedCategory = int;
                  });
                },
              )),
              label: '카테고리',
              child: selectedCategory != null
                  ? Text(
                      dummyCategories[selectedCategory!].title,
                      style: contentTextStyle,
                    )
                  : Text(
                      '카테고리를 입력하세요',
                      style: hintTextStyle,
                    ),
              hasError: errors['category']!,
              errorMessage: '카테고리를 선택해주세요',
            ),
            height20,
            WSelectInput(
              onTap: () => _showModal(WScrollPickerModal(
                  value: selectedColor != null ? selectedColor! : 1,
                  childCount: customColors.length,
                  childList: customColors,
                  onSelected: (int) {
                    setState(() {
                      selectedColor = int;
                    });
                  },
                  itemBuilder: (context, index, bool) {
                    return Row(
                      children: [
                        customColors[index].widget,
                      ],
                    );
                  })),
              label: '컬러',
              child: selectedColor != null
                  ? customColors[selectedColor!].widget
                  : Text(
                      '색상을 입력하세요',
                      style: hintTextStyle,
                    ),
              hasError: errors['color']!,
              errorMessage: '색상을 선택해주세요',
            ),
            height20,
            WTextField(
              _noteController,
              label: '메모',
              maxCharacters: maxCharacters,
              counterText: '${_noteController.text.length}/$maxCharacters자 이내',
              hintText: '챌린지에 대한 상세 내용을 입력하세요',
              onChanged: (text) {
                final lines = text.split('\n');
                final modifiedLines = lines.map((line) {
                  if (line.isEmpty) return line;
                  if (!line.startsWith('• ')) return '• $line';
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
        child: WCtaButton('수정하기', onPressed: (){
          if(_validateInputs == true){
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
      errors['title'] = titleController.text.isEmpty;
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
