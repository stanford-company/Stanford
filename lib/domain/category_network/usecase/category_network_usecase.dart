import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';  // Import CategoryRepository
import 'package:medapp/data/category/model/category.dart';

import '../../../data/category_network/model/category.dart';
import '../repository/category_network_repo.dart';  // Import CategoryModel

class GetCategoriesNetworkUsecase {


  // No need for NoParams class if no parameters are required
  Future<Either<Failure, List<CategoryNetworkModel>>> call() async {
    return await getIt<CategoryNetworkRepository>().getNetworkCategories();
  }
}
