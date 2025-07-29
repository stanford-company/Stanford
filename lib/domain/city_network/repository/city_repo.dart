import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import '../../../data/cities/model/city.dart';
import '../../../data/cities_network/model/city.dart';

abstract class CityNetworkRepository {
  Future<Either<Failure, List<CityNetworkModel>>> getCitiesNetwork();
}
