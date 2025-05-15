class Address {
  final int? id;
  final String name;
  final String phone;
  final String address;
  final int zipcode;
  final String city;
  final String country;
  final String? user_uid;

  Address({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.zipcode,
    required this.city,
    required this.country,
    this.user_uid,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: int.parse(json['id']),
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      zipcode: int.parse(json['zipcode']),
      city: json['city'],
      country: json['country'],
      user_uid: json['user_uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'zipcode': zipcode,
      'city': city,
      'country': country,
      'user_uid': user_uid,
    };
  }
}
