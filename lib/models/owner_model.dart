class Owner {
  final String name, image, phone, address, email;
  String? id, creatorId;

  Owner({
    this.id,
    this.creatorId,
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  static Owner fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      creatorId: json['creatorId'],
      image: json['image'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Owner copyWith({
    String? id,
    String? image,
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return Owner(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
