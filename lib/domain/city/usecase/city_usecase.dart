import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
import '../../../data/cities/model/city.dart';
import '../repository/city_repo.dart';

class GetCitiesUsecase {
  Future<Either<Failure, List<CityModel>>> call() async {
    return await getIt<CityRepository>().getCities();
  }
}
