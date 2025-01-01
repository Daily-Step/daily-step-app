import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _accessTokenExpirationKey = 'access_token_expiration';

  // Access Token 저장 (만료 시간도 함께 저장)
  Future<void> saveAccessToken(String token, dynamic expiresInSeconds) async {
    try {
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(expiresInSeconds);
      await _storage.write(key: _accessTokenKey, value: token);
      await _storage.write(key: _accessTokenExpirationKey, value: expirationTime.toIso8601String());
      print('[SECURE_STORAGE] Access Token saved with expiration: $expirationTime');
    } catch (e) {
      print("[ERR] Access Token 저장 실패: $e");
    }
  }

  // Refresh Token 저장
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
      print('[SECURE_STORAGE] Refresh Token saved');

      String? savedToken = await _storage.read(key: _refreshTokenKey);
      if (savedToken != null) {
        print('[SECURE_STORAGE] Refresh Token 확인: $savedToken');
      } else {
        print('[SECURE_STORAGE] Refresh Token 저장 후 확인 실패');
      }
    } catch (e) {
      print("[ERR] Refresh Token 저장 실패: $e");
    }
  }

  // Refresh Token 불러오기
  Future<String?> getRefreshToken() async {
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      print('[SECURE_STORAGE] Refresh Token 불러오기 성공: $refreshToken');
      return refreshToken;
    } catch (e) {
      print("[ERR] Refresh Token 불러오기 실패: $e");
      return null;
    }
  }


  // Access Token 불러오기 시 만료 여부 체크
  Future<String?> getAccessToken() async {
    try {
      final expirationTimeString = await _storage.read(key: _accessTokenExpirationKey);
      if (expirationTimeString != null) {
        final expirationTime = DateTime.parse(expirationTimeString);
        if (expirationTime.isBefore(DateTime.now())) {
          // 만료된 토큰은 삭제
          await _storage.delete(key: _accessTokenKey);
          await _storage.delete(key: _accessTokenExpirationKey);
          print('[SECURE_STORAGE] Access Token expired, deleted.');

          // Access Token이 만료되었으므로 새로운 토큰을 요청해야 함
          return null;
        }
      }

      final token = await _storage.read(key: _accessTokenKey);
      return token;
    } catch (e) {
      print("[ERR] Access Token 불러오기 실패: $e");
      return null;
    }
  }

  // 토큰 삭제
  Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _accessTokenExpirationKey);
    print('[SECURE_STORAGE] Tokens deleted');
  }

  // 모든 데이터 삭제
  Future<void> clearAll() async {
    await _storage.deleteAll();
    print('[SECURE_STORAGE] All data deleted');
  }
}
