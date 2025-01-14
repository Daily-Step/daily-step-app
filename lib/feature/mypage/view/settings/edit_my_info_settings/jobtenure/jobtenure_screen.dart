import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/jobtenure/jobtenure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common/util/size_util.dart';
import '../../../../../../widgets/widget_constant.dart';
import '../../../../../../widgets/widget_scroll_picker.dart';
import '../../../../../sign_up/view/jobtenure_dummies.dart';

class JobTenureScreen extends ConsumerWidget {
  const JobTenureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 선택된 연차 값 가져오기
    final jobTenure = ref.watch(jobTenureProvider);
    final isDataEntered = ref.watch(isDataEnteredProvider);

    final TextEditingController controller = TextEditingController(
      text: jobTenure != 0 ? dummyJobTenure[jobTenure - 1].name : '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '연차',
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
      body: Padding(
        padding: globalMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              readOnly: true,
              style: WAppFontSize.values(color: WAppColors.black),
              decoration: InputDecoration(
                hintText: '해당하는 연차를 선택하세요.',
                hintStyle: hintTextStyle,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => WScrollPicker(
                      // 현재 선택된 연차 값 설정
                      value: jobTenure,
                      childCount: dummyJobTenure.length,
                      onSelected: (int selectedValue) {
                        // 선택된 값을 jobTenureProvider로 설정
                        ref.read(jobTenureProvider.notifier).selectJobTenure(selectedValue + 1); // +1로 수정
                        controller.text = dummyJobTenure[selectedValue].name;
                      },
                      itemBuilder: (context, index, isSelected) {
                        return Text(
                          dummyJobTenure[index].name,
                          style: TextStyle(fontSize: pickerFontSize),
                        );
                      },
                    ),
                  ),
                ),
                // 아래쪽에만 border 설정
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0 * su, vertical: 16.0 * su),
        child: SizedBox(
          width: double.infinity,
          height: 50.0 * su,
          child: ElevatedButton(
            onPressed: isDataEntered
                ? () async {
              await ref.read(jobTenureProvider.notifier).saveJobTenure();
              context.go('/main/myPage/myinfo');
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDataEntered ? Colors.black : Colors.grey[300],
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
