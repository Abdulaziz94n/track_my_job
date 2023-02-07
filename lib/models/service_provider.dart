import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/enums/services.dart';

class ServiceProvider {
  final String id;
  final String name;
  final List<Services> services;
  ServiceProvider({
    required this.id,
    required this.name,
    required this.services,
  });

  ServiceProvider copyWith({
    String? id,
    String? name,
    List<Services>? services,
  }) {
    return ServiceProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'services': services.map((x) => x.type).toList(),
    };
  }

  factory ServiceProvider.fromMap(Map<String, dynamic> map) {
    return ServiceProvider(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      services: List<String>.from(map['services'])
          .map((e) => Services.fromString(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceProvider.fromJson(String source) =>
      ServiceProvider.fromMap(json.decode(source));

  @override
  String toString() =>
      'ServiceProvider(id: $id, name: $name, services: $services)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceProvider &&
        other.name == name &&
        other.id == id &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ services.hashCode;
}
