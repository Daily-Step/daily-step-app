import 'package:shared_preferences/shared_preferences.dart';

class FcmTokenStore {
  static const String _fcmTokenKey = 'fcm_token';

  // FCM 토큰 저장
  Future<void> saveFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, token);
  }

  // FCM 토큰 읽기
  Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  // FCM 토큰 삭제
  Future<void> deleteFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
  }
}