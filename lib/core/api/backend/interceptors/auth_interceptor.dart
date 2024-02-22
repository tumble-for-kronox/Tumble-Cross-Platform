import 'package:dio/dio.dart';
import 'package:tumble/core/api/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class AuthInterceptor extends Interceptor {
  final _secureStorage = getIt<SecureStorageRepository>();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? refreshToken = await _secureStorage.getRefreshToken();
    String? sessionDetails = await _secureStorage.getSessionDetails();

    if (refreshToken != null) {
      options.headers.addAll({"X-auth-token": refreshToken});
    }

    if (sessionDetails != null) {
      options.headers.addAll({"X-session-token": sessionDetails});
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String? refreshToken = response.headers.value('X-auth-header');
    String? sessionToken = response.headers.value('X-session-token');

    if (refreshToken != null) {
      _secureStorage.setRefreshToken(refreshToken);
    }

    if (sessionToken != null) {
      _secureStorage.setSessionDetails(sessionToken);
    }

    super.onResponse(response, handler);
  }
}
