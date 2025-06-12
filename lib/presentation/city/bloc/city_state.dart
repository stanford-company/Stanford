import '../../../data/cities/model/city.dart';

sealed class CityState {}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {
  final List<CityModel> cities;
  final String cityId ;


  CityLoaded(this.cities, this.cityId);


}

final class CityFailure extends CityState {
  final String message;
  CityFailure(this.message);
}
