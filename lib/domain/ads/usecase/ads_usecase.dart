import 'package:dartz/dartz.dart';
import 'package:medapp/domain/ads/repository/ads.repo.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/ads/model/ads.dart';

class AdsUsecase extends Usecase<Either<Failure, AdsModel>, String> {
  @override
  Future<Either<Failure, AdsModel>> call({required String params}) async {
    return await getIt<AdsRepository>().ads(token: params);
  }
}


