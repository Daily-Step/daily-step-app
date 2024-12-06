import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobProvider extends StateNotifier<int?> {
  JobProvider() : super(null);

  void selectJob(int? job) {
    state = job;
  }
}

final jobProvider = StateNotifierProvider<JobProvider, int?>((ref) {
  return JobProvider();
});
