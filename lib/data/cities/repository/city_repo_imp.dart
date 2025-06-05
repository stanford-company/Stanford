import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/city/repository/city_repo.dart';
import '../model/city.dart';
import '../service/city.dart';

class CityRepositoryImp extends CityRepository{


  Future<Either<Failure, List<CityModel>>> getCities() async {
    try {
      List<CityModel> categories = await getIt<CityService>().getCity();
      return Right(categories);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
