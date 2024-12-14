class NicknameValidationResponse {
  final String data;

  NicknameValidationResponse({required this.data});

  factory NicknameValidationResponse.fromJson(Map<String, dynamic> json) {
    return NicknameValidationResponse(
      data: json['data'] ?? '', // 디코딩 없이 바로 데이터 처리
    );
  }
}