import 'package:medapp/core/services/api_service.dart';
import '../model/check_id.dart';
import '../model/login.dart';
import '../model/logout.dart';

abstract class AuthService {
  Future<CheckIdModel> checkId({required String nationalId});

  Future<UserParams> login(String nationalId, String password);

  Future<LogoutModel> logout({required String token});

  Future<UserParams> register(String nationalId, String email, String password);
}

// Add this below your abstract class
class AuthServiceImp extends AuthService {
  final ApiService apiService;

  AuthServiceImp(this.apiService);

  @override
  Future<CheckIdModel> checkId({required String nationalId}) async {
    var data = await apiService.post(
      endPoint: "beneficiaries/check-id",
      body: {"national_id": nationalId},
    );
    print(data);
    CheckIdModel checkIdModel = CheckIdModel.fromJson(data["data"]);
    return checkIdModel;
  }

  @override
  Future<UserParams> register(String nationalId, String email, String password) async {
    final data = await apiService.post(
      endPoint: "beneficiaries/register",
      body: {
        "national_id": nationalId,
        "email": email,
        "password": password,
      },
    );
    return UserParams.fromJson(data);
  }

  // Replace login method with this
  @override
  Future<UserParams> login(String nationalId, String password) async {
    var data = await apiService.post(
      endPoint: "beneficiaries/login",
      body: {"national_id": nationalId, "password": password},
    );

    print(data);
    return UserParams.fromJson(data);
  }

  @override
  Future<LogoutModel> logout({required String token}) async {
    var data = await apiService.post(
      endPoint: "beneficiaries/logout",
      body: {},
    );
    return LogoutModel.fromJson(data);
  }
}
