import 'package:medapp/core/services/api_service.dart';

import '../model/check_id.dart';
import '../model/login.dart';

abstract class AuthService{
  Future<CheckIdModel>checkId({required String nationalId});
  Future<UserParams>login(UserParams user);

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
  Future<UserParams> login(UserParams user ) async {
    var data = await apiService.post(
      endPoint: "beneficiaries/login", );

    print(data);
    UserParams userParams = UserParams.fromJson(data["data"]);
    return userParams;
  }


}