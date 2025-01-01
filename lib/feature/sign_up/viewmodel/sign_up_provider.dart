import 'dart:convert';

import 'package:dailystep/common/extension/string_extension.dart';
import 'package:dailystep/config/app.dart';
import 'package:dailystep/config/secure_storage/secure_storage_provider.dart';
import 'package:dailystep/feature/sign_up/viewmodel/validation_providers.dart';
import 'package:dio/dio.dart';
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
        accessToken: state.accessToken ?? '',
        nickname: state.nickName ?? '',
        birth: state.birthDate != null ? DateFormat('yyyy-MM-dd').format(state.birthDate!) : '',
        gender: state.sex == 0 ? "MALE" : "FEMALE",
        jobId: state.job ?? 0,
        yearId: state.jobTenure ?? 0,
      );

      final response = await ApiClient().post(
        'auth/signin/kakao',
        data: signUpRequest.toJson(),
      );

      print('응답 데이터signUpRequest: ${jsonEncode(response.data)}'); // 응답 데이터 로그 추가


      if (response.statusCode == 200) {
        // 서버에서 반환된 데이터 처리
        final responseData = response.data;
        final newAccessToken = responseData['data']['accessToken'] ?? '';
        final accessTokenExpiresIn = responseData['data']['accessTokenExpiresIn'] ?? '';
        final refreshToken = responseData['data']['refreshToken'] ?? '';

        if (newAccessToken.isNotEmpty) {
          // 새로운 accessToken으로 로그인 처리
          await ref.read(secureStorageServiceProvider).saveAccessToken(newAccessToken, accessTokenExpiresIn);
          await ref.read(secureStorageServiceProvider).saveRefreshToken(refreshToken);
          await ref.read(secureStorageServiceProvider).saveIsFirstAchieve('0');

          final storedRefreshToken = await ref.read(secureStorageServiceProvider).getRefreshToken();
          print('저장된 RefreshToken: $storedRefreshToken');

          print('로그인 성공: 새로운 accessToken 저장');

          // 로그인 성공 처리
          ref.read(isLoggedInProvider.notifier).state = true;
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
    print('닉네임 중복 확인 시작: $nickname');
    ref.read(isNicknameCheckInProgressProvider.notifier).state = true;

    try {
      // NicknameRepository에서 결과를 받아 처리
      final result = await _nicknameRepository.checkNickname(nickname);

      print('닉네임 중복 확인 결과: ${result.isSuccess ? "성공" : "실패"}');

      if (result.isSuccess) {
        // 닉네임 사용 가능
        print('닉네임 사용 가능');
        _updateNicknameState(
          ref,
          '사용 가능한 닉네임입니다. :)',
          Colors.blue,
          true,
        );
      } else if (result.failureData?.statusCode == 400) {
        // 서버에서 반환된 메시지 처리
        final errorMessage = result.failureData?.message ?? '이미 사용 중인 닉네임입니다.';
        print('닉네임 중복: $errorMessage');
        _updateNicknameState(
          ref,
          errorMessage,
          Colors.red,
          false,
        );
      } else {
        // 기타 오류 처리
        print('서버에서 알 수 없는 오류 발생');
        _updateNicknameState(
          ref,
          '서버 오류. 다시 시도해주세요.',
          Colors.red,
          false,
        );
      }
    } catch (e) {
      // 네트워크 오류 또는 예외 처리
      if (e is DioException && e.response?.statusCode == 400) {
        final errorMessage = e.response?.data['message'] ?? '이미 사용 중인 닉네임입니다.';
        print('DioException 상태 코드 400: $errorMessage');
        _updateNicknameState(
          ref,
          errorMessage,
          Colors.red,
          false,
        );
      } else {
        print('네트워크 오류 또는 예외 발생: $e');
        _updateNicknameState(
          ref,
          '네트워크 오류. 다시 시도해주세요.',
          Colors.red,
          false,
        );
      }
    } finally {
      print('닉네임 중복 확인 완료');
      ref.read(isNicknameCheckInProgressProvider.notifier).state = false;
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
