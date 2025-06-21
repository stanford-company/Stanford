import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/data/auth/model/profile.dart';
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
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserParams>> register({
    required String nationalId,
    required String email,
    required String password,
  }) async {
    try {
      final user = await getIt<AuthService>().register(
        nationalId,
        email,
        password,
      );
      await SharedPrefsService.saveToken(user.apiToken);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> forgotPassword({
    required String nationalId,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final user = await getIt<AuthService>().forgotPassword(
        nationalId,
        confirmPassword,
        password,
      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserParams>> login({
    required String nationalId,
    required String password,
  }) async {
    try {
      final userParams = await getIt<AuthService>().login(nationalId, password);

      await SharedPrefsService.saveToken(userParams.apiToken);

      return Right(userParams);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      final data = await getIt<AuthService>().logout();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getUserProfile() async {
    try {
      final ProfileModel data = await getIt<AuthService>().getUserProfile();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
