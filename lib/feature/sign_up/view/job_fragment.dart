import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/util/size_util.dart';
import '../../../widgets/widget_constant.dart';
import '../viewmodel/sign_up_provider.dart';
import 'job_dummies.dart';

class JobFragment extends ConsumerWidget {
  const JobFragment({
    super.key,
    required this.job,
    required this.onChanged,
  });

  final int? job;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0 * su),
        child: Column(
          children: [
            Text(
              '직업/직무를 선택해 주세요',
              style: WAppFontSize.titleXL()
            ),
            height5,
            Text(
              '직무는 하나만 선택 가능합니다.',
              style: WAppFontSize.values()
            ),
            height30,
            SizedBox(
              height: 400 * su,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8 * su,
                  runSpacing: 8 * su,
                  children: jobCategories.map((jobItem) {
                    final isSelected = job == int.parse(jobItem.id);
                    return Container(
                      height: 40 * su,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.black : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16 * su),
                            side: BorderSide(
                              color: isSelected ? Colors.black : Colors.grey[300]!,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16 * su),
                        ),
                        onPressed: () {
                          final signUpViewModel = ref.read(signUpProvider.notifier);
                          signUpViewModel.setJob(int.parse(jobItem.id));
                        },
                        child: Text(
                          jobItem.name,
                          style: WAppFontSize.labelL1(color: isSelected ? Colors.white : subTextColor,)
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
