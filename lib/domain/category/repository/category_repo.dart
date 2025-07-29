import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/category/model/category.dart';  // Import CategoryModel

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getNetworkCategories();
}
