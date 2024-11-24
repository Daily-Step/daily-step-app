import 'package:dailystep/widgets/widget_calendar_scroll_picker.dart';
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

  Future<DateTime?> _showDateScrollPicker(BuildContext context) async {
    DateTime? selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        DateTime tempDate = DateTime.now();

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WDateScrollPicker(
                  onDateSelected: (DateTime date) {
                    tempDate = date;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, tempDate),
                        child: Text('확인'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
    return selectedDate;
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
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
        ),
        onTap: () async {
          DateTime? selectedDate = await _showDateScrollPicker(context);
          if(selectedDate == null) return;
          onChanged(selectedDate);
        },
        readOnly: true, // 사용자가 직접 입력하지 않도록 설정
      ),
    );
  }
}
