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
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      weighed: map['weighed'],
      category_id: map['category_id'],
      quantity: map['quantity'],
      isNew: map['isNew'],
    );
  }
}
