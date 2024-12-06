import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderProvider extends StateNotifier<int> {
  GenderProvider() : super(-1);

  void selectGender(int index) {
    state = index;
  }

  bool get isDataEntered => state != -1;
}

final genderProvider = StateNotifierProvider<GenderProvider, int>((ref) {
  return GenderProvider();
});

final isDataEnteredProvider = Provider<bool>((ref) {
  return ref.watch(genderProvider) != -1;
});
