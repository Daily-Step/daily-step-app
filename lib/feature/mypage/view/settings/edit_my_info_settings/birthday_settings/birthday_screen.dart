import 'package:dailystep/feature/mypage/viewmodel/my_info_viewmodel.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/util/size_util.dart';
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
        title: Text(
          '생년월일',
          style: WAppFontSize.titleXL(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/main/myPage/myinfo');
          },
        ),
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
          SizedBox(height: 8 * su),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0 * su, vertical: 16.0 * su),
        child: SizedBox(
          width: double.infinity,
          height: 50.0 * su,
          child: ElevatedButton(
            onPressed: isValid
                ? () async {
              await birthdayNotifier.saveBirthDay(birthdayState.birthDate);
              context.go('/main/myPage/myinfo');
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isValid ? WAppColors.black : WAppColors.gray03,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0 * su),
              ),
            ),
            child: Text(
              '저장하기',
              style: WAppFontSize.values(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
