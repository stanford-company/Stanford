part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Map<String, dynamic>> items;
  CartLoaded(this.items);
}

class CartSuccess extends CartState {
  final dynamic order;
  CartSuccess(this.order);
}

class CartFailure extends CartState {
  final String message;
  CartFailure(this.message);
}

