import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';

import '../../../core/utils/setup_service.dart';
import '../../../domain/appointments_history/repository/appointments_repo.dart';
import '../model/appointments_history.dart';
import '../service/appointments_history_service.dart';

class AppointmentRepositoryImp extends AppointmentRepository {
  @override
  Future<Either<Failure, List<Appointment>>> getAppointmentsHistory() async {
    try {
      final appointments = await getIt<AppointmentService>().getAppointments();
      return Right(appointments);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
