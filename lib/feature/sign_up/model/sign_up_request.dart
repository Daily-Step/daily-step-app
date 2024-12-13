class SignUpRequest {
  final String accessToken;
  final String nickname;
  final String birth;
  final String gender;
  final int jobId;
  final int yearId;

  SignUpRequest({
    required this.accessToken,
    required this.nickname,
    required this.birth,
    required this.gender,
    required this.jobId,
    required this.yearId,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'nickname': nickname,
      'birth': birth,
      'gender': gender,
      'jobId': jobId,
      'yearId': yearId,
    };
  }

  // JSON에서 모델로 변환하는 메서드
  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return SignUpRequest(
      accessToken: json['accessToken'],
      nickname: json['nickname'],
      birth: json['birth'],
      gender: json['gender'],
      jobId: json['jobId'],
      yearId: json['yearId'],
    );
  }
}
