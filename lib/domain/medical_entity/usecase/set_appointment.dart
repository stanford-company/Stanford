import 'package:dartz/dartz.dart';
import 'package:medapp/data/medical_entity/model/appointment_params.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/domain/medical_entity/repository/medical_repo.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';

class SetAppointmentUseCase
    extends Usecase<Either<Failure, String>, AppointmentParams> {
  @override
  Future<Either<Failure, String>> call({dynamic params}) async {
    return await getIt<MedicalRepository>().setAppointment(params: params);
  }
}
