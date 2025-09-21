import 'package:flutter/foundation.dart';

@immutable
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.icon,
    this.color,
    this.description,
  });

  final String id;
  final String name;
  final String slug;
  final String? icon;
  final String? color;
  final String? description;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.slug == slug;
  }

  @override
  int get hashCode => Object.hash(id, name, slug);

  @override
  String toString() => 'Category(id: $id, name: $name, slug: $slug)';
}
