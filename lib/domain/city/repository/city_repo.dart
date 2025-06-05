import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import '../../../data/cities/model/city.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityModel>>> getCities();
}
