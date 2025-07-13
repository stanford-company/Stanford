import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../data/cart/model/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, OrderModel>> createOrder({
    required String phone,
    required List<Map<String, dynamic>> items,
  });
}