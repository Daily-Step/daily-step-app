import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/widget_toast.dart';
import '../../../widgets/widget_constant.dart';
import '../../../widgets/wigdet_date_picker.dart';
import '../viewmodel/validation_providers.dart';

class BirthDateFragment extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    if (selectedDate != null) {
      controller.text = _formatDate(selectedDate!);
    }

    ref.listen(birthDateValidationProvider, (previous, next) {
      controller.text = next != null ? _formatDate(next) : '';
    });

    return Column(
      children: [
        Text(
          '생년월일을 입력해 주세요',
          style: WAppFontSize.titleXL(),
        ),
        height20,
        WDatePicker(
          controller: controller,
          onChanged: (DateTime date) {
            if (!_validateDate(date)) {
              // WToast를 사용해 경고 메시지 표시
              WToast.show(
                context,
                "잘못된 날짜 선택",
                subMessage: "오늘 날짜와 선택할 수 없습니다.",
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 50,
                ),
              );
              return;
            }
            onDateSelected(date);
            ref.read(birthDateValidationProvider.notifier).state = date;
          },
          value: selectedDate,
          hintText: '캘린더를 누르면 생년월일을 선택할 수 있어요.',
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  bool _validateDate(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day));
  }
}
