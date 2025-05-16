class OrderDetail {
  final int? id;
  final int product_id;
  final double sub_total;
  final int quantity;
  final int? order_id;
  final String? product_name;
  final String? product_image;

  OrderDetail({
    this.id,
    required this.product_id,
    required this.sub_total,
    required this.quantity,
     this.order_id,
     this.product_name,
     this.product_image,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      product_id: json['product_id'],
      sub_total: (json['sub_total'] as num).toDouble(),
      quantity: json['quantity'],
      order_id: json['order_id'],
      product_name: json['product_name'],
      product_image: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': product_id,
      'sub_total': sub_total,
      'quantity': quantity,
      'order_id': order_id,
      'product_name': product_name,
      'product_image': product_image,
    };
  }
}
