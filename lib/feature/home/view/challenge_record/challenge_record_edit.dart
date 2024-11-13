import 'dart:io';
import 'dart:math';
import 'package:dailystep/feature/home/view/challenge_record/select_image_source_dialog.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../model/challenge/challenge_model.dart';
import '../../../../model/challenge_record/challenge_record_model.dart';
import '../../../../widgets/widget_buttons.dart';
import '../../action/challenge_list_action.dart';
import '../../action/challenge_record_action.dart';
import '../../viewmodel/challenge_record_viewmodel.dart';
import '../../viewmodel/challenge_viewmodel.dart';

class ChallengeRecordEditScreen extends ConsumerStatefulWidget {
  final int challengeId;

  const ChallengeRecordEditScreen(this.challengeId, {Key? key})
      : super(key: key);

  @override
  _ChallengeRecordScreenState createState() => _ChallengeRecordScreenState();
}

class _ChallengeRecordScreenState
    extends ConsumerState<ChallengeRecordEditScreen> {
  ChallengeModel? selectedChallenge;

  ChallengeRecordModel? selectedRecord;
  final List<String> imageList = [];
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
    final challengeState = ref.watch(challengeViewModelProvider);
    final recordState = ref.watch(challengeRecordViewModelProvider);
    setState(() {
      selectedChallenge =
          challengeState.challengeList.firstWhere((c) =>
          c.id == widget.challengeId);
      //레코드에 해당 챌린지에 대한 기록이 있다면 해당 기록을 패치함
      if (recordState.recordList.any((r) =>
      r.challengeId == widget.challengeId)) {
        selectedRecord =
            recordState.recordList.firstWhere((r) => r.challengeId ==
                widget.challengeId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeNotifier = ref.read(challengeViewModelProvider.notifier);
    final recordNotifier = ref.read(challengeRecordViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(selectedChallenge?.title ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageSelectWidget(
              imageList,
              onTap: () async {
                try {
                  final selectedSource =
                  await SelectImageSourceDialog().show(context);
                  if (selectedSource == null) {
                    return;
                  }
                  final file =
                  await ImagePicker().pickImage(source: selectedSource);
                  if (file == null) {
                    return;
                  }
                  setState(() {
                    imageList.add(file.path);
                  });
                } on PlatformException catch (e) {
                  //TODO: 에러처리 구현
                  // switch(e.code){
                  //   case 'invalid_image':
                  //     MessageDialog('지원하지 않는 이미지 형식입니다').show();
                  // }
                }
              },
              onTapDeleteImage: (imagePath) {
                setState(() {
                  imageList.remove(imagePath);
                });
              },
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
        child: WCtaButton('저장하기', onPressed: () async {
          int random = Random().nextInt(999999);
          DateTime now = DateTime.now();

          final challengeRecord = ChallengeRecordModel(
            id: selectedRecord?.id ?? random,
            challengeId: selectedRecord?.id ?? random,
            createdAt: DateTime.now(),
          );

          List<DateTime> copiedChallengeSuccessList =
          List<DateTime>.from(selectedChallenge!.successList);
          copiedChallengeSuccessList.add(now);

          final challenge = selectedChallenge!
              .copyWith(successList: copiedChallengeSuccessList);
          if (selectedRecord != null) {
            await challengeNotifier
                .handleAction(UpdateTaskAction(challenge.id, challenge));
            recordNotifier.handleAction(
                UpdateRecordAction(challenge.id, challengeRecord));
            Navigator.pop(context);
          } else {
            await challengeNotifier
                .handleAction(UpdateTaskAction(challenge.id, challenge));
            recordNotifier.handleAction(AddRecordAction(challengeRecord));
            Navigator.pop(context);
          }
        }),
      ),
    );
  }
}

class _ImageSelectWidget extends StatelessWidget {
  final List<String> imageList;
  final VoidCallback onTap;
  final void Function(String path) onTapDeleteImage;

  const _ImageSelectWidget(this.imageList,
      {required this.onTap, required this.onTapDeleteImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalMargin,
      child: SizedBox(
        height: 100,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SelectImageButton(onTap: onTap, imageList: imageList),
                ...imageList.map((imagePath) =>
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Stack(children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.fill,
                              )),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                onTapDeleteImage(imagePath);
                              },
                              child: Transform.rotate(
                                angle: pi / 4,
                                child: const Icon(Icons.add_circle),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ))
              ],
            )),
      ),
    );
  }
}

class SelectImageButton extends StatelessWidget {
  const SelectImageButton({
    super.key,
    required this.onTap,
    required this.imageList,
  });

  final VoidCallback onTap;
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: globalBorderRadius,
        ),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
