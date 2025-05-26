import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/auth/model/check_id.dart';
import 'package:medapp/domain/auth/repository/auth_repo.dart';

import '../../../core/utils/setup_service.dart';
import '../service/auth_service.dart';

class AuthRepositoryImp extends AuthRepository{
  @override
  Future<Either<Failure, CheckIdModel>> checkId({required String nationalId}) async{
    try {
      CheckIdModel checkIdModel =
      await getIt<AuthService>().checkId(nationalId: nationalId);
      return Right(checkIdModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}