class NicknameValidationResponse {
  final String? data;
  final String? message;

  NicknameValidationResponse({this.data, this.message});

  factory NicknameValidationResponse.fromJson(Map<String, dynamic> json) {
    return NicknameValidationResponse(
      data: json['data'],
      message: json['message'],
    );
  }
}
