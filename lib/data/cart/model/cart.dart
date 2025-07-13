 class OrderModel {
  final int orderId;
  final String phoneBeneficiary;
  final double totalPrice;
  final String status;
  final List<OrderItemModel> items;

  OrderModel({
    required this.orderId,
    required this.phoneBeneficiary,
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json['order_id'],
    phoneBeneficiary: json['phone_beneficiary'],
    totalPrice: (json['total_price'] as num).toDouble(),
    status: json['status'],
    items: (json['items'] as List)
        .map((item) => OrderItemModel.fromJson(item))
        .toList(),
  );
}

 class OrderItemModel {
  final int id;
  final int medicalSupplyOrderId;
  final int medicalSupplyId;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItemModel({
    required this.id,
    required this.medicalSupplyOrderId,
    required this.medicalSupplyId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json['id'],
    medicalSupplyOrderId: json['medical_supply_order_id'],
    medicalSupplyId: json['medical_supply_id'],
    quantity: json['quantity'],
    price: (json['price'] as num).toDouble(),
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );
}