import '../../../data/cities/model/city.dart';

sealed class CityState {}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {
  final List<CityModel> cities;
  final Set<int> selectedCityIds;

  CityLoaded({
    required this.cities,
    required this.selectedCityIds,
  });

  CityLoaded copyWith({
    List<CityModel>? cities,
    Set<int>? selectedCityIds,
  }) {
    return CityLoaded(
      cities: cities ?? this.cities,
      selectedCityIds: selectedCityIds ?? this.selectedCityIds,
    );
  }
}

final class CityFailure extends CityState {
  final String message;
  CityFailure(this.message);
}
