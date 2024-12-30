import 'package:dailystep/data/api/result/simple_result.dart';
import 'package:dio/dio.dart';

class ApiError {
  final int? statusCode;
  final bool isApplicationError;
  final String message;
  final String? code;

  ApiError({
    this.statusCode,
    this.isApplicationError = false,
    required this.message,
    this.code,
  });

  static SimpleResult<ApiError, dynamic> createErrorResult(dynamic e) {
    if (e is DioException) {
      final response = e.response;
      final statusCode = response?.statusCode;
      final serverCode = response?.data['code'];
      final errorMessage = _getErrorMessage(serverCode, statusCode);

      final apiError = ApiError(
        message: errorMessage,
        statusCode: statusCode,
        code: serverCode,
        isApplicationError: response == null,
      );

      _logError(apiError);

      return SimpleResult.failure(apiError);
    }

    return SimpleResult.failure(ApiError(message: 'api_error'));
  }

  // 에러 메시지 검색을 위한 최적화된 함수
  static String _getErrorMessage(String? serverCode, int? statusCode) {
    // 서버에서 전달된 에러 코드로 우선 검색
    if (serverCode != null && _errorCodeMessages.containsKey(serverCode)) {
      return _errorCodeMessages[serverCode]!;
    }
    // serverCode가 없을 때 statusCode로 매핑
    return _errorMessage[statusCode] ?? '알 수 없는 오류가 발생했습니다.';
  }

  // 서버의 ErrorCode와 매핑되는 Flutter용 에러 메시지 매핑
  static final Map<String, String> _errorCodeMessages = {
    'COMMON_500': '서버 에러, 관리자에게 문의 바랍니다.',
    'COMMON_400': '잘못된 요청입니다.',
    'COMMON_401': '인증이 필요합니다.',
    'COMMON_403': '금지된 요청입니다.',
    'COMMON_504': '네트워크 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.',
    'AUTH_4000': '잘못된 요청입니다.',
    'AUTH_4001': '유효하지 않은 액세스 토큰입니다.',
    'AUTH_4002': '토큰이 올바르지 않습니다.',
    'AUTH_4003': '리프레쉬 토큰이 유효하지 않습니다. 다시 로그인 해주세요.',
    'AUTH_4004': '기존 토큰이 만료되었습니다. 토큰을 재발급해주세요.',
    'AUTH_4005': '로그인 후 이용가능합니다. 토큰을 입력해 주세요.',
    'AUTH_4006': '탈퇴한 사용자입니다.',
    'USER_4001': '이미 존재하는 아이디입니다.',
  };

  static final Map<int, String> _errorMessage = {
    400: 'COMMON_400: 잘못된 요청입니다.',
    401: 'COMMON_401: 인증이 필요합니다.',
    403: 'COMMON_403: 금지된 요청입니다.',
    404: '요청한 리소스를 찾을 수 없습니다.',
    405: '지원되지 않는 HTTP 메소드입니다.',
    500: 'COMMON_500: 서버 에러, 관리자에게 문의 바랍니다.',
    504: 'COMMON_504: 네트워크 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.',
  };

  static void _logError(ApiError error) {
    print('Error: ${error.message} (Status code: ${error.statusCode}, Code: ${error.code})');
  }
}
