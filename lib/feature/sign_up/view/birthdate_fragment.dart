import 'package:flutter/cupertino.dart';

import '../../../widgets/widget_constant.dart';
import '../../../widgets/wigdet_date_picker.dart';

class BirthDateFragment extends StatelessWidget {
  const BirthDateFragment({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final TextEditingController controller;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '생년월일을 입력해 주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height20,
        WDatePicker(
          controller: controller,
          onChanged: onDateSelected,
          value: selectedDate,
        ),
      ],
    );
  }
}