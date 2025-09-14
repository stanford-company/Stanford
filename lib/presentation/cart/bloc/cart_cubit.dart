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
    emit(CartLoaded(items: cartItems));
  }

  Future<void> addToCart(Map<String, dynamic> item) async {
    final index = cartItems.indexWhere(
      (cartItem) => cartItem['medical_supply_id'] == item['medical_supply_id'],
    );
    print("Adding to cart: $item");
    print("index: $index");
    if (index != -1) {
      cartItems[index]['quantity'] += item['quantity'] ?? 1;
    } else {
      cartItems.add({...item, 'quantity': item['quantity'] ?? 1});
    }
    await CartStorage.saveCartItems(cartItems);
    print("Cart Items: $cartItems");
    emit(CartLoaded(items: cartItems));
  }

  Future<void> clearCart() async {
    await CartStorage.clearCart();
    cartItems.clear();
    emit(CartLoaded(items: cartItems));
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
      emit(CartLoaded(items: cartItems));
    }
  }
}
