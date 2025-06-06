import 'package:dailystep/widgets/widget_calendar_scroll_picker.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

import '../common/util/size_util.dart';

class WDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final ValueChanged<DateTime> onChanged;
  final DateTime? value;

  WDatePicker({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  Future<void> _showDateScrollPicker(BuildContext context) async {
    DateTime selectedDate = value ?? DateTime.now(); // 초기값 설정

    await showModalBottomSheet<DateTime>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20 * su)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WDateScrollPicker(
                  onDateSelected: (DateTime date) {
                    selectedDate = date; // 선택된 날짜 업데이트
                    controller.text = _formatDate(selectedDate); // 텍스트 필드 업데이트
                    onChanged(selectedDate); // 상태 갱신
                    setModalState(() {}); // 모달 내 상태 갱신
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0 * su),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: WAppFontSize.values(color: WAppColors.black),
          hintText: hintText,
          hintStyle: WAppFontSize.values(),
          suffixIcon: const Icon(Icons.calendar_today),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
        ),
        onTap: () async {
          // 날짜 선택 모달 표시
          await _showDateScrollPicker(context);
        },
        readOnly: true, // 사용자가 직접 입력할 수 없도록 설정
      ),
    );
  }
}
