import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
sealed class Category with _$Category {
  const Category._();

  const factory Category({
    required String id,
    required String name,
    required String slug,
    String? icon,
    String? color,
    String? description,
  }) = _Category;

  // APENAS business logic
  bool get hasIcon => icon != null && icon!.isNotEmpty;
  bool get hasColor => color != null && color!.isNotEmpty;
  bool get hasDescription => description != null && description!.isNotEmpty;
}
