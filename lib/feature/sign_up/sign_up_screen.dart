import 'package:dailystep/common/extension/datetime_extension.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';

import '../../config/auth.dart';
import '../../widgets/wigdet_date_picker.dart';

class SignUpScreen extends StatefulWidget {
  final DailyStepAuth auth;

  const SignUpScreen({super.key, required this.auth});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int steps = 0;
  String? nickName;
  DateTime? selectedDate;
  String? selectedSex;
  TextEditingController nickNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  _signUpCtaAction() {
    if (steps == 0) return () {
      setState(() {
        steps = 1;
      });
    };
    if (steps == 1) return () {
      setState(() {
        steps = 2;
      });
    };
    if (steps == 2) return widget.auth.signUp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.check_circle,
                  size: 100,
                ),
              ),
              height10,
              if (steps == 0)
              NickNameField(
                  controller: nickNameController,
                  onChanged: (text) {
                    nickName = text;
                  })
              else if (steps == 1)
              BirthDateField(
                  controller: birthDateController,
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                      birthDateController.text =
                          date.formattedDate; // 선택한 날짜를 텍스트 필드에 표시
                    });
                  })
              else if (steps == 2)
              SexField(
                selectedSex: selectedSex,
                onChanged: (String? value) {
                  setState(() {
                    selectedSex = value;
                  });
                },
              )
            ],
          ),
          // Buttons
          WCtaFloatingButton('입력완료', onPressed: _signUpCtaAction() ),
        ],
      ),
    );
  }
}

class NickNameField extends StatelessWidget {
  const NickNameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '닉네임을 입력해 주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height30,
        WTextField(
          controller,
          hintText: '닉네임을 입력해 주세요',
          onChanged: onChanged,
        )
      ],
    );
  }
}

class BirthDateField extends StatelessWidget {
  const BirthDateField({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final TextEditingController controller;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '생년월일을 입력해 주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height20,
        WDatePicker(
          controller: controller,
          onChanged: onDateSelected,
          value: selectedDate,
        ),
      ],
    );
  }
}

class SexField extends StatelessWidget {
  const SexField({
    super.key,
    required this.selectedSex,
    required this.onChanged,
  });

  final String? selectedSex;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '성별을 입력해 주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height20,
        ListTile(
          title: const Text('남성'),
          leading: Radio<String>(
            value: 'M',
            groupValue: selectedSex, // 현재 선택된 값을 지정
            onChanged: onChanged, // 값이 변경될 때 호출
          ),
        ),
        ListTile(
          title: const Text('여성'),
          leading: Radio<String>(
            value: 'F',
            groupValue: selectedSex,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
