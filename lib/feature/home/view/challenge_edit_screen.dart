import 'package:dailystep/feature/home/view/settings/toast_msg.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/util/size_util.dart';
import '../../../model/challenge/challenge_model.dart';
import '../../../widgets/widget_confirm_modal.dart';
import '../../../widgets/widget_toast.dart';
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

  Color textColor() => widget.id != null ? disabledColor : Colors.grey.shade600;

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
      state.whenData((data) {
        if (data.selectedChallenge != null) {
          setState(() {
            selectedChallenge = data.selectedChallenge;
            _titleController.text = data.selectedChallenge!.title;
            challengeWeeks = data.selectedChallenge!.durationInWeeks;
            weeklyGoal = data.selectedChallenge!.weekGoalCount;
            selectedCategory = data.selectedChallenge!.category.id - 1;
            selectedColor = customColors
                .firstWhere((el) => el.code == data.selectedChallenge!.color)
                .id;
            _noteController.text = data.selectedChallenge!.content;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(challengeViewModelProvider.notifier);
    final state = ref.watch(challengeViewModelProvider);

    return state.when(
        data: (data) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.id != null ? '챌린지 수정' : '새 챌린지 추가하기',
                style: WAppFontSize.titleXL(),
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
                    hintStyle: hintTextStyle,
                    label: '챌린지 이름',
                    onChanged: (String value) {
                      if (value != '') {
                        setState(() {
                          errors['title'] = false;
                        });
                      }
                    },
                    isEnable: !errors['title']!,
                    errorMessage: '챌린지 이름을 입력하세요',
                    suffixButton: SvgPicture.asset(
                      'assets/icons/pencil.svg',
                      width: 10 * su,
                      height: 10 * su,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  height20,
                  WSelectInputWithLabel(
                    onTap: () => _showModal(WScrollPicker(
                      value: challengeWeeks != null ? challengeWeeks! - 1 : 1,
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
                    disabled: widget.id != null,
                  ),
                  height20,
                  WSelectInputWithLabel(
                    onTap: () => _showModal(WScrollPicker(
                      value: weeklyGoal != null ? weeklyGoal! - 1 : 1,
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
                    disabled: widget.id != null,
                  ),
                  height20,
                  WSelectInputWithLabel(
                    onTap: () => _showModal(WScrollPicker(
                      value: selectedCategory != null ? selectedCategory! : 1,
                      childCount: data.categories.length,
                      childList:
                          data.categories.map((item) => item.name).toList(),
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
                            data.categories[selectedCategory!].name,
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
                          return customColors[index]
                              .getWidget(selectedColor ?? -1, index);
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
                    counterText:
                        '${_noteController.text.length}/$maxCharacters자 이내',
                    hintText: '챌린지에 대한 상세 내용을 입력하세요',
                    hintStyle: hintTextStyle,
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
                          selection: TextSelection.collapsed(
                              offset: modifiedLines.length),
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
                  if (widget.id != null) {
                    final newChallenge = {
                      "title": _titleController.text,
                      "categoryId": selectedCategory! + 1,
                      "color": customColors[selectedColor!].code.toString(),
                      "content": _noteController.text
                    };
                    notifier.handleAction(
                        UpdateChallengeAction(widget.id, newChallenge));
                    Navigator.pop(context);
                    context.push('/main/home/${widget.id}');
                  } else {
                    final newChallenge = {
                      "title": _titleController.text,
                      "durationInWeeks": challengeWeeks!,
                      "weeklyGoalCount": weeklyGoal!,
                      "categoryId": selectedCategory! + 1,
                      "color": customColors[selectedColor!].code.toString(),
                      "content": _noteController.text
                    };
                    notifier.handleAction(AddChallengeAction(newChallenge, context));
                  }
                }
              }),
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) => SizedBox(),
        loading: () => SizedBox());
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
