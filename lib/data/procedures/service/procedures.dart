
import 'package:medapp/core/services/api_service.dart';
import '../model/procedures.dart';

abstract class ProcedureService {
  Future<List<ProcedureModel>> procedures();
}

class ProcedureServiceImp extends ProcedureService {
  final ApiService apiService;

  ProcedureServiceImp(this.apiService);

  @override
  Future<List<ProcedureModel>> procedures() async {
    final data = await apiService.get(endPoint: "procedures");
    return (data['data'] as List)
        .map((e) => ProcedureModel.fromJson(e))
        .toList();
  }
}