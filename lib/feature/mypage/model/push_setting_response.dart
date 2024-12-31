class PushSettingResponse {
  final int status;
  final String message;
  final String code;
  final String url;
  final String data;

  PushSettingResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.url,
    required this.data,
  });

  factory PushSettingResponse.fromJson(Map<String, dynamic> json) {
    return PushSettingResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      code: json['code'] as String,
      url: json['url'] as String,
      data: json['data'] as String,
    );
  }
}
