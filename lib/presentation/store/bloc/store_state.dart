part of 'store_cubit.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class StoreSupplyLoading extends StoreState {}

final class StoreSupplyLoaded extends StoreState {
  final List<SuppliesModel> supplies;

  StoreSupplyLoaded(this.supplies);
}

final class StoreSupplyFailure extends StoreState {}
