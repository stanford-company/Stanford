import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/login.dart';
import '../repository/auth_repo.dart';

class LoginUsecase extends Usecase<Either<Failure, UserParams>, Map<String, String>> {
  @override
  Future<Either<Failure, UserParams>> call({required Map<String, String> params}) async {
    return await getIt<AuthRepository>().login(
      nationalId: params['national_id']!,
      password: params['password']!,
    );
  }
}

