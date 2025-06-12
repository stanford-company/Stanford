import 'package:bloc/bloc.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/city/usecase/city_usecase.dart';
import '../../../data/cities/model/city.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  String cityId ="";
  List<CityModel> _cities=[];

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
            _cities= cities;
        emit(CityLoaded( cities,""));
      },
    );
  }

  void toggleCitySelection(String cityId) {

    emit(CityLoaded(_cities,cityId));
  }
}
