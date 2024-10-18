import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WDatePicker extends StatelessWidget {
  final TextEditingController controller;

  final String? label;
  final String? hintText;
  final ValueChanged<DateTime> onChanged;
  final DateTime? value;

  WDatePicker(
      {Key? key,
      required this.controller,
      this.label,
      this.hintText,
      required this.onChanged,
      required this.value})
      : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('ko'),
    );
    if (picked != null) {
      onChanged(picked); // 선택된 날짜 전달
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalMargin,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label ?? null,
          hintText: hintText ?? null,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDate(context);
        },
        readOnly: true, // 사용자가 직접 입력하지 않도록 설정
      ),
    );
  }
}
