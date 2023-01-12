import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tumble/core/shared/secure_storage_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AndroidOptions aOptions =
      const AndroidOptions(encryptedSharedPreferences: true);

  
  Future<String?> loadRefreshToken() async {
    try {
      return await secureStorage.read(
          key: SecureStorageKeys.refreshToken, aOptions: aOptions);
    } catch (e) {
      clear();
    }
    return null;
  }

  
  void setRefreshToken(String token) {
    secureStorage.write(
        key: SecureStorageKeys.refreshToken, value: token, aOptions: aOptions);
  }

  
  void clear() {
    secureStorage.deleteAll();
  }
}
