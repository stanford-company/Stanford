import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<void> createOrder({
    required String phone,
    required List<Map<String, dynamic>> items,
  }) async {
    emit(CartLoading());

    try {
      await Future.delayed(Duration(seconds: 2));

      final fakeOrder = {
        'items': items,
      };

      print("Order Response: $fakeOrder");

      await clearCart();
      emit(CartSuccess(fakeOrder));
    } catch (e) {
      print("Order Error: $e");
      emit(CartFailure("Order failed: $e"));
    }
  }

}
