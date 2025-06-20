class ProfileModel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String nationalId;
  final String gender;
  final String company;
  final bool isActive;
  final String createdAt;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.gender,
    required this.company,
    required this.isActive,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      nationalId: json['national_id'],
      gender: json['gender'],
      company: json['company'],
      isActive: json['is_active'] == 1,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'national_id': nationalId,
      'gender': gender,
      'company': company,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt,
    };
  }
}
