import 'package:dailystep/feature/sign_up/birthdate_fragment.dart';
import 'package:dailystep/feature/sign_up/job_fragment.dart';
import 'package:dailystep/feature/sign_up/jobtenure_fragment.dart';
import 'package:dailystep/feature/sign_up/nickname_fragment.dart';
import 'package:dailystep/feature/sign_up/progress_bar.dart';
import 'package:dailystep/feature/sign_up/sex_fragment.dart';
import 'package:dailystep/feature/sign_up/sign_up_provider.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/route/auth_redirection.dart';
import 'end_fragment.dart';

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
                  child: buildCheckIcon(
                      signUpState.step == 6, signUpViewModel.checkValid())),
              SizedBox(height: 10),
              if (signUpState.step == 1)
                NickNameFragment(
                  controller: nickNameController,
                  onChanged: (text) {
                    signUpViewModel.setNickName(text);
                  },
                  validation: signUpState.nickNameValidation,
                )
              else if (signUpState.step == 2)
                BirthDateFragment(
                  controller: birthDateController,
                  selectedDate: signUpState.birthDate,
                  onDateSelected: (date) {
                    print(date);
                    signUpViewModel.setBirthDate(date);
                    birthDateController.text =
                        date.toLocal().toString().split(' ')[0];
                  },
                )
              else if (signUpState.step == 3)
                SexFragment(
                  selectedSex: signUpState.sex,
                  onChanged: (int? value) {
                    if (value == null) return;
                    signUpViewModel.setSex(value);
                  },
                )
              else if (signUpState.step == 4)
                JobFragment(
                  job: signUpState.job,
                  onChanged: (int? value) {
                    if (value == null) return;
                    signUpViewModel.setJob(value);
                  },
                )
              else if (signUpState.step == 5)
                JobTenureFragment(
                  jobTenure: signUpState.jobTenure,
                  onChanged: (int? value) {
                    print('value: ' + value.toString());
                    if (value == null) return;
                    signUpViewModel.setJobTenure(value);
                  },
                )
              else if (signUpState.step == 6)
                EndFragment()
            ],
          ),
          WCtaFloatingButton(
            signUpState.step == 6 ? '시작하기' : '다음',
            onPressed: signUpState.step == 6
                ? signUpViewModel.saveUserInfo(widget.auth,context)
                : signUpViewModel.canMoveToNextStep(),
            gradient: signUpState.step == 6 ? mainGradient : null,
          ),
        ],
      ),
    );
  }

  Widget buildCheckIcon(bool isLastPage, bool isAvailable) {
    if (isLastPage) {
      return SvgPicture.asset(
        'assets/logo.svg',
        width: 80,
        height: 80,
        allowDrawingOutsideViewBox: true,
        cacheColorFilter: false,
      );
    }
    if (!isAvailable) {
      return Icon(
        Icons.check_circle,
        size: 80,
        color: Colors.grey[300],
      );
    }
    return ShaderMask(
      shaderCallback: (Rect bounds) => mainGradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Icon(
        Icons.check_circle,
        size: 80,
        color: Colors.white,
      ),
    );
  }
}
