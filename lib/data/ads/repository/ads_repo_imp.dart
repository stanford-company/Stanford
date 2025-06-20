import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/ads/repository/ads.repo.dart';
import '../model/ads.dart';
import '../service/ads_service.dart';

class AdsRepositoryImp extends AdsRepository {
  final AdsService adsService;

  AdsRepositoryImp(this.adsService);

  @override
  Future<Either<Failure, AdsModel>> ads({required String token}) async {
    try {
      final data = await adsService.ads(token: token);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
