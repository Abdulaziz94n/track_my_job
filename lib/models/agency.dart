import 'dart:convert';

class Agency {
  Agency({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory Agency.fromMap(Map<String, dynamic> map) {
    return Agency(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Agency.fromJson(String source) => Agency.fromMap(json.decode(source));

  @override
  String toString() => 'Agency(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Agency && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;

  Agency copyWith({
    String? name,
    String? id,
  }) {
    return Agency(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
