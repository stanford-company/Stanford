import 'package:medapp/core/services/api_service.dart';

import '../model/check_id.dart';

abstract class AuthService{
  Future<CheckIdModel>checkId({required String nationalId});

}
class AuthServiceImp extends AuthService{
  final ApiService apiService;

  AuthServiceImp(this.apiService);
  @override
  Future<CheckIdModel> checkId({required String nationalId})async {
    var data = await apiService.post(
        endPoint: "beneficiaries/check-id", body: {"national_id":nationalId});
    print(data);
    CheckIdModel checkIdModel = CheckIdModel.fromJson(data["data"]);
    return checkIdModel;

  }

  @override
  Future<dynamic> login({required user}) {
    // TODO: implement login
    throw UnimplementedError();
  }
}