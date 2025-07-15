import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/category_network/model/category.dart';
import 'package:medapp/data/category_network/service/category.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/category_network/repository/category_network_repo.dart';

class CategoryNetworkRepositoryImp extends CategoryNetworkRepository {
  @override
  Future<Either<Failure, List<CategoryNetworkModel>>> getNetworkCategories() async {
    try {
      List<CategoryNetworkModel> categories =
      await getIt<CategoryNetworkService>().getNetworkCategory();
      return Right(categories);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
