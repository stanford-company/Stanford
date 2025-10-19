part of 'store_cubit.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class StoreSupplyLoading extends StoreState {}

final class StoreSupplyLoaded extends StoreState {
  final List<SuppliesModel> supplies;
  final List<SuppliesModel> filteredSupplies;
  final String searchQuery;

  StoreSupplyLoaded(
    this.supplies, {
    List<SuppliesModel>? filteredSupplies,
    this.searchQuery = '',
  }) : filteredSupplies = filteredSupplies ?? supplies;

  List<SuppliesModel> get displaySupplies =>
      searchQuery.isEmpty ? supplies : filteredSupplies;
}

final class StoreSupplyFailure extends StoreState {}
