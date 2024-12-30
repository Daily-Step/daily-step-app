import 'package:dailystep/data/api/dio/dio_set.dart';
import 'dart:convert';
import 'package:dailystep/data/api/result/simple_result.dart';
import 'package:dio/dio.dart';
import '../../../data/api/result/api_error.dart';
import '../model/nickname_validation_response.dart';

class NicknameRepository {
  Future<SimpleResult<NicknameValidationResponse, ApiError>> checkNickname(String nickname) async {
    final url = 'member/nickname/valid';

    try {
      print('POST 요청 URL: $url');
      print('요청 데이터: $nickname');

      final response = await dioSet.post(
        url,
        data: jsonEncode({'nickname': nickname}),
        options: Options(
          validateStatus: (status) {
            // 400 상태 코드도 예외로 처리하지 않음
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        // 정상 응답 처리
        final responseData = response.data;
        print('응답 데이터: $responseData');

        if (responseData is Map<String, dynamic>) {
          return SimpleResult.success(NicknameValidationResponse.fromJson(responseData));
        } else {
          print('응답 데이터가 예상한 형식이 아닙니다.');
          return SimpleResult.failure(ApiError(message: '잘못된 응답 데이터 형식', statusCode: response.statusCode));
        }
      } else if (response.statusCode == 400) {
        // 400 상태 코드 처리
        final errorMessage = response.data['message'] ?? '이미 사용 중인 닉네임입니다.';
        print('400 에러 발생: $errorMessage');

        final apiError = ApiError(
          message: errorMessage,
          statusCode: response.statusCode,
        );
        return SimpleResult.failure(apiError);
      } else {
        // 기타 에러 처리
        final apiError = ApiError(
          message: '서버 응답 에러',
          statusCode: response.statusCode,
        );
        return SimpleResult.failure(apiError);
      }
    } catch (e) {
      print('예외 발생: $e');
      final errorResult = ApiError(message: e.toString());
      return SimpleResult.failure(errorResult);
    }
  }
}
