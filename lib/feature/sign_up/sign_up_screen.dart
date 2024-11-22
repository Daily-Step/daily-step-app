import 'package:dailystep/feature/sign_up/progress_bar.dart';
import 'package:dailystep/feature/sign_up/sign_up_provider.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:dailystep/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/route/auth_redirection.dart';
import '../../widgets/wigdet_date_picker.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  final DailyStepAuth auth;

  const SignUpScreen({super.key, required this.auth});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpViewModel = ref.read(signUpProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: signUpState.step != 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: signUpViewModel.beforeStep,
              )
            : const SizedBox.shrink(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: ProgressStepper(currentStep: signUpState.step),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              height60,
              Center(
                child: buildCheckIcon(true)
              ),
              SizedBox(height: 10),
              if (signUpState.step == 1)
                NickNameField(
                  controller: nickNameController,
                  onChanged: (text) {
                    signUpViewModel.setNickName(text);
                  },
                )
              else if (signUpState.step == 2)
                BirthDateField(
                  controller: birthDateController,
                  selectedDate: signUpState.selectedDate,
                  onDateSelected: (date) {
                    signUpViewModel.setBirthDate(date);
                    birthDateController.text =
                        date.toLocal().toString().split(' ')[0];
                  },
                )
              else if (signUpState.step == 3)
                SexField(
                  selectedSex: signUpState.selectedSex,
                  onChanged: (String? value) {
                    signUpViewModel.setSex(value ?? '');
                  },
                ),
            ],
          ),
          WCtaFloatingButton(
            '다음',
            onPressed: signUpViewModel.canMoveToNextStep(widget.auth, context),
          ),
        ],
      ),
    );
  }

  Widget buildCheckIcon(bool isAvailable) {
    if (!isAvailable) {
      return Icon(
        Icons.check_circle,
        size: 80,
        color: Colors.grey[300],
      );
    }
    return ShaderMask(
      shaderCallback: (Rect bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF7DF6FF),
          Color(0xFF2F41F2),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Icon(
        Icons.check_circle,
        size: 80,
        color: Colors.white,
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
          '사용하실 닉네임을 입력하세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        height30,
        WTextField(
          controller,
          hintText: '사용하실 닉네임을 입력하세요',
          onChanged: onChanged,
          suffixButton: WRoundButton(
            isEnabled: controller.text != '',
            onPressed: () {},
            text: '중복확인',
          ),
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
