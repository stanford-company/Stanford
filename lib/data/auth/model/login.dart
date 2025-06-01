class UserParams {
  final UserData data;
  final String status;
  final String apiToken;

  UserParams({
    required this.data,
    required this.status,
    required this.apiToken,
  });

  factory UserParams.fromJson(Map<String, dynamic> json) {
    return UserParams(
      data: UserData.fromJson(json['data']),
      status: json['status'] ?? '',
      apiToken: json['api_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'status': status,
      'api_token': apiToken,
    };
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
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      nationalId: json['national_id'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      signUpStatus: json['sign_up_status'] ?? '',
      isActive: json['is_active'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'national_id': nationalId,
      'phone': phone,
      'gender': gender,
      'sign_up_status': signUpStatus,
      'is_active': isActive,
    };
  }
}




