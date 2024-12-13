import 'package:flutter/material.dart';

import '../../../widgets/widget_constant.dart';


class SexFragment extends StatelessWidget {
  const SexFragment({
    super.key,
    required this.selectedSex,
    required this.onChanged,
  });

  final int? selectedSex;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
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
            _buildToggleButton('남성', 0),
            SizedBox(width: 12),
            _buildToggleButton('여성', 1),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, int index) {
    bool isSelected = selectedSex == index;

    return GestureDetector(
      onTap: () => onChanged(index),
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