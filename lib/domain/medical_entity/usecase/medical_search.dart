import 'package:dartz/dartz.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/domain/medical_entity/repository/medical_repo.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/medical_entity/model/medical_entity.dart';

class MedicalSearchUseCase
    extends Usecase<Either<Failure, List<MedicalEntityModel>>, String> {
  @override
  Future<Either<Failure, List<MedicalEntityModel>>> call({
    required String params,
  }) async {
    return await getIt<MedicalRepository>().medicalSearch(name: params);
  }
}
