import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/medical_entity/model/appointment_params.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/data/medical_entity/service/medical_service.dart';
import '../../../core/utils/setup_service.dart';
import '../model/medical_entity.dart';
import 'package:medapp/domain/medical_entity/repository/medical_repo.dart';

class MedicalRepositoryImp extends MedicalRepository {
  @override
  Future<Either<Failure, List<MedicalEntityModel>>> getEntities({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  }) async {
    try {
      final entities = await getIt<MedicalService>().getMedicalEntity(
        cityId: cityId,
        medicalCategoryId: medicalCategoryId,
        name: name,
        page: page,
      );
      return Right(entities);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MedicalModel>>> getMedicalDoctor() async {
    try {
      final medicalDoctors = await getIt<MedicalService>().getMedicalDoctor();
      return Right(medicalDoctors);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MedicalModel>>> getMedicalCenter() async {
    try {
      final medicalDoctors = await getIt<MedicalService>().getMedicalCenter();
      return Right(medicalDoctors);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MedicalEntityModel>>> medicalSearch({
    required String name,
  }) async {
    try {
      final medicalDoctors = await getIt<MedicalService>().medicalSearch(
        name: name,
      );
      return Right(medicalDoctors);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setAppointment({
    required AppointmentParams params,
  }) async {
    try {
      final String data = await getIt<MedicalService>().setAppointment(
        params: params,
      );
      return Right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
