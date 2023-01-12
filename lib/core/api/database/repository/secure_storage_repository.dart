import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tumble/core/api/database/interface/isecure_storage.dart';
import 'package:tumble/core/shared/secure_storage_keys.dart';

class SecureStorageRepository implements ISecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AndroidOptions aOptions =
      const AndroidOptions(encryptedSharedPreferences: true);

  @override
  Future<String?> loadRefreshToken() async {
    try {
      return await secureStorage.read(
          key: SecureStorageKeys.refreshToken, aOptions: aOptions);
    } catch (e) {
      clear();
    }
    return null;
  }

  @override
  void setRefreshToken(String token) {
    secureStorage.write(
        key: SecureStorageKeys.refreshToken, value: token, aOptions: aOptions);
  }

  @override
  void clear() {
    secureStorage.deleteAll();
  }
}
