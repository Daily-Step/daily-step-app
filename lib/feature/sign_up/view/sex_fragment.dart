import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/util/size_util.dart';
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
        Text(
          '성별을 선택하세요',
          style: WAppFontSize.titleXL()
        ),
        height20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildToggleButton('남성', 0, ref),
            SizedBox(width: 12 * su),
            _buildToggleButton('여성', 1, ref),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, int index, WidgetRef ref) {
    bool isSelected = selectedSex == index;

    return GestureDetector(
      onTap: () {
        onChanged(index);
        ref.read(signUpProvider.notifier).setSex(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40 * su, vertical: 12 * su),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8 * su),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: WAppFontSize.labelL1(
            color: isSelected ? Colors.white : WAppColors.gray05, // 선택에 따라 색상 변경
          ),
        ),
      ),
    );
  }
}