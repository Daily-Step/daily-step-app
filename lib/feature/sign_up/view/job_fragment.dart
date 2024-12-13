import 'package:flutter/material.dart';

import '../../../widgets/widget_constant.dart';
import 'job_dummies.dart';

class JobFragment extends StatelessWidget {
  const JobFragment({
    super.key,
    required this.job,
    required this.onChanged,
  });

  final int? job;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '직업/직무를 입력해 주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height5,
        Text(
          '없다면 희망 직업/직무를 입력해 주세요',
          style: TextStyle(fontSize: 12, color: subTextColor),
        ),
        height20,
        SizedBox(
          height: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: jobCategories.map((jobItem) {
                  final isSelected = job == int.parse(jobItem.id);
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
                        onChanged(int.parse(jobItem.id));
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
      ],
    );
  }
}
