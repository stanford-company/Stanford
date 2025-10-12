import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/store/model/supplies_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<SuppliesModel>>> getMedicalSupplies();
}
