import 'package:dailystep/common/extension/string_extension.dart';
import 'package:dailystep/feature/sign_up/viewmodel/validation_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/route/auth_redirection.dart';
import '../../../data/api/api_client.dart';
import '../../../data/api/result/api_error.dart';
import '../../../data/api/result/simple_result.dart';
import '../model/nickname_validation_response.dart';
import '../repository/nickname_repository.dart';
import '../state/sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final NicknameRepository _nicknameRepository = NicknameRepository();

  SignUpViewModel() : super(SignUpState());

  Future<void> signUpWithKakao(String accessToken) async {
    state = state.copyWith();

    try {
      // 카카오 로그인 후 받은 accessToken을 사용하여 회원가입 정보 요청
      final signUpData = getSignUpData(state);
      final requestData = {
        ...signUpData,
        "accessToken": accessToken,
      };

      final response = await ApiClient().post('/api/v1/auth/signin/kakao', data: requestData);

      if (response.statusCode == 200) {
        // 회원가입 성공 처리
        state = state.copyWith();
        print('회원가입 성공');
      } else {
        // 회원가입 실패 처리
        state = state.copyWith();
      }
    } catch (e) {
      state = state.copyWith();
      print('회원가입 오류: $e');
    }
  }

  // 데이터를 서버에 보낼 형식으로 변환하는 메서드
  Map<String, dynamic> getSignUpData(SignUpState signUpState) {
    return {
      "accessToken": signUpState.accessToken,
      "nickname": signUpState.nickName ?? '',
      "birth": signUpState.birthDate != null ? signUpState.birthDate!.toIso8601String() : '',
      "gender": signUpState.sex == 0 ? "MALE" : "FEMALE",
      "jobId": signUpState.job ?? 0,
      "yearId": signUpState.jobTenure ?? 0,
    };
  }

  void setAccessToken(String token) {
    state = state.copyWith(accessToken: token);
  }

  void setNickName(String nickName, WidgetRef ref) {
    String nickNameValidation = '';
    Color nickNameValidationColor = Colors.red;

    if (nickName != '') {
      if (nickName.length < 4 || nickName.length > 10) {
        nickNameValidation = '4자 이상 10자 이내로 입력해 주세요.';
      }
      if (!nickName.nickNameValidation()) {
        nickNameValidation = '한국어, 영어 대소문자, 숫자로만 입력해 주세요.';
      }
    }
    // 상태 업데이트
    state = state.copyWith(
      nickName: nickName,
      nickNameValidation: nickNameValidation,
    );

    // 유효성 검사 색상 업데이트
    ref.read(nicknameValidationColorProvider.notifier).state = nickNameValidationColor;
  }

  Future<void> checkNicknameAvailability(String nickname, WidgetRef ref) async {
    ref.read(isNicknameCheckInProgressProvider.notifier).state = true;

    try {
      final result = await _nicknameRepository.checkNickname(nickname);
      _handleNicknameResult(result, ref);
    } catch (e) {
      _updateNicknameState(ref, '서버 오류. 다시 시도해주세요.', Colors.red, false);
    } finally {
      ref.read(isNicknameCheckInProgressProvider.notifier).state = false;
    }
  }

  void _handleNicknameResult(SimpleResult<NicknameValidationResponse, ApiError> result, WidgetRef ref) {
    if (result.isSuccess) {
      final successData = result.successData;
      print('Success Data: ${successData.toString()}');

      // 공백 제거 후 문자열 비교
      final isAvailable = successData?.data.trim() == '사용 가능한 닉네임입니다.';
      print('Is Available: $isAvailable'); // 디버깅용 출력

      _updateNicknameState(
        ref,
        isAvailable ? '사용 가능한 닉네임입니다. :)' : '이미 사용 중인 닉네임입니다.',
        isAvailable ? Colors.blue : Colors.red,
        isAvailable,
      );
    } else {
      final errorData = result.failureData;
      print('Error Data: ${errorData?.toString()}');

      final errorMessage = errorData?.message ?? '서버 오류. 다시 시도해주세요.';
      _updateNicknameState(ref, errorMessage, Colors.red, false);
    }
  }

  void _updateNicknameState(WidgetRef ref, String validationMessage, Color validationColor, bool isAvailable) {
    state = state.copyWith(
      nickNameValidation: validationMessage,
      nickNameValidationColor: validationColor,
      isAvailable: isAvailable,
    );
    ref.read(nicknameValidationColorProvider.notifier).state = validationColor;
  }

  void setBirthDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void setSex(int sex) {
    state = state.copyWith(selectedSex: sex);
  }

  void setJob(int job) {
    state = state.copyWith(selectedJob: job);
    print('riverpod job ${state.job}');
  }

  void setJobTenure(int jobTenure) {
    state = state.copyWith(selectedJobTenure: jobTenure);
  }

  void nextStep() {
    if (state.step < 6) {
      state = state.copyWith(step: state.step + 1);
    }
  }

  void beforeStep() {
    state = state.copyWith(step: state.step - 1);
  }

  VoidCallback? canMoveToNextStep() {
    if (checkValid()) {
      if (state.step != 6) {
        return nextStep;
      }
    }
    return null;
  }

  bool checkValid() {
    if (state.step == 1) {
      return _validateNickname();
    } else if (state.step == 2 && state.birthDate != null) {
      return true;
    } else if (state.step == 3 && state.sex != null) {
      return true;
    } else if (state.step == 4 && state.job != null) {
      return true;
    } else if (state.step == 5 && state.jobTenure != null) {
      return true;
    }
    return false;
  }

  bool _validateNickname() {
    return state.nickName?.isNotEmpty == true && state.nickNameValidation == '사용 가능한 닉네임입니다. :)';
  }

  VoidCallback saveUserInfo(DailyStepAuth auth, BuildContext context) {
    return () {
      auth.signUp(context);
    };
  }
}

final signUpProvider = StateNotifierProvider<SignUpViewModel, SignUpState>(
  (ref) => SignUpViewModel(),
);
