import 'package:dio/dio.dart';
import '../utils/auth_manager.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Check if the error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      print('🔐 401 Unauthorized detected in interceptor');

      // Handle session expiration using AuthManager
      AuthManager.handleSessionExpired();
    }

    // Continue with the error
    handler.next(err);
  }
}
