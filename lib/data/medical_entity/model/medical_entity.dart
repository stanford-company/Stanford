class MedicalEntityModel {
  final int id;
  final String name;
  final String nameAr;
  final String address;
  final String addressAr;
  final String? phone1;
  final String? phone2;
  final String? email;
  final String? description;
  final String? descriptionAr;
  final double? latitude;
  final double? longitude;
  final City city;
  final MedicalEntityModel? entity;
  final Category category;
  final List<String> images;
  final String createdAt;

  MedicalEntityModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.address,
    required this.addressAr,
    this.phone1,
    this.phone2,
    this.email,
    this.description,
    this.descriptionAr,
    this.latitude,
    this.longitude,
    required this.city,
    required this.category,
    required this.images,
    required this.createdAt,
    this.entity,
  });

  factory MedicalEntityModel.fromJson(Map<String, dynamic> json) {
    return MedicalEntityModel(
      id: json['id'],
      name: json['name'],
      nameAr: json['name_ar'] ?? '',
      address: json['address'],
      addressAr: json['address_ar'],
      phone1: json['phone_1'],
      phone2: json['phone_2'],
      email: json['email'],
      description: json['description'],
      descriptionAr: json['description_ar'] ?? '',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      city: City.fromJson(json['city']),
      entity: json['entity'] != null
          ? MedicalEntityModel.fromJson(json['entity'])
          : null,
      category: Category.fromJson(json['category']),
      images: List<String>.from(json['images'] ?? []),
      createdAt: json['created_at'],
    );
  }
}


class City {
  final int id;
  final String nameAr;
  final String nameEn;

  City({required this.id, required this.nameAr, required this.nameEn});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
    );
  }
}

class Category {
  final int id;
  final String nameAr;
  final String nameEn;

  Category({required this.id, required this.nameAr, required this.nameEn});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
    );
  }
}
