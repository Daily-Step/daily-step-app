import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobProvider extends StateNotifier<int?> {
  JobProvider() : super(null);

  void selectJob(int? job) {
    state = job;
  }

  bool get isDataEntered => state != null;
}

final jobProvider = StateNotifierProvider<JobProvider, int?>((ref) {
  return JobProvider();
});

final isDataEnteredProvider = Provider<bool>((ref) {
  return ref.watch(jobProvider) != null;
});
