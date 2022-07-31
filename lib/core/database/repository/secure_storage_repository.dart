import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tumble/core/database/interface/isecure_storage.dart';
import 'package:tumble/core/shared/secure_storage_keys.dart';

class SecureStorageRepository implements ISecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AndroidOptions aOptions =
      const AndroidOptions(encryptedSharedPreferences: true);

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(
        key: SecureStorageKeys.refreshToken, aOptions: aOptions);
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
