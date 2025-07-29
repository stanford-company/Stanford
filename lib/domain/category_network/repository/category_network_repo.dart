import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/category_network/model/category.dart';

abstract class CategoryNetworkRepository {
  Future<Either<Failure, List<CategoryNetworkModel>>> getNetworkCategories();
}
