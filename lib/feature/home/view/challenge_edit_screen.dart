import 'package:flutter/material.dart';

import '../../../widgets/widget_buttons.dart';
import '../../../widgets/widget_scroll_picker.dart';
import '../../../widgets/widget_select_input.dart';

class ChallengeEditScreen extends StatefulWidget {
  const ChallengeEditScreen({Key? key}) : super(key: key);

  @override
  _ChallengeCreationScreenState createState() =>
      _ChallengeCreationScreenState();
}

class _ChallengeCreationScreenState extends State<ChallengeEditScreen> {
  int challengeWeeks = 2;
  int weeklyGoal = 3;
  String selectedCategory = '운동';
  Color selectedColor = Colors.blue;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('주 3회 이상 헬스장 가기'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WSelectInput(
                onTap:()=> _showModal(WScrollPickerModal(value: challengeWeeks, onSelected: (int ) {
                  setState(() {
                    challengeWeeks = int;
                  });
                },)),
                title: '챌린지 기간',
                child: Text(
                  '${challengeWeeks}주 챌린지',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              WSelectInput(
                onTap: () {},
                title: '실천 횟수',
                child: Text(
                  '${challengeWeeks}주 챌린지',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              WSelectInput(
                onTap: () {},
                title: '카테고리',
                child: Text(
                  '${challengeWeeks}주 챌린지',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              WSelectInput(
                onTap: () {},
                title: '컬러',
                child: Text(
                  '${challengeWeeks}주 챌린지',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _buildNoteSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: WCtaButton('수정하기',onPressed: () {  },),
      ),
    );
  }

  void _showModal(Widget child){
    showModalBottomSheet(
        context: context,
        builder: (context) => child);
  }



  Widget _buildGoalSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed:
                weeklyGoal > 1 ? () => setState(() => weeklyGoal--) : null,
          ),
          Expanded(
            child: Center(
              child: Text('주 ${weeklyGoal}회'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:
                weeklyGoal < 7 ? () => setState(() => weeklyGoal++) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('카테고리'),
      trailing: TextButton(
        onPressed: () => _showCategoryModal(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedCategory),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('컬러'),
      trailing: TextButton(
        onPressed: () => _showColorModal(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('기록'),
        const SizedBox(height: 8),
        TextField(
          controller: _noteController,
          maxLength: maxCharacters,
          maxLines: null,
          decoration: InputDecoration(
            hintText: '상세 내용',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            counterText: '${_noteController.text.length}/$maxCharacters자 이내',
          ),
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
      ],
    );
  }

  void _showCategoryModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('카테고리 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: ['운동', '공부', '취미', '생활', '기타']
                  .map(
                    (category) => ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => selectedCategory = category);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorModal() {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('색상 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: colors
                  .map(
                    (color) => GestureDetector(
                      onTap: () {
                        setState(() => selectedColor = color);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: selectedColor == color
                              ? Border.all(color: Colors.black, width: 2)
                              : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
