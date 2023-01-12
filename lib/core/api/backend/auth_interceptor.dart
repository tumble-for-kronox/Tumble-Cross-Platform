import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tumble/core/api/database/repository/secure_storage_service.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class AuthInterceptor extends Interceptor {
  final _secureStorage = getIt<SecureStorageService>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var refreshToken = await _secureStorage.loadRefreshToken();

    /// Attach refresh token to request if present.
    if (refreshToken != null && !JwtDecoder.isExpired(refreshToken)) {
      options.headers['X-Auth-Token'] = 'Bearer $refreshToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
        name: 'auth_interceptor',
        error: err,
        'Message: ${err.message}\nType: ${err.type}');
  }
}
