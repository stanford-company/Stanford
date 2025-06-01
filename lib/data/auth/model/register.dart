class RegisterModel {
  final UserData data;
  final String status;
  final String apiToken;

  RegisterModel({
    required this.data,
    required this.status,
    required this.apiToken,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      data: UserData.fromJson(json['data']),
      status: json['status'],
      apiToken: json['api_token'],
    );
  }
}

class UserData {
  final int id;
  final String fullName;
  final String email;
  final String nationalId;
  final String phone;
  final String gender;
  final String signUpStatus;
  final int isActive;

  UserData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.nationalId,
    required this.phone,
    required this.gender,
    required this.signUpStatus,
    required this.isActive,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      nationalId: json['national_id'],
      phone: json['phone'],
      gender: json['gender'],
      signUpStatus: json['sign_up_status'],
      isActive: json['is_active'],
    );
  }
}
