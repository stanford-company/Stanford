import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/procedures/repository/procedure_repo.dart';
import '../model/procedures.dart';
import '../service/procedures.dart';

class ProcedureRepositoryImp extends ProceduresRepository {
  @override
  Future<Either<Failure, List<ProcedureModel>>> procedures() async {
    try {
      final list = await getIt<ProcedureService>().procedures();
      return Right(list);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}