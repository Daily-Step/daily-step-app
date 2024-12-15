import 'dart:convert';

import 'package:dailystep/common/extension/string_extension.dart';
import 'package:dailystep/config/app.dart';
import 'package:dailystep/config/secure_storage/secure_storage_provider.dart';
import 'package:dailystep/feature/sign_up/viewmodel/validation_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../data/api/api_client.dart';
import '../../../data/api/result/api_error.dart';
import '../../../data/api/result/simple_result.dart';
import '../../auth/viewmodel/login_viewmodel.dart';
import '../model/nickname_validation_response.dart';
import '../model/sign_up_request.dart';
import '../repository/nickname_repository.dart';
import '../state/sign_up_state.dart';
import '../view/job_dummies.dart';
import '../view/jobtenure_dummies.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final NicknameRepository _nicknameRepository = NicknameRepository();
  final Ref ref;
  SignUpViewModel(this.ref) : super(SignUpState());

  Future<void> saveUserInfo(String accessToken, BuildContext context) async {
    try {
      setAccessToken(accessToken);

      print('saveUserInfo 호출, accessToken: $accessToken');

      final signUpRequest = SignUpRequest(
        accessToken: accessToken,
        nickname: state.nickName ?? '',
        birth: state.birthDate != null ? DateFormat('yyyy-MM-dd').format(state.birthDate!) : '',
        gender: state.sex == 0 ? "MALE" : "FEMALE",
        jobId: state.job ?? 0,
        yearId: state.jobTenure ?? 0,
      );

      // requestData를 JSON으로 직렬화
      final requestData = signUpRequest.toJson();
      print('서버 응답 데이터: ${requestData}');

      // 서버 요청 URL이 맞는지 확인
      final url = 'auth/signin/kakao';
      print('POST 요청 URL: $url');
      print('요청 데이터: ${jsonEncode(requestData)}');

      final response = await ApiClient().post(url, data: requestData);

      if (response.statusCode == 200) {
        // 서버에서 반환된 데이터 처리
        final responseData = response.data;
        final newAccessToken = responseData['data']['accessToken'] ?? ''; // 새로운 accessToken
        final accessTokenExpiresIn = responseData['data']['accessTokenExpiresIn'] ?? ''; // 새로운 accessToken


        if (newAccessToken.isNotEmpty) {
          // 새로운 accessToken으로 로그인 처리
          final secureStorage = SecureStorage(secureStorageService: ref.read(secureStorageServiceProvider));

          await secureStorage.saveAccessToken(newAccessToken, accessTokenExpiresIn); // 예: 1시간 후 만료
          setAccessToken(newAccessToken);  // 새로운 토큰을 저장

          // 로그인 상태 관리
          final container = ProviderContainer();
          container.read(isLoggedInProvider.notifier).state = true;

          print('로그인 성공: 새로운 accessToken 저장');

          // 홈 화면으로 이동
          context.go('/main/home');
        } else {
          print('새로운 accessToken을 받지 못했습니다.');
        }
      } else {
        // 실패 시 처리
        print('회원가입 실패, 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('saveUserInfo 서버 오류: $e');
    }
  }

  void setAccessToken(String accessToken) {
    print('AccessToken 설정: $accessToken');
    state = state.copyWith(accessToken: accessToken);
    print('현재 state.accessToken: ${state.accessToken}'); // 상태 확인
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
    print('riverpod JobTenure ${state.jobTenure}');
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
}

final signUpProvider = StateNotifierProvider<SignUpViewModel, SignUpState>(
  (ref) => SignUpViewModel(ref),
);
