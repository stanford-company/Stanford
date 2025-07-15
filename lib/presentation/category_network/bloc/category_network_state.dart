part of 'category_network_cubit.dart';

@immutable
sealed class CategoryNetworkState {}

final class CategoryNetworkInitial extends CategoryNetworkState {}

final class CategoryNetworkLoading extends CategoryNetworkState {}

final class CategoryNetworkLoaded extends CategoryNetworkState {
  final List<CategoryNetworkModel> categories;

  CategoryNetworkLoaded(this.categories);
}

final class CategoryNetworkFailure extends CategoryNetworkState {
  final String message;

  CategoryNetworkFailure(this.message);
}
