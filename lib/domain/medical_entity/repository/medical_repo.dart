import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/data/medical_entity/model/medical_entity.dart';

abstract class MedicalRepository {
  Future<Either<Failure, List<MedicalEntityModel>>> getEntities({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  });
  Future<Either<Failure, List<MedicalDoctor>>> getMedicalDoctor();
}
