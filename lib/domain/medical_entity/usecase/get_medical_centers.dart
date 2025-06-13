import 'package:dartz/dartz.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/domain/medical_entity/repository/medical_repo.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';

class GetMedicalCentersUseCase
    extends Usecase<Either<Failure, List<MedicalModel>>, dynamic> {
  @override
  Future<Either<Failure, List<MedicalModel>>> call({dynamic params}) async {
    return await getIt<MedicalRepository>().getMedicalCenter();
  }
}
