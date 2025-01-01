import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dailystep/data/api/api_client.dart';
import '../../../../../../config/secure_storage/secure_storage_provider.dart';
import '../../../../viewmodel/my_info_viewmodel.dart';

class JobTenureProvider extends StateNotifier<int> {
  final Ref ref;

  JobTenureProvider(this.ref)
      : super(
    ref.read(myInfoViewModelProvider).maybeWhen(
      loaded: (user) => user.jobYearId ?? 0, // 서버에서 가져온 연차 값, 기본값 0
      orElse: () => 0,
    ),
  );

  void selectJobTenure(int jobTenure) {
    state = jobTenure;
  }

  Future<void> saveJobTenure() async {
    if (state == 0) return; // 선택되지 않은 경우 반환

    final apiClient = ref.read(apiClientProvider);
    final accessToken = await ref.read(secureStorageServiceProvider).getAccessToken();

    try {
      final response = await apiClient.put(
        'member/jobyear',
        data: {'yearId': state},
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print('연차 저장 성공');
        ref.read(myInfoViewModelProvider.notifier).updateUserJobYear(state);
      } else {
        print('연차 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('연차 저장 중 오류 발생: $e');
    }
  }
}

final jobTenureProvider = StateNotifierProvider<JobTenureProvider, int>((ref) {
  return JobTenureProvider(ref);
});

final isDataEnteredProvider = Provider<bool>((ref) {
  return ref.watch(jobTenureProvider) != 0;
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
