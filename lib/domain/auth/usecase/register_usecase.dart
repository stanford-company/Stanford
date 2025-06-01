import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../repository/auth_repo.dart';
import '../../../data/auth/model/login.dart'; // ✅ because we return UserParams not RegisterModel

class RegisterUsecase extends Usecase<Either<Failure, UserParams>, Map<String, String>> {
  @override
  Future<Either<Failure, UserParams>> call({required Map<String, String> params}) async {
    return await getIt<AuthRepository>().register(
      nationalId: params['national_id']!,
      email: params["email"]!,
      password: params['password']!,
    );
  }
}
