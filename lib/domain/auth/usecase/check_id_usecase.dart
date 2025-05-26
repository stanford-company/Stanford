import 'package:dartz/dartz.dart';
import 'package:medapp/data/auth/model/check_id.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../repository/auth_repo.dart';

  class CheckIdUsecase
      extends Usecase<Either<Failure, CheckIdModel>, String> {
    @override
    Future<Either<Failure, CheckIdModel>> call(
        {required String params}) async {
      return await getIt<AuthRepository>().checkId(nationalId: params);
    }
  }