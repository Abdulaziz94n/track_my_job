import 'dart:convert';

import 'package:flutter/foundation.dart';

class Noter {
  final String id;
  Map<String, int>? monthlyProfits;
  Noter({
    required this.id,
    this.monthlyProfits,
  });

  Noter copyWith({
    String? id,
    Map<String, int>? monthlyProfits,
  }) {
    return Noter(
      id: id ?? this.id,
      monthlyProfits: monthlyProfits ?? this.monthlyProfits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monthly profits': monthlyProfits ?? {},
    };
  }

  factory Noter.fromMap(Map<String, dynamic> map) {
    return Noter(
      id: map['id'] ?? '',
      monthlyProfits: map['monthly profits'] == null
          ? null
          : Map<String, int>.from(map['monthly profits']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Noter.fromJson(String source) => Noter.fromMap(json.decode(source));

  @override
  String toString() => 'Noter(id: $id, monthly profits: $monthlyProfits)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Noter &&
        other.id == id &&
        mapEquals(other.monthlyProfits, monthlyProfits);
  }

  @override
  int get hashCode => id.hashCode ^ monthlyProfits.hashCode;
}
