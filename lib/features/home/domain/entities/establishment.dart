import 'package:freezed_annotation/freezed_annotation.dart';

part 'establishment.freezed.dart';

@freezed
sealed class Establishment with _$Establishment {
  const factory Establishment({
    required String id,
    required String name,
    required String address,
    required double rating,
    required String imageUrl,
    required String logoUrl,
    required String distance,
    required String discount,
    @Default(0) int reviewCount,
    @Default([]) List<String> categories,
  }) = _Establishment;

  const Establishment._();

  // APENAS business logic
  bool matchesCategory(String? categoryId) {
    if (categoryId == null || categoryId == 'all') return true;
    return categories.contains(categoryId);
  }

  bool matchesSearch(String? query) {
    if (query == null || query.isEmpty) return true;
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        address.toLowerCase().contains(lowerQuery);
  }

  bool get hasGoodRating => rating >= 4.0;
  bool get isPopular => reviewCount >= 100;

  String get ratingDescription {
    if (rating >= 4.5) return 'Excelente';
    if (rating >= 4.0) return 'Muito bom';
    if (rating >= 3.5) return 'Bom';
    if (rating >= 3.0) return 'Regular';
    return 'Precisa melhorar';
  }
}
