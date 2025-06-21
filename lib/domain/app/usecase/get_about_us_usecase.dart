import 'package:dartz/dartz.dart';
import 'package:medapp/core/usecase/usecase.dart';
import 'package:medapp/data/app/model/about_us_model.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/app/model/procedures.dart';
import '../repository/app_repo.dart';

class GetAboutUsUsecase
    extends Usecase<Either<Failure, AboutUsModel>, dynamic> {
  Future<Either<Failure, AboutUsModel>> call({dynamic params}) async {
    return await getIt<AppRepository>().getAboutUs();
  }
}
