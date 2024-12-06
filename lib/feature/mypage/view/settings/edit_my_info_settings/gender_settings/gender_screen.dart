import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/gender_settings/gender_provider.dart';

class GenderScreen extends ConsumerWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('성별'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/main/myPage/myinfo');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton('남성', 0, selectedGender, ref),
                const SizedBox(width: 12),
                _buildToggleButton('여성', 1, selectedGender, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, int index, int? selectedGender, WidgetRef ref) {
    bool isSelected = selectedGender == index; // 선택된 성별과 비교

    return GestureDetector(
      onTap: () {
        // 상태를 업데이트하도록 수정
        ref.read(genderProvider.notifier).selectGender(isSelected ? -1 : index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white, // 선택된 버튼 색
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
