import 'package:dartz/dartz.dart';
import 'package:medapp/data/auth/model/profile.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/login.dart';
import '../repository/auth_repo.dart';

class GetProfileUsecase
    extends Usecase<Either<Failure, ProfileModel>, dynamic> {
  @override
  Future<Either<Failure, ProfileModel>> call({dynamic params}) async {
    return await getIt<AuthRepository>().getUserProfile();
  }
}
