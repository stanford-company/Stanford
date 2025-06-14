part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<MedicalEntityModel> medicalEntity;

  SearchLoaded(this.medicalEntity);
}

final class SearchFailure extends SearchState {}
