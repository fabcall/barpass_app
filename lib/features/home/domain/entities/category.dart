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

  /// Cria uma instância "fake" para ser usada em skeletons.
  /// O conteúdo (texto, números) não importa, pois será
  /// substituído por "bones" (ossos) do shimmer.
  factory Category.skeleton() {
    return const Category(
      id: 'skeleton',
      name: 'Categoria', // Um nome para dar largura ao osso do texto
      slug: 'skeleton-slug',
      icon: 'skeleton_icon', // Para 'hasIcon' ser true
      color: '#FFFFFF', // Para 'hasColor' ser true
      description: 'Descrição da categoria', // Para 'hasDescription' ser true
    );
  }

  const Category._();

  // APENAS business logic
  bool get hasIcon => icon != null && icon!.isNotEmpty;
  bool get hasColor => color != null && color!.isNotEmpty;
  bool get hasDescription => description != null && description!.isNotEmpty;
}
