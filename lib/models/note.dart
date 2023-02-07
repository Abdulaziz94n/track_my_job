import 'dart:convert';

import '../../core/enums/note_priority.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final NotePriority priority;
  final String createdAt;
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.createdAt,
  });

  Note copyWith({
    String? id,
    String? title,
    String? description,
    NotePriority? priority,
    String? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.type,
      'createdAt': createdAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: NotePriority.fromString(map['priority']),
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, priority: $priority, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        createdAt.hashCode;
  }
}
