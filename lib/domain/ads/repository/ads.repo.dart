import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../data/ads/model/ads.dart';

abstract class AdsRepository {
  Future<Either<Failure, AdsModel>> ads({required String token});
}