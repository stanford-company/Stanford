import 'package:medapp/core/services/api_service.dart';
import 'package:medapp/data/category_network/model/category.dart';

abstract class CategoryNetworkService {
  Future<List<CategoryNetworkModel>> getNetworkCategory();
}

class CategoryNetworkServiceImp extends CategoryNetworkService {
  final ApiService apiService;

  CategoryNetworkServiceImp(this.apiService);

  @override
  Future<List<CategoryNetworkModel>> getNetworkCategory() async {
    var data = await apiService.get(endPoint: "medical/categories");

    print(data);
    List<CategoryNetworkModel> categoriesNetwork = [];
    for (var cat in data['data']) {
      CategoryNetworkModel categoryNetworkModel = CategoryNetworkModel.fromJson(cat);
      categoriesNetwork.add(categoryNetworkModel);
    }
    return categoriesNetwork;
  }
}
