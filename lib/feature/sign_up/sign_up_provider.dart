import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/route/auth_redirection.dart';

class SignUpState {
  final int step;
  final String? nickName;
  final DateTime? selectedDate;
  final String? selectedSex;

  SignUpState({
    this.step = 0,
    this.nickName,
    this.selectedDate,
    this.selectedSex,
  });

  SignUpState copyWith({
    int? step,
    String? nickName,
    DateTime? selectedDate,
    String? selectedSex,
  }) {
    return SignUpState(
      step: step ?? this.step,
      nickName: nickName ?? this.nickName,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSex: selectedSex ?? this.selectedSex,
    );
  }
}

class SignUpViewModel extends StateNotifier<SignUpState> {
  SignUpViewModel() : super(SignUpState());

  void setNickName(String nickName) {
    state = state.copyWith(nickName: nickName);
  }

  void setBirthDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void setSex(String sex) {
    state = state.copyWith(selectedSex: sex);
  }

  void nextStep() {
    if (state.step < 2) {
      state = state.copyWith(step: state.step + 1);
    }
  }

  VoidCallback? canMoveToNextStep(DailyStepAuth auth, BuildContext context) {
    if (state.step == 0 && state.nickName?.isNotEmpty == true) {
      return nextStep;
    } else if (state.step == 1 && state.selectedDate != null) {
      return nextStep;
    } else if (state.step == 2 && state.selectedSex?.isNotEmpty == true) {
      return () => auth.signUp(context);
    }
    return null;
  }
}

final signUpProvider = StateNotifierProvider<SignUpViewModel, SignUpState>(
      (ref) => SignUpViewModel(),
);
