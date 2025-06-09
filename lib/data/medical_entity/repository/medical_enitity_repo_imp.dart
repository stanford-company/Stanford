import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/medical_entity/service/medical_entity.dart';
import '../../../core/utils/setup_service.dart';
 import '../model/medical_entity.dart';
import 'package:medapp/domain/medical_entity/repository/entity_repo.dart';


class EntityRepositoryImp extends EntityRepository {
  @override
  Future<Either<Failure, List<MedicalEntityModel>>> getEntities({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  }) async {
    try {
      final entities = await getIt<MedicalEntityService>().getMedicalEntity(
        cityId: cityId,
        medicalCategoryId: medicalCategoryId,
        name: name,
        page: page,
      );
      return Right(entities);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}


