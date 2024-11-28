import 'package:dailystep/common/extension/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/route/auth_redirection.dart';

class SignUpState {
  final int step;
  final String? nickName;
  final DateTime? birthDate;
  final int? sex;
  final int? job;
  final int? jobTenure;
  final String nickNameValidation;

  SignUpState({
    this.step = 1,
    this.nickName,
    this.birthDate,
    this.sex,
    this.job,
    this.jobTenure,
    this.nickNameValidation = '',
  });

  SignUpState copyWith({
    int? step,
    String? nickName,
    DateTime? selectedDate,
    int? selectedSex,
    int? selectedJob,
    int? selectedJobTenure,
    String? nickNameValidation,
  }) {
    return SignUpState(
      step: step ?? this.step,
      nickName: nickName ?? this.nickName,
      birthDate: selectedDate ?? this.birthDate,
      sex: selectedSex ?? this.sex,
      job: selectedJob ?? this.job,
      jobTenure: selectedJobTenure ?? this.jobTenure,
      nickNameValidation: nickNameValidation ?? this.nickNameValidation,
    );
  }
}

class SignUpViewModel extends StateNotifier<SignUpState> {
  SignUpViewModel() : super(SignUpState());

  void setNickName(String nickName) {
    String nickNameValidation = '';
    if (nickName != '') {
      if (nickName.length < 4 || nickName.length > 10) {
        nickNameValidation = '4자 이상 10자 이내로 입력해 주세요.';
      }
      if (!nickName.nickNameValidation()) {
        nickNameValidation = '한국어, 영어 대소문자, 숫자로만 입력해 주세요.';
      }
    }
    state = state.copyWith(
        nickName: nickName, nickNameValidation: nickNameValidation);
  }

  void setBirthDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void setSex(int sex) {
    state = state.copyWith(selectedSex: sex);
  }

  void setJob(int job) {
    state = state.copyWith(selectedJob: job);
  }

  void setJobTenure(int jobTenure) {
    state = state.copyWith(selectedJobTenure: jobTenure);
  }

  void nextStep() {
    if (state.step < 6) {
      state = state.copyWith(step: state.step + 1);
    }
  }

  void beforeStep() {
    state = state.copyWith(step: state.step - 1);
  }

  VoidCallback? canMoveToNextStep() {
    if (checkValid()) {
      if (state.step != 6) {
        return nextStep;
      }
    }
    return null;
  }

  bool checkValid() {
    if (state.step == 1 && state.nickName?.isNotEmpty == true) {
      if (state.nickNameValidation != '') return false;
      return true;
    } else if (state.step == 2 && state.birthDate != null) {
      return true;
    } else if (state.step == 3 && state.sex != null) {
      return true;
    } else if (state.step == 4 && state.job != null) {
      return true;
    } else if (state.step == 5 && state.jobTenure != null) {
      return true;
    }
    return false;
  }

  VoidCallback saveUserInfo(DailyStepAuth auth, BuildContext context) {
    return () {
      auth.signUp(context);
    };
  }
}

final signUpProvider = StateNotifierProvider<SignUpViewModel, SignUpState>(
  (ref) => SignUpViewModel(),
);
