import 'package:dailystep/config/secure_storage/secure_storage_provider.dart';
import 'package:dailystep/data/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../viewmodel/my_info_viewmodel.dart';

class BirthdayState {
  final DateTime birthDate;
  final String? validationMessage; // 유효성 메시지 추가

  BirthdayState({
    required this.birthDate,
    this.validationMessage,
  });

  BirthdayState copyWith({DateTime? birthDate, String? validationMessage}) {
    return BirthdayState(
      birthDate: birthDate ?? this.birthDate,
      validationMessage: validationMessage,
    );
  }
}

class BirthdayProvider extends StateNotifier<BirthdayState> {
  final Ref ref;

  BirthdayProvider(this.ref, DateTime initialDate)
      : super(BirthdayState(
    birthDate: initialDate,
  ));
  // 생일 저장 메서드 (PUT 요청)
  Future<void> saveBirthDay(DateTime birth) async {
    try {
      final apiClient = ref.read(apiClientProvider);

      // SecureStorage에서 Access Token 가져오기
      final accessToken = await ref.read(secureStorageServiceProvider).getAccessToken();
      if (accessToken == null) {
        throw Exception('Access Token이 없습니다. 다시 로그인하세요.');
      }

      final formattedBirth = DateFormat('yyyy-MM-dd').format(birth);

      // PUT 요청
      final response = await apiClient.put(
        'member/birth',
        data: {'birth': formattedBirth},
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print('생일 저장 성공');
        // 상태 업데이트 (성공 메시지)
        state = state.copyWith(validationMessage: '생일이 성공적으로 저장되었습니다.');
        ref.read(myInfoViewModelProvider.notifier).updateUserBirth(birth);

      } else {
        print('생일 저장 실패: ${response.statusCode}');
        state = state.copyWith(validationMessage: '저장 실패. 다시 시도해주세요.');
      }
    } catch (e) {
      print('생일 저장 중 오류: $e');
      state = state.copyWith(validationMessage: '저장 중 오류 발생. 다시 시도해주세요.');
    }
  }

  // 생일 업데이트 메서드
  void updateBirthDate(DateTime newDate) {
    state = state.copyWith(birthDate: newDate);
  }
}

// StateNotifierProvider 정의
final birthdayProvider = StateNotifierProvider.autoDispose<BirthdayProvider, BirthdayState>(
      (ref) {
    final initialDate = ref.read(myInfoViewModelProvider).maybeWhen(
      loaded: (user) => user.birth,
      orElse: () => DateTime.now(),
    );
    return BirthdayProvider(ref, initialDate!);
  },
);
// ApiClient Provider 정의 (필요시 사용)
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
