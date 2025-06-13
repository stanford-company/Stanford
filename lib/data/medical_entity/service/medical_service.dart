import 'package:medapp/core/services/api_service.dart';

import '../model/medical_doctor.dart';
import '../model/medical_entity.dart';

abstract class MedicalService {
  Future<List<MedicalEntityModel>> getMedicalEntity({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  });
  Future<List<MedicalDoctor>> getMedicalDoctor();
}

class MedicalServiceImp extends MedicalService {
  final ApiService apiService;

  MedicalServiceImp(this.apiService);

  @override
  Future<List<MedicalEntityModel>> getMedicalEntity({
    int? cityId,
    int? medicalCategoryId,
    String? name,
    int? page,
  }) async {
    final queryParams = {
      if (cityId != null) 'city_id': cityId.toString(),
      if (medicalCategoryId != null)
        'medical_category_id': medicalCategoryId.toString(),
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

  @override
  Future<List<MedicalDoctor>> getMedicalDoctor() async {
    var data = await apiService.get(endPoint: "adds/medical-doctores");

    List<MedicalDoctor> medicalDoctors = [];
    for (var doc in data['data']) {
      medicalDoctors.add(MedicalDoctor.fromJson(doc));
    }
    return medicalDoctors;
  }
}
