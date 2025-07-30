import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/data/medical_entity/model/medical_entity.dart';
import '../repository/medical_repo.dart';

class GetEntitiesUsecase {
  Future<Either<Failure, List<MedicalEntityModel>>> call({
    int? cityId,
    int? categoryId,
    String? name,
    int? page,
  }) async {
    return await getIt<MedicalRepository>().getEntities(
      cityId: cityId,
      medicalCategoryId: categoryId,
      name: name,
      page: page,
    );
  }
}
