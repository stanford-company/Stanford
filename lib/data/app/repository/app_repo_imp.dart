import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/data/app/model/about_us_model.dart';
import 'package:medapp/domain/app/repository/app_repo.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../model/procedures.dart';
import '../service/app_service.dart';

class AppRepositoryImp extends AppRepository {
  @override
  Future<Either<Failure, List<ProcedureModel>>> procedures() async {
    try {
      final list = await getIt<AppService>().procedures();
      return Right(list);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AboutUsModel>> getAboutUs() async {
    try {
      final AboutUsModel aboutUs = await getIt<AppService>().getAboutUs();
      return Right(aboutUs);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
