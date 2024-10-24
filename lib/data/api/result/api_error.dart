import 'package:dailystep/data/api/result/simple_result.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class ApiError {
  int? statusCode;
  bool isApplicationError;
  String message;

  ApiError({
    this.statusCode,
    this.isApplicationError = false,
    required this.message,
  });

  static final Map<int, String> _errorMessage = {
    200: '성공적으로 처리 되었습니다.',
    201: '성공적으로 생성 되었습니다.',
    301: '요청한 리소스가 다른 위치로 이동했습니다.',
    401: '인증이 필요합니다. 로그인을 확인해 주세요.',
    403: '접근이 거부되었습니다. 권한을 확인해 주세요.',
    404: '요청한 리소스를 찾을 수 없습니다.',
    405: '지원되지 않는 HTTP 메소드입니다.',
    500: '서버 내부 오류가 발생했습니다. 나중에 다시 시도해주세요.',
    501: '요청된 기능이 서버에 구현되어 있지 않습니다.',
    504: '서버 응답이 지연되고 있습니다. 잠시 후 다시 시도해주세요.',
    505: '지원되지 않는 HTTP 프로토콜 버전입니다.',
  };

  static SimpleResult<ApiError, dynamic> createErrorResult(dynamic e) {
    if (e is DioException) {
      final response = e.response;
      final statusCode = response?.statusCode;
      final errorMessage = _errorMessage[statusCode] ?? '알 수 없는 오류가 발생했습니다.';

      final apiError = ApiError(
        message: errorMessage,
        statusCode: statusCode,
        isApplicationError: response == null,
      );

      _logError(apiError);

      return SimpleResult.failure(apiError);
    }

    return SimpleResult.failure(ApiError(message: 'api_error'));
  }

  static void _logError(ApiError error) {
    print('Error: ${error.message} (Status code: ${error.statusCode})');
  }
}
