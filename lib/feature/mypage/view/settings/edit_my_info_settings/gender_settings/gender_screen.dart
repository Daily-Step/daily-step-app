import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/gender_settings/gender_provider.dart';

import '../../../../../../widgets/widget_confirm_text.dart';

class GenderScreen extends ConsumerWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genderState = ref.watch(genderProvider);
    final isDataEntered = ref.watch(isDataEnteredProvider);
    final genderNotifier = ref.read(genderProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          '성별',
          style: WAppFontSize.titleXL(),
        ),
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
              await genderNotifier.saveGender();

              context.go('/main/myPage/myinfo');
            },
            isValidProvider: isDataEntered,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0 * su),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildToggleButton('남성', 'MALE', genderState.selectedGender, ref),
                SizedBox(width: 12 * su),
                _buildToggleButton('여성', 'FEMALE', genderState.selectedGender, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, String value, String? selectedGender, WidgetRef ref) {
    bool isSelected = selectedGender == value;

    return GestureDetector(
      onTap: () {
        // 상태를 업데이트하도록 수정
        ref.read(genderProvider.notifier).selectGender(isSelected ? null : value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40 * su, vertical: 12 * su),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white, // 선택된 버튼 색
          borderRadius: BorderRadius.circular(16 * su),
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
