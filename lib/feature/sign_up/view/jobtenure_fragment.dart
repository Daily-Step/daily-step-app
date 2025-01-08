import 'package:dailystep/widgets/widget_scroll_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/widget_constant.dart';
import '../../../widgets/widget_select_input.dart';
import '../viewmodel/sign_up_provider.dart';
import 'jobtenure_dummies.dart';

class JobTenureFragment extends ConsumerWidget {
  const JobTenureFragment({
    super.key,
    required this.jobTenure,
    required this.onChanged,
  });

  final int? jobTenure;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          '연차를 선택해 주세요',
          style: WAppFontSize.titleXL(),
        ),
        height5,
        height20,
        Padding(
          padding: globalMargin,
          child: WSelectInput(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => WScrollPicker(
                    value: jobTenure != null ? jobTenure! : 1,
                    childCount: dummyJobTenure.length,
                    onSelected: (int) {
                      ref.read(signUpProvider.notifier).setJobTenure(int+1);
                    },
                    itemBuilder: (context, index, bool) {
                      return Text(
                        dummyJobTenure[index].name,
                        style: TextStyle(fontSize: pickerFontSize),
                      );
                    })),
            child: jobTenure != null
                ? Text(
                    dummyJobTenure[jobTenure!-1].name,
                    style: WAppFontSize.values(color: WAppColors.black),
                  )
                : Text(
                    '해당하는 연차를 선택하세요',
                    style: WAppFontSize.values(),
                  ),
          ),
        ),
      ],
    );
  }
}
