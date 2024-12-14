import 'package:dailystep/config/secure_storage/secure_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@riverpod
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService();
}

class SecureStorage {
  static const ACCESS_TOKEN = 'access_token';
  static const ACCESS_TOKEN_EXPIRATION = 'access_token_expiration';

  final SecureStorageService secureStorageService;

  SecureStorage({
    required this.secureStorageService,
  });

  // 엑세스 토큰 저장 (만료 시간도 함께 저장)
  Future<void> saveAccessToken(String accessToken, dynamic expiresInSeconds) async {
    try {
      final expirationTime = DateTime.now().add(Duration(seconds: expiresInSeconds));
      await secureStorageService.saveAccessToken(accessToken, expiresInSeconds);
      await secureStorageService.saveAccessToken(ACCESS_TOKEN_EXPIRATION, expirationTime.toIso8601String());
      print('[SECURE_STORAGE] saveAccessToken: $accessToken, expires at: $expirationTime');
    } catch (e) {
      print("[ERR] AccessToken 저장 실패: $e");
    }
  }

  // 엑세스 토큰 불러오기 시 만료 여부 체크
  Future<String?> readAccessToken() async {
    try {
      final expirationTimeString = await secureStorageService.getAccessToken();
      if (expirationTimeString != null) {
        final expirationTime = DateTime.parse(expirationTimeString);
        if (expirationTime.isBefore(DateTime.now())) {
          // 만료된 토큰은 삭제
          await secureStorageService.deleteTokens();
          await secureStorageService.deleteTokens();
          print('[SECURE_STORAGE] Access Token expired, deleted.');

          // 만료된 토큰은 null 반환 (새로운 토큰을 받아야 함)
          return null;
        }
      }

      final accessToken = await secureStorageService.getAccessToken();
      return accessToken;
    } catch (e) {
      print("[ERR] AccessToken 불러오기 실패: $e");
      return null;
    }
  }

  // 엑세스 토큰 삭제
  Future<void> deleteAccessToken() async {
    try {
      await secureStorageService.deleteTokens();
      await secureStorageService.deleteTokens();
      print('[SECURE_STORAGE] AccessToken 삭제 완료');
    } catch (e) {
      print("[ERR] AccessToken 삭제 실패: $e");
    }
  }
}

final savedTokenProvider = FutureProvider<String?>((ref) async {
  final secureStorageService = ref.read(secureStorageServiceProvider);
  return await secureStorageService.getAccessToken();
});