import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageConfig {
  // FlutterSecureStorage의 옵션을 설정합니다.
  static const _storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      synchronizable: true,               // iCloud와 동기화 여부
    ),
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,   // Android에서 암호화된 SharedPreferences 사용
    ),
  );

  // FlutterSecureStorage 인스턴스를 반환합니다.
  static FlutterSecureStorage get storage => _storage;
}
