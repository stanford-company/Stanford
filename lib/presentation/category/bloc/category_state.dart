part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
final class CategoryLoading extends CategoryState {}
final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final String categoryId;
  CategoryLoaded(this.categories, this.categoryId);
}
final class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}
