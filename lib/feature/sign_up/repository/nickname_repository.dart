import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dailystep/data/api/result/simple_result.dart';
import '../../../data/api/result/api_error.dart';
import '../model/nickname_validation_response.dart';

class NicknameRepository {
  Future<SimpleResult<NicknameValidationResponse, ApiError>> checkNickname(String nickname) async {
    final url = Uri.parse('https://dailystep.shop/api/v1/member/nickname/valid');

    try {
      print('POST 요청 URL: $url');
      print('요청 데이터: $nickname');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      if (response.statusCode == 200) {
        // UTF-8로 응답 데이터 디코딩
        String decodedBody = utf8.decode(response.body.runes.toList(), allowMalformed: true);
        print('응답 데이터: ${decodedBody}');


        final jsonResponse = json.decode(decodedBody) as Map<String, dynamic>;

        return SimpleResult.success(NicknameValidationResponse.fromJson(jsonResponse));
      } else {
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
