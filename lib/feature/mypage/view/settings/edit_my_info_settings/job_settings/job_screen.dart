import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/job_settings/job_provider.dart';

import '../../../../../../widgets/widget_confirm_text.dart';
import '../../../../../../widgets/widget_constant.dart';
import '../../../../../sign_up/view/job_dummies.dart';

class JobScreen extends ConsumerWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedJob = ref.watch(jobProvider);
    final isDataEntered = ref.watch(isDataEnteredProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '직무',
          style: TextStyle(fontSize: 25),
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
              await ref.read(jobProvider.notifier).saveJob();
              context.go('/main/myPage/myinfo');
            },
            isValidProvider: isDataEntered,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: jobCategories.map((jobItem) {
                    final isSelected = selectedJob == int.parse(jobItem.id); // 선택된 직업 확인
                    return Container(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.black : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected ? Colors.black : Colors.grey[300]!,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onPressed: () {
                          // 직업을 선택했을 때 jobProvider의 상태를 업데이트
                          ref.read(jobProvider.notifier).selectJob(int.parse(jobItem.id));
                        },
                        child: Text(
                          jobItem.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : subTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
