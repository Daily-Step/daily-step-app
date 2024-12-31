import 'package:dailystep/config/secure_storage/secure_storage_provider.dart';
import 'package:dailystep/data/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../sign_up/repository/nickname_repository.dart';
import '../../../../viewmodel/my_info_viewmodel.dart';

class NickNameState {
  final String nickName;
  final bool isValid;
  final TextEditingController controller;
  final String validationMessage;  // 유효성 검사 메시지
  final Color validationColor;  // 유효성 검사 색상

  NickNameState({
    required this.nickName,
    required this.isValid,
    required this.controller,
    required this.validationMessage,
    required this.validationColor,
  });

  NickNameState copyWith({
    String? nickName,
    bool? isValid,
    TextEditingController? controller,
    String? validationMessage,
    Color? validationColor,
  }) {
    return NickNameState(
      nickName: nickName ?? this.nickName,
      isValid: isValid ?? this.isValid,
      controller: controller ?? this.controller,
      validationMessage: validationMessage ?? this.validationMessage,
      validationColor: validationColor ?? this.validationColor,
    );
  }
}

class NickNameProvider extends StateNotifier<NickNameState> {
  final NicknameRepository _nicknameRepository = NicknameRepository();

  NickNameProvider(this.ref, String initialNickname)
      : super(
    NickNameState(
      nickName: initialNickname,
      isValid: initialNickname.isNotEmpty && initialNickname.length >= 4 && initialNickname.length <= 10,
      controller: TextEditingController(text: initialNickname),
      validationMessage: '',
      validationColor: Colors.red,
    ),
  ) {
    state.controller.addListener(_onTextChanged);
  }

  final Ref ref;

  void _onTextChanged() {
    updateNickName(state.controller.text);
  }

  bool _validateNickName(String nickName) {
    if (nickName.length < 4 || nickName.length > 10) {
      return false;
    }
    // 추가적인 유효성 검사(예: 문자와 숫자만 허용)
    return true;
  }

  void updateNickName(String nickName) {
    String validationMessage = '';
    Color validationColor = Colors.red;

    // 닉네임 유효성 검사
    if (nickName.isEmpty) {
      validationMessage = '닉네임을 입력해 주세요.';
    } else if (nickName.length < 4 || nickName.length > 10) {
      validationMessage = '4자 이상 10자 이내로 입력해 주세요.';
    }


    state = state.copyWith(nickName: nickName, validationMessage: validationMessage, validationColor: validationColor);

    // 유효성 검사 후 상태 업데이트
    bool isValid = _validateNickName(nickName);
    if (nickName != state.nickName || isValid != state.isValid) {
      state = state.copyWith(nickName: nickName, isValid: isValid);
      ref.read(isNickNameValidProvider.notifier).state = isValid;
    }
  }

  // 중복 확인 메서드
  Future<void> checkNicknameDuplication(String nickName) async {
    try {
      // NicknameRepository에서 결과를 받아 처리
      final result = await _nicknameRepository.checkNickname(nickName);

      print('닉네임 중복 확인 결과: ${result.isSuccess ? "성공" : "실패"}');

      String resultMessage;
      Color resultColor;

      if (result.isSuccess) {
        resultMessage = '사용 가능한 닉네임입니다. :)';
        resultColor = Colors.blue;
      } else if (result.failureData?.statusCode == 400) {
        // 서버에서 반환된 메시지 처리
        final errorMessage = result.failureData?.message ?? '이미 사용 중인 닉네임입니다.';
        resultMessage = errorMessage;
        resultColor = Colors.red;
      } else {
        // 기타 오류 처리
        resultMessage = '서버 오류. 다시 시도해주세요.';
        resultColor = Colors.red;
      }

      // 상태 업데이트
      state = state.copyWith(validationMessage: resultMessage, validationColor: resultColor);
    } catch (e) {
      // 네트워크 오류 또는 예외 처리
      String resultMessage = '네트워크 오류. 다시 시도해주세요.';
      Color resultColor = Colors.red;

      if (e is DioException && e.response?.statusCode == 400) {
        final errorMessage = e.response?.data['message'] ?? '이미 사용 중인 닉네임입니다.';
        resultMessage = errorMessage;
      }

      // 상태 업데이트
      state = state.copyWith(validationMessage: resultMessage, validationColor: resultColor);
    } finally {
      print('닉네임 중복 확인 완료');
    }
  }

  // 저장 메서드 (PUT 요청)
  Future<void> saveNickName(String nickName) async {
    try {
      final apiClient = ApiClient();

      final accessToken = await ref.read(secureStorageServiceProvider).getAccessToken();
      if (accessToken == null) {
        throw Exception('Access Token이 없습니다. 다시 로그인하세요.');
      }

      final response = await apiClient.put(
        'member/nickname',
        data: {'nickname': nickName},
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print('닉네임 저장 성공');
        ref.read(myInfoViewModelProvider.notifier).updateNickname(nickName);
      } else {
        state = state.copyWith(validationMessage: '저장 실패. 다시 시도해주세요.', validationColor: Colors.red);
      }
    } catch (e) {
      // 오류 처리
      print('닉네임 저장 실패: $e');
      state = state.copyWith(validationMessage: '저장 중 오류 발생. 다시 시도해주세요.', validationColor: Colors.red);
    }
  }

  @override
  void dispose() {
    state.controller.dispose();
    super.dispose();
  }
}

final isNickNameValidProvider = StateProvider<bool>((ref) => false);

final nickNameProvider = StateNotifierProvider.family<NickNameProvider, NickNameState, String>(
      (ref, initialNickname) => NickNameProvider(ref, initialNickname),
);
