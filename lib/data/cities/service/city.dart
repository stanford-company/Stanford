 import 'package:medapp/core/services/api_service.dart';

import '../model/city.dart';
 abstract class CityService{
  Future<List<CityModel>>getCity();
}

class CityServiceImp extends CityService{
  final ApiService apiService;

  CityServiceImp(this.apiService);

  @override
  Future<List<CityModel>> getCity() async {
    var data = await apiService.get(
        endPoint: "medical/cities");

    print(data);
    List<CityModel> cities = [];
    for (var cat in data['data']) {
      CityModel cityModel = CityModel.fromJson(cat);
      cities.add(cityModel);
    }
    return cities;
  }
}
