class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String weighed;
  final int category_id;
  int quantity;
  final bool isNew;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.weighed,
    required this.category_id,
    required this.quantity,
    required this.isNew,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: int.parse(map['id']),
      name: map['name'],
      price: double.parse(map['price']),
      image: map['image'],
      weighed: map['weighed'],
      category_id: int.parse(map['category_id']),
      quantity: map['quantity'] ?? 0,
      isNew: map['is_new'] == "1",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'weighed': weighed,
      'category_id': category_id,
      'quantity': quantity,
      'isNew': isNew,
    };
  }

  double totalPrice() {
    return price * quantity;
  }
}
