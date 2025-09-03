import 'package:flutter/cupertino.dart';

class SportsModels {
  final int id;
  final String name;
  final IconData icon;
  final int type;

  SportsModels({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });

  factory SportsModels.fromJson(Map<String, dynamic> json) {
    return SportsModels(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      type: json['type'],
    );
  }
}