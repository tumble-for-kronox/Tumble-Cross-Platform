import 'package:flutter/foundation.dart';

@immutable
abstract class ISecureStorage {
  Future<String?> getRefreshToken();

  Future<String?> getSessionDetails();

  void setRefreshToken(String token);

  void setSessionDetails(String token);

  void clear();
}
