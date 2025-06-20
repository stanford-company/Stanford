import 'package:medapp/core/services/api_service.dart';
import 'package:medapp/data/store/model/supplies_model.dart';

abstract class StoreService {
  Future<List<SuppliesModel>> getMedicalSupplies();
}

class StoreServiceImp extends StoreService {
  final ApiService apiService;

  StoreServiceImp(this.apiService);

  @override
  Future<List<SuppliesModel>> getMedicalSupplies() async {
    var data = await apiService.get(endPoint: "medical-supplies");

    print(data);
    List<SuppliesModel> supplies = [];
    for (var supply in data['data']['data']) {
      SuppliesModel suppliesModel = SuppliesModel.fromJson(supply);
      supplies.add(suppliesModel);
    }
    return supplies;
  }
}
