class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String nationalId;
  final String phone;
  final String gender;
  final String signUpStatus;
  final int isActive;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.nationalId,
    required this.phone,
    required this.gender,
    required this.signUpStatus,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      fullName: json['full_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      nationalId: json['national_id']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      signUpStatus: json['sign_up_status']?.toString().toLowerCase() ?? 'no',
      isActive: json['is_active'] as int? ?? 0,
    );
  }
}