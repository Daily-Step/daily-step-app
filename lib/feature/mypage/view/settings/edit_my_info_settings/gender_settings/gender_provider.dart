import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderProvider extends StateNotifier<int> {
  GenderProvider() : super(-1);

  void selectGender(int index) {
    state = index;
  }
}

final genderProvider = StateNotifierProvider<GenderProvider, int>((ref) {
  return GenderProvider();
});
