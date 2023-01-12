import 'package:flutter/foundation.dart';

@immutable
abstract class ISecureStorage {
  Future<String?> loadRefreshToken();

  void setRefreshToken(String token);

  void clear();
}
