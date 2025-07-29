import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
import '../../../data/cities/model/city.dart';
import '../../../domain/city_network/repository/city_repo.dart';
import '../model/city.dart';
import '../service/city.dart';

class CityNetworkRepositoryImp implements CityNetworkRepository {
  Future<Either<Failure, List<CityNetworkModel>>> getCitiesNetwork() async {
    try {
      List<CityNetworkModel> cities = await getIt<CityNetworkService>().getNetworkCity();
      return Right(cities);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
