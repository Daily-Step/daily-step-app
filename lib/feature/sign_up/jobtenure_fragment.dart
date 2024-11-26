import 'package:dailystep/widgets/widget_scroll_picker.dart';
import 'package:flutter/material.dart';

import '../../widgets/widget_constant.dart';
import '../../widgets/widget_select_input.dart';
import 'jobtenure_dummies.dart';

class JobTenureFragment extends StatelessWidget {
  const JobTenureFragment({
    super.key,
    required this.jobTenure,
    required this.onChanged,
  });

  final int? jobTenure;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '연차를 선택해 주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height5,
        Text(
          '없다면 1년 미만을 입력해 주세요',
          style: TextStyle(fontSize: 12, color: subTextColor),
        ),
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
                      onChanged(int + 1);
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
                    style: contentTextStyle,
                  )
                : Text(
                    '선택',
                    style: hintTextStyle,
                  ),
          ),
        ),
      ],
    );
  }
}
