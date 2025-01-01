import 'dart:ffi';

import 'package:dailystep/config/secure_storage/secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../viewmodel/my_info_viewmodel.dart';

class GenderState {
  final String? selectedGender;

  GenderState({this.selectedGender});

  GenderState copyWith({String? selectedGender}) {
    return GenderState(
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }
}

class GenderProvider extends StateNotifier<GenderState> {
  final Ref ref;

  GenderProvider(this.ref)
      : super(GenderState(
    selectedGender: ref.read(myInfoViewModelProvider).maybeWhen(
      loaded: (user) => user.gender,
      orElse: () => null,
    ),
  ));

  void selectGender(String? gender) {
    state = state.copyWith(selectedGender: gender);
  }

  Future<void> saveGender() async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final accessToken =
      await ref.read(secureStorageServiceProvider).getAccessToken();

      if (accessToken == null) {
        throw Exception('Access Token이 없습니다.');
      }

      final response = await apiClient.put(
        'member/gender',
        data: {'gender': state.selectedGender}, // Replace with your API format
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        ref.read(myInfoViewModelProvider.notifier).updateUserGender(state.selectedGender!);
        print('성별 저장 성공');
      } else {
        throw Exception('저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('성별 저장 중 오류: $e');
    }
  }
}

final genderProvider =
StateNotifierProvider<GenderProvider, GenderState>((ref) => GenderProvider(ref));

final isDataEnteredProvider = Provider<bool>((ref) {
  final genderState = ref.watch(genderProvider);
  return genderState.selectedGender != null;
});
