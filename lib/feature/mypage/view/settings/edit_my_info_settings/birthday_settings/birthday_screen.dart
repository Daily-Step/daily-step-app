import 'package:dailystep/feature/mypage/viewmodel/my_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../widgets/widget_confirm_text.dart';
import '../../../../../../widgets/wigdet_date_picker.dart';
import 'birthday_provider.dart';

class BirthdayScreen extends ConsumerWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthdayState = ref.watch(birthdayProvider);
    final birthdayNotifier = ref.read(birthdayProvider.notifier);


    // 날짜를 포맷팅하여 표시
    final formattedDate = birthdayState.birthDate != null
        ? DateFormat('yyyy.MM.dd').format(birthdayState.birthDate)
        : '';

    final controller = TextEditingController(text: formattedDate);
    final isValid = birthdayState.birthDate != DateTime.now();


    return Scaffold(
      appBar: AppBar(
        title: const Text('생년월일'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/main/myPage/myinfo');
          },
        ),
        actions: [
          WConfirmButton(
            onPressed: () async {
              await birthdayNotifier.saveBirthDay(birthdayState.birthDate);

              context.go('/main/myPage/myinfo');

            },
            isValidProvider: isValid,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WDatePicker(
            onChanged: (selectedDate) {
              birthdayNotifier.updateBirthDate(selectedDate);
            },
            controller: controller,
            value: birthdayState.birthDate,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
