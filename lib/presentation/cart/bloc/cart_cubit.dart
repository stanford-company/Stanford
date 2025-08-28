import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/cart/service/cart_service.dart';
import '../pages/cart_storage.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<Map<String, dynamic>> cartItems = [];

  Future<void> loadCart() async {
    emit(CartLoading());
    cartItems = await CartStorage.loadCartItems();
    emit(CartLoaded(cartItems));
  }

  Future<void> addToCart(Map<String, dynamic> item) async {
    cartItems.add(item);
    await CartStorage.saveCartItems(cartItems);
    emit(CartLoaded(cartItems));
  }

  Future<void> clearCart() async {
    await CartStorage.clearCart();
    cartItems.clear();
    emit(CartLoaded(cartItems));
  }

  double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0;
    for (var item in items) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  Future<void> createOrder({
    required String phone,
    required List<Map<String, dynamic>> items,
  }) async {
    emit(CartLoading());

    try {
      final totalPrice = calculateTotalPrice(items);

      final orderData = {
        'phone_beneficiary': phone,
        'items': items,
        'total_price': totalPrice,
      };

      final order = await getIt<CartService>().createOrder(
        phone: phone,
        items: items,
      );

      print("Order Response: $order");

      await clearCart();
      emit(CartSuccess(order));
    } catch (e) {
      print("Order Error: $e");
      emit(CartFailure("Order failed: $e"));
    }
  }

  Future<void> removeItem(int index) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      await CartStorage.saveCartItems(cartItems);
      emit(CartLoaded(cartItems));
    }
  }
}
