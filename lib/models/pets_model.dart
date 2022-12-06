import 'package:flutter/foundation.dart';

class Pet {
  final String? id, creatorId;
  final String color;
  final String name, location, type, sex, image, description;
  final double age, weight;
  final int distance;
  final ValueNotifier<bool> _fav;

  Pet({
    this.id,
    this.creatorId,
    required this.image,
    required this.color,
    required this.description,
    required this.type,
    required this.name,
    required this.location,
    required this.sex,
    required this.age,
    required this.weight,
    required this.distance,
    fav = false,
  }) : _fav = ValueNotifier(fav);

  set isFavorite(bool newValue) {
    _fav.value = newValue;
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'color': color,
      'description': description,
      'type': type,
      'name': name,
      'location': location,
      'sex': sex,
      'age': age,
      'weight': weight,
      'distance': distance,
    };
  }

  static Pet fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      creatorId: json['creatorId'],
      image: json['image'],
      color: json['color'],
      description: json['description'],
      type: json['type'],
      name: json['name'],
      location: json['location'],
      sex: json['sex'],
      age: json['age'],
      weight: json['weight'],
      distance: json['distance'],
    );
  }

  bool get isFavorite {
    return _fav.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _fav;
  }

  Pet copyWith({
    String? id,
    String? creatorId,
    String? image,
    String? color,
    String? description,
    String? type,
    String? name,
    String? location,
    String? sex,
    double? age,
    double? weight,
    int? distance,
    bool? fav,
  }) {
    return Pet(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      image: image ?? this.image,
      color: color ?? this.color,
      description: description ?? this.description,
      type: type ?? this.type,
      name: name ?? this.name,
      location: location ?? this.location,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      distance: distance ?? this.distance,
      fav: fav ?? isFavorite,
    );
  }
}
