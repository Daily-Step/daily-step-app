import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobTenureProvider extends StateNotifier<int> {
  JobTenureProvider() : super(0);

  void selectJobTenure(int jobTenure) {
    state = jobTenure;
  }
}

final jobTenureProvider = StateNotifierProvider<JobTenureProvider, int>((ref) {
  return JobTenureProvider();
});
