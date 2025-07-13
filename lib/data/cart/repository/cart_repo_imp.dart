// 4. CartRepository
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medapp/core/errors/failure.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/cart/repository/cart_rpeo.dart';
import '../model/cart.dart';
import '../service/cart_service.dart';

class CartRepositoryImp extends CartRepository {
  @override
  Future<Either<Failure, OrderModel>> createOrder({
    required String phone,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      final order = await getIt<CartService>().createOrder(
        phone: phone,
        items: items,
      );
      return Right(order);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}