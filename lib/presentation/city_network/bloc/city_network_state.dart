import 'package:medapp/data/cities/model/city.dart';

import '../../../data/cities_network/model/city.dart';


abstract class CityNetworkState {}

class CityNetworkInitial extends CityNetworkState {}

class CityNetworkLoading extends CityNetworkState {}

class CityNetworkLoaded extends CityNetworkState {
  final List<CityNetworkModel> cities;
  final String cityId; // Add cityId field

  CityNetworkLoaded(this.cities, this.cityId);
}

class CityNetworkError extends CityNetworkState {
  final String errorMessage;

  CityNetworkError(this.errorMessage);
}
