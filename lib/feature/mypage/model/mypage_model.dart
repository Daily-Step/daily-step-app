import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_model.freezed.dart';

@freezed
class MyPageModel with _$MyPageModel {
  const factory MyPageModel({
    required String nickname,
    @Default('') String profileImageUrl,
    required DateTime birth,
    required String gender,
    @Default(0) int ongoingChallenges,
    @Default(0) int completedChallenges,
    @Default(0) int totalChallenges,
    @Default(false) bool isPushNotificationEnabled,
    int? jobId,
    String? job,
    int? jobYearId,
  }) = _UserModel;

  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return MyPageModel(
      nickname: data['nickname'] as String,
      birth: DateTime.parse(data['birth'] as String),
      gender: data['gender'] as String,
      jobId: data['jobId'] as int?,
      job: data['job'] as String?,
      jobYearId: data['jobYearId'] as int?,
    );
  }
}

extension MyPageModelExtensions on MyPageModel {
  // 성별 치환
  String get translatedGender {
    if (gender == 'MALE') {
      return '남자';
    } else if (gender == 'FEMALE') {
      return '여자';
    } else {
      return '알 수 없음';
    }
  }

  // 직무 치환
  String get translatedJob {
    const jobCategories = {
      1: '경영·비즈니스',
      2: '개발',
      3: '기획·운영',
      4: '데이터·AI·ML',
      5: '디자인',
      6: '마케팅·광고',
      7: '금융·컨설팅',
      8: '미디어',
      9: '이커머스·리테일',
      10: '인사·채용·노무',
      11: '고객·영업',
      12: '연구·R&D',
      13: '엔지니어링',
      14: '회계·재무',
      15: '생산·품질',
      16: '게임 기획·개발',
      17: '물류·구매',
      18: '교육',
      19: '의료·제약·바이오',
      20: '공공·복지·환경',
    };
    return jobCategories[jobId] ?? '없음';
  }

  // 연차 치환
  String get translatedJobTenure {
    const jobTenures = {
      1: '1년 미만',
      2: '1~2년',
      3: '3~5년',
      4: '6년 이상',
    };
    return jobTenures[jobYearId] ?? '없음';
  }
}
