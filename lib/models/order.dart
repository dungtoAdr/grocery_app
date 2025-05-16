import 'package:grocery_app/models/order_detail.dart';

class Order {
  final int? id;
  final String uid;
  final int address_id;
  final int status;
  final double total;
  final List<OrderDetail> details;

  Order({
    this.id,
    required this.uid,
    required this.address_id,
    required this.status,
    required this.total,
    required this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      uid: json['user_uid'],
      address_id: json['address_id'],
      status: json['status'],
      total: (json['total'] as num).toDouble(),
      details:
          (json['details'] as List)
              .map((item) => OrderDetail.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_uid': uid,
      'address_id': address_id,
      'status': status,
      'total': total,
      'details': details.map((d) => d.toJson()).toList(),
    };
  }
}
