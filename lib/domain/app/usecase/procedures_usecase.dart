import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/app/model/procedures.dart';
import '../repository/app_repo.dart';

class ProceduresUsecase {
  Future<Either<Failure, List<ProcedureModel>>> call() async {
    return await getIt<AppRepository>().procedures();
  }
}
