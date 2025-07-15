class CategoryNetworkModel {
  final int id;
  final String nameAr;
  final String nameEn;

  CategoryNetworkModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory CategoryNetworkModel.fromJson(Map<String, dynamic> json) {
    return CategoryNetworkModel(
      id: json['id'] ?? 0,
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
  };
}
