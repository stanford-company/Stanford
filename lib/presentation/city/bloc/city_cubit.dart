import 'package:bloc/bloc.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/city/usecase/city_usecase.dart';
import '../../../data/cities/model/city.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  List<CityModel> _cities = [];
  Set<int> _selectedCityIds = {};

  CityCubit() : super(CityInitial());

  Future<void> getCities() async {
    emit(CityLoading());
    var result = await getIt<GetCitiesUsecase>().call();
    result.fold(
          (failure) {
        print(failure.message);
        emit(CityFailure(failure.message));
      },
          (cities) {
        _cities = cities;
        emit(CityLoaded(cities: _cities, selectedCityIds: _selectedCityIds));
      },
    );
  }

  void toggleCitySelection(int cityId) {
    if (_selectedCityIds.contains(cityId)) {
      _selectedCityIds.remove(cityId);
    } else {
      _selectedCityIds.add(cityId);
    }
    emit(CityLoaded(cities: _cities, selectedCityIds: _selectedCityIds));
  }
}
