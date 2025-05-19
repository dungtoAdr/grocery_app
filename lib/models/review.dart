class Review {
  final int? id;
  final String content;
  final double rates;
  final String user_uid;
  final int product_id;
  final String? user_name;

  Review({
    this.id,
    required this.content,
    required this.rates,
    required this.user_uid,
    required this.product_id,
    this.user_name,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: int.parse(json['id']),
      content: json['content'],
      rates: double.parse(json['rates']),
      user_uid: json['user_uid'],
      product_id: int.parse(json['product_id']),
      user_name: json['user_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'rates': rates,
      'user_uid': user_uid,
      'product_id': product_id,
      'user_name': user_name,
    };
  }
}
