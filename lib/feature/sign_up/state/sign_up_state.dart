import 'package:flutter/material.dart';

class SignUpState {
  final int step;
  final String? nickName;
  final DateTime? birthDate;
  final int? sex;
  final int? job;
  final int? jobTenure;
  final String nickNameValidation;
  final Color? nickNameValidationColor;
  final bool isNicknameCheckInProgress;
  final bool isAvailable;
  final String? accessToken;

  SignUpState({
    this.step = 1,
    this.nickName,
    this.birthDate,
    this.sex,
    this.job,
    this.jobTenure,
    this.nickNameValidation = '',
    this.nickNameValidationColor,
    this.isNicknameCheckInProgress = false,
    this.isAvailable = false,
    this.accessToken,
  });

  SignUpState copyWith({
    int? step,
    String? nickName,
    DateTime? selectedDate,
    int? selectedSex,
    int? selectedJob,
    int? selectedJobTenure,
    String? nickNameValidation,
    Color? nickNameValidationColor,
    bool? isNicknameCheckInProgress,
    bool? isAvailable,
    String? accessToken,
  }) {
    return SignUpState(
      step: step ?? this.step,
      nickName: nickName ?? this.nickName,
      birthDate: selectedDate ?? this.birthDate,
      sex: selectedSex ?? this.sex,
      job: selectedJob ?? this.job,
      jobTenure: selectedJobTenure ?? this.jobTenure,
      nickNameValidation: nickNameValidation ?? this.nickNameValidation,
      nickNameValidationColor: nickNameValidationColor ?? this.nickNameValidationColor,
      isNicknameCheckInProgress: isNicknameCheckInProgress ?? this.isNicknameCheckInProgress,
      isAvailable: isAvailable ?? this.isAvailable,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}