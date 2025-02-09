import 'package:flutter/cupertino.dart';

import 'api_client.dart';

class ChallengeApi {
  final ApiClient _apiClient = ApiClient();
  ChallengeApi();

  Future<dynamic> getCategories() async {
    try {
      final response = await _apiClient.get('/categories');
      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } catch (e) {
      debugPrint('카테고리 API 호출 중 오류 발생: $e');
      return [];
    }
  }

  Future<String?> fetchProfileImage() async {
    try {
      final response = await _apiClient.get('/member/profile/img');

      if (response.statusCode == 200 && response.data != null) {
        final profileImg = response.data['data'];

        if (profileImg is String && profileImg.isNotEmpty) {
          return profileImg;
        } else {
          return null;
        }
      }
    } catch (e) {
      print('⚠️ 프로필 이미지 가져오기 실패: $e');
    }
    return null; // 오류 발생 시 null 반환
  }

  Future<dynamic> getChallenges(String queryDate) async {
    final requestData = {'queryDate': queryDate};
    try {
      final response =
          await _apiClient.get('/challenges', data: requestData);
      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } catch (e) {
      debugPrint('챌린지 API 호출 중 오류 발생: $e');
      return [];
    }
  }

  Future<void> addChallenge(Map<String, dynamic> challengeData) async {
    try {
      final response =
          await _apiClient.post('/challenges', data: challengeData);
      if (response.statusCode == 200) {
        debugPrint('챌린지 추가 성공');
      }
    } catch (e) {
      throw Exception('챌린지 추가 중 오류 발생: $e');
    }
  }

  Future<void> updateChallenge(int id, Map<String, dynamic> challengeData) async {
    try {
      final response =
          await _apiClient.put('/challenges/$id', data: challengeData);
      if (response.statusCode == 200) {
        debugPrint('챌린지 수정 성공');
      }
    } catch (e) {
      debugPrint('챌린지 수정 중 오류 발생: $e');
    }
  }

  Future<void> deleteChallenge(int id) async {
    try {
      final response =
          await _apiClient.delete('/challenges/$id');
      if (response.statusCode == 200) {
        debugPrint('챌린지 삭제 성공');
      }
    } catch (e) {
      throw Exception('챌린지 삭제 중 오류 발생: $e');
    }
  }

  Future<void> achieveChallenge(int id, String achieveDate) async {
    final requestData = {'achieveDate': achieveDate};
    try {
      final response = await _apiClient.post('/challenges/$id/achieve', data: requestData);
      if (response.statusCode == 200) {
        debugPrint('챌린지 달성 성공');
      }
    } catch (e) {
      throw Exception('챌린지 달성 중 오류 발생:$e');
    }
  }

  Future<void> deleteAchieveChallenge(int id, String cancelDate) async {
    final requestData = {'cancelDate': cancelDate};
    try {
      final response = await _apiClient.post('/challenges/$id/cancel', data: requestData);
      if (response.statusCode == 200) {
        debugPrint('챌린지 달성 취소 성공');
      }
    } catch (e) {
      debugPrint('챌린지 달성 취소 중 오류 발생: $e');
    }
  }
}
