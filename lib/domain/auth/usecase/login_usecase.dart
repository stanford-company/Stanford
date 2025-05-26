import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/login.dart';
import '../repository/auth_repo.dart';

class LoginUsecase extends Usecase<Either<Failure, UserParams>, UserParams> {
  @override
  Future<Either<Failure, UserParams>> call({required UserParams params}) async {
    return await getIt<AuthRepository>().login(user: params); // ✅ Fixed
  }
}
