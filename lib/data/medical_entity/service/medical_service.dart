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
  Future<List<MedicalModel>> getMedicalDoctor();
  Future<List<MedicalModel>> getMedicalCenter();
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
  Future<List<MedicalModel>> getMedicalDoctor() async {
    var data = await apiService.get(endPoint: "adds/medical-doctores");

    List<MedicalModel> medicalDoctors = [];
    for (var doc in data['data']) {
      medicalDoctors.add(MedicalModel.fromJson(doc));
    }
    return medicalDoctors;
  }

  @override
  Future<List<MedicalModel>> getMedicalCenter() async {
    var data = await apiService.get(endPoint: "adds/medical-center");

    List<MedicalModel> medicalCenters = [];
    for (var doc in data['data']) {
      medicalCenters.add(MedicalModel.fromJson(doc));
    }
    return medicalCenters;
  }
}
