import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tumble/database/interface/isecure_storage.dart';
import 'package:tumble/shared/secure_storage_keys.dart';

class SecureStorageRepository implements ISecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> getPassword() async {
    return await secureStorage.read(key: SecureStorageKeys.password);
  }

  @override
  Future<String?> getUsername() async {
    return await secureStorage.read(key: SecureStorageKeys.username);
  }

  @override
  void setPassword(String password) {
    secureStorage.write(key: SecureStorageKeys.password, value: password);
  }

  @override
  void setUsername(String username) {
    secureStorage.write(key: SecureStorageKeys.username, value: username);
  }
}
