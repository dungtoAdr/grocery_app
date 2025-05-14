class ProfileUser {
  final int? id;
  final String name;
  final String gmail;
  final String phone;
  final String uid;

  ProfileUser({
    this.id,
    required this.name,
    required this.gmail,
    required this.phone,
    required this.uid,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: int.parse(json['id']),
      name: json['name'],
      gmail: json['gmail'],
      phone: json['phone'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'gmail': gmail, 'phone': phone, 'uid': uid};
  }
}
