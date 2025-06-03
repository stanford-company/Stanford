import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../../../core/utils/shared_prefs_service.dart';
import '../../../domain/auth/repository/auth_repo.dart';
import '../model/check_id.dart';
import '../model/login.dart';
import '../model/logout.dart';
import '../service/auth_service.dart';
import '../../../core/services/api_service.dart';

class AuthRepositoryImp extends AuthRepository {
  final ApiService apiService =
      getIt<ApiService>(); // ✅ this ensures we use your own

  @override
  Future<Either<Failure, CheckIdModel>> checkId({
    required String nationalId,
  }) async {
    try {
      CheckIdModel checkIdModel = await getIt<AuthService>().checkId(
        nationalId: nationalId,
      );
      return Right(checkIdModel);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, UserParams>> register({
    required String nationalId,
    required String email,
    required String password,
  }) async {
    try {
      final user = await getIt<AuthService>().register(nationalId, email, password);
      await SharedPrefsService.saveToken(user.apiToken);
      return Right(user);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, String>> forgotPassword({
    required String nationalId,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final user = await getIt<AuthService>().forgotPassword(nationalId, confirmPassword, password);

      return Right(user);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, UserParams>> login({
    required String nationalId,
    required String password,
  }) async {
    try {
      final userParams = await getIt<AuthService>().login(nationalId, password);

      // ✅ Save token after login
      await SharedPrefsService.saveToken(userParams.apiToken);

      return Right(userParams);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout({required String token}) async {
    try {
      final data = await apiService.postWithHeaders(
        endPoint: "beneficiaries/logout",
        body: {},
        headers: {"Authorization": "Bearer $token"},
      );
      return Right(LogoutModel.fromJson(data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  Failure _handleError(dynamic e) {
    if (e is DioException) {
      return ServerFailure.fromDioError(e);
    }
    return ServerFailure(e.toString());
  }
}
