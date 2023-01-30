import 'package:dio/dio.dart';
import 'package:tumble/core/api/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class AuthInterceptor extends Interceptor {
  final _secureStorage = getIt<SecureStorageRepository>();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({"x-auth-token": await _secureStorage.getRefreshToken() ?? ""});

    super.onRequest(options, handler);
  }
}
