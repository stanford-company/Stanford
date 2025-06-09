import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/data/medical_entity/model/medical_entity.dart';
import '../../../data/cities/model/city.dart';
import '../repository/entity_repo.dart';

class GetEntitiesUsecase {
  Future<Either<Failure, List<MedicalEntityModel>>> call({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  }) async {
    return await getIt<EntityRepository>().getEntities(
      cityId: cityId,
      medicalCategoryId: medicalCategoryId,
      name: name,
      page: page,
    );
  }

}

