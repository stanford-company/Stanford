import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/usecase/usecase.dart';
import 'package:medapp/core/utils/setup_service.dart';

import '../../../data/appointments_history/model/appointments_history.dart';
import '../repository/appointments_repo.dart';

class GetAppointmentsHistoryUsecase
    extends Usecase<Either<Failure, List<Appointment>>, dynamic> {
  @override
  Future<Either<Failure, List<Appointment>>> call({dynamic params}) async {
    return await getIt<AppointmentRepository>().getAppointmentsHistory();
  }
}
