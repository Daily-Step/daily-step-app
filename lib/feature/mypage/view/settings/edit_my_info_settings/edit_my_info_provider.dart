import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final nicknameProvider = StateProvider<String>((ref) => '');
final nicknameErrorProvider = StateProvider<String?>((ref) => null);

final birthdayProvider = StateProvider<DateTime?>((ref) => null);
final birthdayTextProvider = StateProvider<String>((ref) => '');

final genderProvider = StateProvider<String>((ref) => '');

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);


// 닉네임 중복 확인 기능
final nicknameDuplicateCheckProvider = FutureProvider.autoDispose<bool>((ref) async {
  final nickname = ref.watch(nicknameProvider);
  
  // 닉네임 중복이 없다고 가정
  return Future.delayed(Duration(seconds: 1), () => true);
});

// 닉네임 입력 시 상태 업데이트 및 유효성 검증 로직
void updateNickname(WidgetRef ref, String value) {
  ref.read(nicknameProvider.notifier).state = value;
  
  // 닉네임 길이 체크 예시
  if (value.length < 3) {
    ref.read(nicknameErrorProvider.notifier).state = '닉네임은 3글자 이상이어야 합니다.';
  } else {
    ref.read(nicknameErrorProvider.notifier).state = null;
  }
}

// 생년월일 선택 시 상태 업데이트
void updateBirthday(WidgetRef ref, DateTime date) {
  ref.read(birthdayProvider.notifier).state = date;
  ref.read(birthdayTextProvider.notifier).state =
      '${date.year}-${date.month}-${date.day}';
}

// 성별 선택 시 상태 업데이트
void updateGender(WidgetRef ref, String gender) {
  ref.read(genderProvider.notifier).state = gender;
}
