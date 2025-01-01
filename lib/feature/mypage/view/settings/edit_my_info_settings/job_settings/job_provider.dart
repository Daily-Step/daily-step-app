import 'package:dailystep/feature/mypage/viewmodel/my_info_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dailystep/data/api/api_client.dart';

import '../../../../../../config/secure_storage/secure_storage_provider.dart';

class JobProvider extends StateNotifier<int?> {
  final Ref ref;

  JobProvider(this.ref)
      : super(
    ref.read(myInfoViewModelProvider).maybeWhen(
      loaded: (user) => user.jobId,
      orElse: () => null,
    ),
  );

  void selectJob(int? job) {
    state = job;
  }

  Future<void> saveJob() async {
    if (state == null) return; // 직무가 선택되지 않은 경우 반환

    final apiClient = ref.read(apiClientProvider);
    final accessToken = await ref.read(secureStorageServiceProvider).getAccessToken();

    try {
      final response = await apiClient.put(
        'member/job',
        data: {'jobId': state},
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print('직무 저장 성공');
        ref.read(myInfoViewModelProvider.notifier).updateUserJob(state!);
      } else {
        print('직무 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('직무 저장 중 오류 발생: $e');
    }
  }

  bool get isDataEntered => state != null;
}

final jobProvider = StateNotifierProvider<JobProvider, int?>((ref) {
  return JobProvider(ref);
});

final isDataEnteredProvider = Provider<bool>((ref) {
  return ref.watch(jobProvider) != null;
});
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
