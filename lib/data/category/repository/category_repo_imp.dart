import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/auth/model/check_id.dart';
import 'package:medapp/domain/auth/repository/auth_repo.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';

import '../../../core/utils/setup_service.dart';
import '../model/category.dart';
import '../service/category.dart';

class CategoryRepositoryImp extends CategoryRepository{


  Future<Either<Failure, List<CategoryModel>>> getNetworkCategories() async {
    try {
      List<CategoryModel> categories = await getIt<CategoryService>().getCategory();
      return Right(categories);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
