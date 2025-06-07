import 'package:medapp/core/services/api_service.dart';

import '../model/medical_entity.dart';

abstract class MedicalEntityService {
  Future<List<MedicalEntityModel>> getMedicalEntity({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  });
}

class MedicalEntityServiceImp extends MedicalEntityService {
  final ApiService apiService;

  MedicalEntityServiceImp(this.apiService);

  @override
  Future<List<MedicalEntityModel>> getMedicalEntity({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  }) async {
    final queryParams = {
      if (cityId != null) 'city_id': cityId.toString(),
      if (medicalCategoryId != null) 'medical_category_id': medicalCategoryId.toString(),
      if (name != null && name.isNotEmpty) 'name': name,
      if (page != null) 'page': page.toString(),
    };
    print('📦 Sending queryParams to API: $queryParams');


    var data = await apiService.get(
      endPoint: "medical/entities/filter",
      params: queryParams,
    );
    print('📦 Sending queryParams to API: $queryParams');


    List<MedicalEntityModel> entityModels = [];
    for (var cat in data['data']) {
      entityModels.add(MedicalEntityModel.fromJson(cat));
    }
    return entityModels;
  }
}

