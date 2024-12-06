import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobTenureProvider extends StateNotifier<int> {
  JobTenureProvider() : super(0);

  void selectJobTenure(int jobTenure) {
    state = jobTenure;
  }

  bool get isDataEntered => state != 0; // 연차가 선택되지 않았다면 false
}

final isDataEnteredProvider = StateProvider<bool>((ref) {
  return ref.watch(jobTenureProvider) != 0;
});

final jobTenureProvider = StateNotifierProvider<JobTenureProvider, int>((ref) {
  return JobTenureProvider();
});
