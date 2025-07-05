import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/data/medical_entity/model/medical_entity.dart';

import '../../../data/medical_entity/model/appointment_params.dart';

abstract class MedicalRepository {
  Future<Either<Failure, List<MedicalEntityModel>>> getEntities({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  });
  Future<Either<Failure, List<MedicalModel>>> getMedicalDoctor();
  Future<Either<Failure, List<MedicalModel>>> getMedicalCenter();
  Future<Either<Failure, List<MedicalEntityModel>>> medicalSearch({
    required String name,
  });
  Future<Either<Failure, String>> setAppointment({
    required AppointmentParams params,
  });
}
