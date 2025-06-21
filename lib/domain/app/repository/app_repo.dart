import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../data/app/model/about_us_model.dart';
import '../../../data/app/model/procedures.dart';

abstract class AppRepository {
  Future<Either<Failure, List<ProcedureModel>>> procedures();
  Future<Either<Failure, AboutUsModel>> getAboutUs();
}
