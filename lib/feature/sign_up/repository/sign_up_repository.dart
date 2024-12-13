import 'package:dailystep/data/api/dio/dio_set.dart';
import 'dart:convert';
import 'package:dailystep/data/api/result/simple_result.dart';
import '../../../data/api/result/api_error.dart';

class SignUpRepository {
  Future<SimpleResult<dynamic, ApiError>> signUp(Map<String, dynamic> requestData) async {
    final url = 'auth/signin/kakao'; // 회원가입 URL

    try {
      print('POST 요청 URL: $url');
      print('요청 데이터: $requestData');

      final response = await dioSet.post(
        url,
        data: jsonEncode(requestData), // 회원가입에 필요한 데이터
      );

      if (response.statusCode == 200) {
        dynamic responseData = response.data;

        if (responseData is String) {
          String decodedBody = utf8.decode(responseData.runes.toList(), allowMalformed: true);
          print('응답 데이터: ${decodedBody}');
          responseData = json.decode(decodedBody);
        } else {
          print('응답 데이터: ${responseData}');
        }

        return SimpleResult.success(responseData); // 성공적인 응답 처리
      } else {
        final apiError = ApiError(
          message: '서버 응답 에러',
          statusCode: response.statusCode,
        );
        return SimpleResult.failure(apiError); // 실패 시 오류 처리
      }
    } catch (e) {
      print('예외 발생: $e');
      final errorResult = ApiError(message: e.toString());
      return SimpleResult.failure(errorResult); // 예외 발생 시 처리
    }
  }
}
