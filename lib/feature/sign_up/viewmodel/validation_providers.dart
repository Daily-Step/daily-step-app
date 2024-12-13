import 'package:dailystep/feature/sign_up/viewmodel/sign_up_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 닉네임 유효성 검증 색상 상태
final nicknameValidationColorProvider = StateProvider<Color>((ref) => Colors.red);

// 닉네임 중복 체크 진행 상태
final isNicknameCheckInProgressProvider = StateProvider<bool>((ref) => false);

final birthDateValidationProvider = StateProvider<DateTime?>((ref) {
  return null;
});

final jobProvider = StateProvider<int?>((ref) => null);
