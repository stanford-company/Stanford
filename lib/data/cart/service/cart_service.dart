// 3. CartService
import 'package:dio/dio.dart';
import 'package:medapp/core/services/api_service.dart';

import '../model/cart.dart';

abstract class CartService {
  Future<OrderModel> createOrder({
    required String phone,
    required List<Map<String, dynamic>> items,
  });
}

class CartServiceImp extends CartService {
  final ApiService apiService;

  CartServiceImp(this.apiService);
  double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0;
    for (var item in items) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  @override
  Future<OrderModel> createOrder({
    required String phone,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await apiService.post(
      endPoint: 'medical-supply-orders',
      body: {
        'phone_beneficiary': phone,
        'items': items,
        'total_price': calculateTotalPrice(items),
      },
    );

    return OrderModel.fromJson(response['data']);
  }
}
