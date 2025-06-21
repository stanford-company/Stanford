import 'package:medapp/core/services/api_service.dart';
import '../model/about_us_model.dart';
import '../model/procedures.dart';

abstract class AppService {
  Future<List<ProcedureModel>> procedures();
  Future<AboutUsModel> getAboutUs();
}

class AppServiceImp extends AppService {
  final ApiService apiService;

  AppServiceImp(this.apiService);

  @override
  Future<List<ProcedureModel>> procedures() async {
    final data = await apiService.get(endPoint: "procedures");
    return (data['data'] as List)
        .map((e) => ProcedureModel.fromJson(e))
        .toList();
  }

  @override
  Future<AboutUsModel> getAboutUs() async {
    final data = await apiService.get(endPoint: "contact-us");
    return AboutUsModel.fromJson(data['data']);
  }
}
