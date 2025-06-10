class AdItem {
  final String id;
  final String imageUrl;
  final int sortOrder;

  AdItem({
    required this.id,
    required this.imageUrl,
    required this.sortOrder,
  });

  factory AdItem.fromJson(Map<String, dynamic> json) {
    return AdItem(
      id: json['id'].toString(),
      imageUrl: json['image_url'] ?? '',
      sortOrder: json['sort_order'] ?? 0,
    );
  }
}

class AdsModel {
  final List<AdItem> ads;

  AdsModel({required this.ads});

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] ?? [];
    final List<AdItem> ads = dataList.map((e) => AdItem.fromJson(e)).toList();
    return AdsModel(ads: ads);
  }
}

