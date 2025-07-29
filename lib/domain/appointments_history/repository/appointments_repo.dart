import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../data/appointments_history/model/appointments_history.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, List<Appointment>>> getAppointmentsHistory();
}
