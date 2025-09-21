import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
sealed class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String slug,
    String? icon,
    String? color,
    String? description,
  }) = _Category;

  const Category._();

  // APENAS business logic
  bool get hasIcon => icon != null && icon!.isNotEmpty;
  bool get hasColor => color != null && color!.isNotEmpty;
  bool get hasDescription => description != null && description!.isNotEmpty;
}
