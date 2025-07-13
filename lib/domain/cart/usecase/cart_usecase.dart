import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';

import '../../../data/cart/model/cart.dart';
import '../repository/cart_rpeo.dart';

class CreateOrderUsecase {
  Future<Either<Failure, OrderModel>> call({
    required String phone,
    required List<Map<String, dynamic>> items,
  }) async {
    return await getIt<CartRepository>().createOrder(
      phone: phone,
      items: items,
    );
  }
}
