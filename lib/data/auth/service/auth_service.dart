import 'package:medapp/core/services/api_service.dart';
import '../model/check_id.dart';
import '../model/login.dart';
import '../model/logout.dart';
import '../model/register.dart';

abstract class AuthService {
  Future<CheckIdModel> checkId({required String nationalId});

  Future<UserParams> login(String nationalId, String password);

  Future<LogoutModel> logout({required String token});

  Future<UserParams> register(String nationalId, String email, String password);

  Future<UserParams> forgotPassword(
    String nationalId,
    String confirmPassword,
    String password,
  );
}

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
  Future<UserParams> register(
    String nationalId,
    String email,
    String password,
  ) async {
    final data = await apiService.post(
      endPoint: "beneficiaries/register",
      body: {"national_id": nationalId, "email": email, "password": password},
    );
    return UserParams.fromJson(data); // ✅ parse like login
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

  @override
  Future<UserParams> forgotPassword(
    String nationalId,
    String confirmPassword,
    String password,
  ) async {
    var data = await apiService.post(
      endPoint: "beneficiaries/forgot-password",
      body: {
        "national_id": nationalId,
        "password": password,
        "password_confirmation": confirmPassword,
      },
    );

    print("🔐 Forgot password API raw response: $data");

    return UserParams.fromJson(data["data"]);
  }
}
