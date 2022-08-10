import 'package:flutter/foundation.dart';

@immutable
abstract class ISecureStorage {
  Future<String?> getRefreshToken();

  void setRefreshToken(String token);

  void clear();
}
