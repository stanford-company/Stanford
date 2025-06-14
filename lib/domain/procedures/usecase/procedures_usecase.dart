import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
 import '../../../core/utils/setup_service.dart';
 import '../../../data/procedures/model/procedures.dart';
import '../repository/procedure_repo.dart';

class ProceduresUsecase {
  Future<Either<Failure, List<ProcedureModel>>> call() async {
    return await getIt<ProceduresRepository>().procedures();
  }
}
