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
      },
    );
    return OrderModel.fromJson(response['data']);
  }
}