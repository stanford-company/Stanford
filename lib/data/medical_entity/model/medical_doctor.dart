class MedicalModel {
  final int id;
  final String title;
  final String medicalName;
  final String description;
  final String address;
  final String addressAr;
  final int status;
  final String startDate;
  final String endDate;
  final int sortOrder;
  final String imageUrl;
  final String categoryEn;
  final String categoryAr;

  MedicalModel({
    required this.id,
    required this.title,
    required this.medicalName,
    required this.description,
    required this.address,
    required this.addressAr,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.sortOrder,
    required this.imageUrl,
    required this.categoryEn,
    required this.categoryAr,
  });

  factory MedicalModel.fromJson(Map<String, dynamic> json) {
    return MedicalModel(
      id: json['id'],
      title: json['title'],
      medicalName: json['medical_name'],
      description: json['description'],
      status: json['status'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      sortOrder: json['sort_order'],
      imageUrl: json['image_url'],
      categoryEn: json['category_en'],
      categoryAr: json['category_ar'],
      address: json['address'],
      addressAr: json['address_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'medical_name': medicalName,
      'description': description,
      'status': status,
      'start_date': startDate,
      'end_date': endDate,
      'sort_order': sortOrder,
      'image_url': imageUrl,
      'category_en': categoryEn,
      'category_ar': categoryAr,
    };
  }
}
