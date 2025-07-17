import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/cities/model/city.dart';
import '../../../data/cities_network/model/city.dart';
import '../repository/city_repo.dart';

class GetCitiesNetworkUsecase {
  Future<Either<Failure, List<CityNetworkModel>>> call() async {
    return await getIt<CityNetworkRepository>().getCitiesNetwork();
  }
}
