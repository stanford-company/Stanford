import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
 import '../../../data/procedures/model/procedures.dart';

abstract class ProceduresRepository {
  Future<Either<Failure, List<ProcedureModel>>> procedures();
}