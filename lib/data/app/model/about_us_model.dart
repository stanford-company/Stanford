class AboutUsModel {
  final String addressAr;
  final String addressEn;
  final String phone1;
  final String phone2;
  final String email;
  final List<Officer> officers;

  AboutUsModel({
    required this.addressAr,
    required this.addressEn,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.officers,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      addressAr: json['address_ar'],
      addressEn: json['address_en'],
      phone1: json['phone_1'],
      phone2: json['phone_2'],
      email: json['email'],
      officers: List<Officer>.from(
        json['officers'].map((x) => Officer.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_ar': addressAr,
      'address_en': addressEn,
      'phone_1': phone1,
      'phone_2': phone2,
      'email': email,
      'officers': officers.map((x) => x.toJson()).toList(),
    };
  }
}

class Officer {
  final String nameAr;
  final String nameEn;
  final String phoneNumber;
  final String addressAr;
  final String addressEn;

  Officer({
    required this.nameAr,
    required this.nameEn,
    required this.phoneNumber,
    required this.addressAr,
    required this.addressEn,
  });

  factory Officer.fromJson(Map<String, dynamic> json) {
    return Officer(
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      phoneNumber: json['phone_number'],
      addressAr: json['address_ar'],
      addressEn: json['address_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'phone_number': phoneNumber,
      'address_ar': addressAr,
      'address_en': addressEn,
    };
  }
}
