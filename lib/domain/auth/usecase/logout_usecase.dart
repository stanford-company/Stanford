import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/logout.dart';
import '../repository/auth_repo.dart';

class LogoutUsecase extends Usecase<Either<Failure, LogoutModel>, dynamic> {
  @override
  Future<Either<Failure, LogoutModel>> call({dynamic params}) async {
    return await getIt<AuthRepository>().logout();
  }
}
