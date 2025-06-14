class ProcedureModel {
  final int id;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final String pdfUrl;

  ProcedureModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.pdfUrl,
  });

  factory ProcedureModel.fromJson(Map<String, dynamic> json) {
    return ProcedureModel(
      id: json['id'],
      titleEn: json['title_en'],
      titleAr: json['title_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      pdfUrl: json['pdf_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'pdf_url': pdfUrl,
    };
  }
}