import 'package:dio/dio.dart';
import 'package:medapp/core/services/api_service.dart';
import 'package:medapp/data/category/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
abstract class CategoryService{
  Future<List<CategoryModel>>getCategory();
}

class CategoryServiceImp extends CategoryService{
  final ApiService apiService;

  CategoryServiceImp(this.apiService);

  @override
  Future<List<CategoryModel>> getCategory() async {
    var data = await apiService.get(
        endPoint: "medical/categories-book-now");

    print(data);
    List<CategoryModel> categories = [];
    for (var cat in data['data']) {
      CategoryModel categoryModel = CategoryModel.fromJson(cat);
      categories.add(categoryModel);
    }
    return categories;
  }
}
