import 'package:flutter/material.dart';

class PeriodeModels {
  final int id;
  final String name;
  final String description;

  PeriodeModels({
    required this.id,
    required this.name,
    required this.description,
  });

  factory PeriodeModels.fromJson(Map<String, dynamic> json) {
    return PeriodeModels(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}