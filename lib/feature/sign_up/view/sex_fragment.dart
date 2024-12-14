import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/widget_constant.dart';
import '../viewmodel/sign_up_provider.dart';


class SexFragment extends ConsumerWidget  {
  const SexFragment({
    super.key,
    required this.selectedSex,
    required this.onChanged,
  });

  final int? selectedSex;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          '성별을 선택하세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildToggleButton('남성', 0, ref),
            SizedBox(width: 12),
            _buildToggleButton('여성', 1, ref),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, int index, WidgetRef ref) {
    bool isSelected = selectedSex == index;

    return GestureDetector(
      onTap:() {
        onChanged(index);
        ref.read(signUpProvider.notifier).setSex(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
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