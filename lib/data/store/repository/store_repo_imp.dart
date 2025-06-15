import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/store/model/supplies_model.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/store/repository/store_repo.dart';
import '../service/store.dart';

class StoreRepositoryImp extends StoreRepository {
  @override
  Future<Either<Failure, List<SuppliesModel>>> getMedicalSupplies() async {
    try {
      List<SuppliesModel> supplies = await getIt<StoreService>()
          .getMedicalSupplies();
      return Right(supplies);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
