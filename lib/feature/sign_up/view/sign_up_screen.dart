import 'package:dailystep/config/secure_storage/secure_storage_provider.dart';
import 'package:dailystep/feature/sign_up/view/birthdate_fragment.dart';
import 'package:dailystep/feature/sign_up/view/job_fragment.dart';
import 'package:dailystep/feature/sign_up/view/jobtenure_fragment.dart';
import 'package:dailystep/feature/sign_up/view/nickname_fragment.dart';
import 'package:dailystep/feature/sign_up/view/progress_bar.dart';
import 'package:dailystep/feature/sign_up/viewmodel/sign_up_provider.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../common/util/size_util.dart';
import '../../../config/route/auth_redirection.dart';
import 'end_fragment.dart';
import 'sex_fragment.dart';

class SignUpScreen extends ConsumerWidget {
  final DailyStepAuth auth;
  final String? accessToken;

  const SignUpScreen({super.key, required this.auth, this.accessToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpViewModel = ref.read(signUpProvider.notifier);

    final TextEditingController controller = TextEditingController(text: signUpState.nickName ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (accessToken != null && signUpState.accessToken == null) {
        print('📢 회원가입 화면에서 받은 accessToken: $accessToken');
        signUpViewModel.setAccessToken(accessToken!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: signUpState.step != 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: signUpViewModel.beforeStep,
              )
            : const SizedBox.shrink(),
        actions: [
          // "건너뛰기" 버튼
          if (signUpState.step == 4 || signUpState.step == 5)
            TextButton(
              onPressed: () {
                ref.read(signUpProvider.notifier).nextStep(); // 다음 단계로 이동
              },
              child: Text(
                '건너뛰기',
                style: WAppFontSize.titleL(color: WAppColors.gray03)
              ),
            ),
        ],
        bottom: signUpState.step != 6 // 마지막 단계에서는 ProgressStepper 숨기기
            ? PreferredSize(
                preferredSize: Size.fromHeight(24 * su),
                child: ProgressStepper(
                  currentStep: signUpState.step,
                ),
              )
            : null,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 100 * su,),
              Center(
                child: buildCheckIcon(
                  signUpState.step == 6,
                  signUpViewModel.checkValid(),
                ),
              ),
              SizedBox(height: 10 * su),
              if (signUpState.step == 1)
                NickNameFragment(
                  controller: controller,
                  onChanged: (text) {
                    signUpViewModel.setNickName(text, ref);
                  },
                  onCheckNickname: () {
                    signUpViewModel.checkNicknameAvailability(controller.text, ref);
                  },
                  validation: signUpState.nickNameValidation,
                  validationColor: signUpState.nickNameValidationColor ?? Colors.red,
                  isNicknameCheckInProgress: signUpState.isNicknameCheckInProgress,
                )
              else if (signUpState.step == 2)
                BirthDateFragment(
                  controller: TextEditingController(),
                  selectedDate: signUpState.birthDate,
                  onDateSelected: (date) {
                    signUpViewModel.setBirthDate(date);
                  },
                )
              else if (signUpState.step == 3)
                SexFragment(
                  selectedSex: signUpState.sex,
                  onChanged: (int? value) {
                    if (value != null) {
                      signUpViewModel.setSex(value);
                    }
                  },
                )
              else if (signUpState.step == 4)
                JobFragment(
                  job: signUpState.job,
                  onChanged: (int? value) {
                    if (value != null) {
                      signUpViewModel.setJob(value);
                    }
                  },
                )
              else if (signUpState.step == 5)
                JobTenureFragment(
                  jobTenure: signUpState.jobTenure,
                  onChanged: (int? value) {
                    if (value != null) {
                      signUpViewModel.setJobTenure(value);
                    }
                  },
                )
              else if (signUpState.step == 6)
                const EndFragment(),
            ],
          ),
          WCtaFloatingButton(
            signUpState.step == 6 ? '시작하기' : '다음',
            onPressed: signUpState.step == 6
                ? () async {
                    final accessToken = signUpState.accessToken;
                    print('AccessToken: $accessToken');

                    if (accessToken != null) {
                      await signUpViewModel.saveUserInfo(accessToken, context); // 데이터 서버로 전송
                      auth.completeSignUp(context); // /main/home 경로로 이동
                    } else {
                      print("AccessToken이 없습니다.");
                    }
                  }
                : (signUpState.isNicknameCheckInProgress || !signUpViewModel.checkValid() ? null : signUpViewModel.nextStep),
            gradient: signUpState.step == 6 ? mainGradient : null,
          )
        ],
      ),
    );
  }

  Widget buildCheckIcon(bool isLastPage, bool isAvailable) {
    if (isLastPage) {
      return Column(
        children: [
          SizedBox(height: 150 * su),
          SvgPicture.asset(
            'assets/logo.svg',
            width: 80 * su,
            height: 80 * su,
            allowDrawingOutsideViewBox: true,
            cacheColorFilter: false,
          ),
        ],
      );
    }

    if (!isAvailable) {
      print('isAvailable $isAvailable');
      return Stack(
        alignment: Alignment.center,
        children: [
          // 원형 배경
          Container(
            width: 64 * su, // 원 크기
            height: 64 * su,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200], // 배경색
            ),
          ),
          // SVG 아이콘
          SvgPicture.asset(
            'assets/icons/check.svg', // SVG 경로
            width: 30 * su, // 아이콘 크기
            height: 30 * su,
            color: Colors.grey[300], // SVG 색상
          ),
        ],
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // 원형 배경
        Container(
          width: 64 * su, // 원 크기
          height: 64 * su,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: mainGradient, // 메인 그라데이션 배경
          ),
        ),
        // SVG 아이콘
        SvgPicture.asset(
          'assets/icons/check.svg', // SVG 경로
          width: 34 * su, // 아이콘 크기
          height: 34 * su,
          color: Colors.white, // SVG 색상
        ),
      ],
    );
  }
}
