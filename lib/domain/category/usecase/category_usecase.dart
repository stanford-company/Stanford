import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';  // Import CategoryRepository
import 'package:medapp/data/category/model/category.dart';  // Import CategoryModel

class GetCategoriesUsecase {


  // No need for NoParams class if no parameters are required
  Future<Either<Failure, List<CategoryModel>>> call() async {
    return await getIt<CategoryRepository>().getCategories();
  }
}
