import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/domain/city_network/usecase/city_usecase.dart';
import 'city_network_state.dart';

class CityNetworkCubit extends Cubit<CityNetworkState> {
  final GetCitiesNetworkUsecase getCitiesNetworkUsecase;

  CityNetworkCubit(this.getCitiesNetworkUsecase) : super(CityNetworkInitial());

  // This will store the selected cityId
  String cityId = '';

  Future<void> fetchCities() async {
    emit(CityNetworkLoading()); // Show loading state
    final result = await getCitiesNetworkUsecase.call();

    result.fold(
      (failure) => emit(CityNetworkError(failure.message)), // Handle failure
      (cities) =>
          emit(CityNetworkLoaded(cities, cityId)), // Pass cityId to state
    );
  }

  // Toggle city selection by cityId
  void toggleCitySelection(String selectedCityId) {
    cityId = cityId == selectedCityId ? '' : selectedCityId; // Toggle selection
    emit(CityNetworkLoaded((state as CityNetworkLoaded).cities, cityId));
  }

  void searchCities(String query) {
    if (state is CityNetworkLoaded) {
      final allCities = (state as CityNetworkLoaded).cities;
      final filteredCities = allCities.where((city) {
        return city.nameAr.toLowerCase().contains(query.toLowerCase()) ||
            city.nameEn.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(CityNetworkLoaded(filteredCities, cityId));
    }
  }
}
