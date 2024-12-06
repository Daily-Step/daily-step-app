import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthdayState {
  final DateTime birthDate;
  BirthdayState({required this.birthDate});

  BirthdayState copyWith({DateTime? birthDate}) {
    return BirthdayState(
      birthDate: birthDate ?? this.birthDate,
    );
  }
}

class BirthdayProvider extends StateNotifier<BirthdayState> {
  BirthdayProvider() : super(BirthdayState(birthDate: DateTime.now()));

  void updateBirthDate(DateTime newDate) {
    state = state.copyWith(birthDate: newDate);
  }
}

final birthdayProvider = StateNotifierProvider<BirthdayProvider, BirthdayState>(
      (ref) => BirthdayProvider(),
);
