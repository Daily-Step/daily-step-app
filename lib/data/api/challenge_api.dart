import 'api_client.dart';

class ChallengeApi {
  final ApiClient _apiClient = ApiClient();
  ChallengeApi();

  Future<dynamic> getCategories() async {
    try {
      final response = await _apiClient.get('/categories');
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('카테고리 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('카테고리 API 호출 중 오류 발생: $e');
      return [];
    }
  }

  Future<dynamic> getChallenges() async {
    try {
      final response = await _apiClient.get('/challenges');
      if (response.statusCode == 200) {
        return response.data; // 챌린지 데이터를 반환
      } else {
        throw Exception('챌린지 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('챌린지 API 호출 중 오류 발생: $e');
      return [];
    }
  }

  Future<void> addChallenge(Map<String, dynamic> challengeData) async {
    try {
      final response = await _apiClient.post('/challenges', data: challengeData);
      if (response.statusCode == 201) {
        print('챌린지 추가 성공');
      } else {
        throw Exception('챌린지 추가 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('챌린지 추가 중 오류 발생: $e');
    }
  }

  Future<void> updateChallenge(Map<String, dynamic> challengeData) async {
    try {
      final response = await _apiClient.post('/challenges', data: challengeData);
      if (response.statusCode == 201) {
        print('챌린지 수정 성공');
      } else {
        throw Exception('챌린지 수정 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('챌린지 수정 중 오류 발생: $e');
    }
  }

  Future<void> deleteChallenge(Map<String, dynamic> challengeData) async {
    try {
      final response = await _apiClient.post('/challenges', data: challengeData);
      if (response.statusCode == 201) {
        print('챌린지 삭제 성공');
      } else {
        throw Exception('챌린지 삭제 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('챌린지 삭제 중 오류 발생: $e');
    }
  }

  Future<void> achieveChallenge(Map<String, dynamic> challengeData) async {
    try {
      final response = await _apiClient.post('/achieve', data: challengeData);
      if (response.statusCode == 201) {
        print('챌린지 달성 성공');
      } else {
        throw Exception('챌린지 달성 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('챌린지 달성 중 오류 발생: $e');
    }
  }
}
