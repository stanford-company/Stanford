class SuppliesModel {
  final int id;
  final String nameAr;
  final String? nameEn;
  final String descriptionAr;
  final String? descriptionEn;
  final String price;
  final List<SupplyImage> images;
  final String createdAt;

  SuppliesModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.images,
    required this.createdAt,
  });

  factory SuppliesModel.fromJson(Map<String, dynamic> json) {
    return SuppliesModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: json['price'],
      images: (json['images'] as List)
          .map((imageJson) => SupplyImage.fromJson(imageJson))
          .toList(),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'price': price,
      'images': images.map((img) => img.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}

class SupplyImage {
  final int id;
  final String imageUrl;

  SupplyImage({required this.id, required this.imageUrl});

  factory SupplyImage.fromJson(Map<String, dynamic> json) {
    return SupplyImage(id: json['id'], imageUrl: json['image_url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image_url': imageUrl};
  }
}
