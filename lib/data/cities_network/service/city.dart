import '../../../core/services/api_service.dart';
import '../model/city.dart';

abstract class CityNetworkService {
  Future<List<CityNetworkModel>> getNetworkCity();
}

class CityNetworkServiceImp implements CityNetworkService {
  final ApiService apiService;

  CityNetworkServiceImp(this.apiService);

  @override
  Future<List<CityNetworkModel>> getNetworkCity() async {
    var data = await apiService.get(
        endPoint: "medical/cities");

    print(data);
    List<CityNetworkModel> cities = [];
    for (var cat in data['data']) {
      CityNetworkModel cityModel = CityNetworkModel.fromJson(cat);
      cities.add(cityModel);
    }
    return cities;
  }
}
