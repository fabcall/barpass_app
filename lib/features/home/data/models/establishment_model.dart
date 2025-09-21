import 'package:barpass_app/features/home/domain/entities/establishment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'establishment_model.freezed.dart';
part 'establishment_model.g.dart';

@freezed
sealed class EstablishmentModel with _$EstablishmentModel {
  const factory EstablishmentModel({
    required String id,
    required String name,
    required String address,
    required double rating,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'logo_url') required String logoUrl,
    required String distance,
    required String discount,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @Default([]) List<String> categories,
    // Campos extras da API que não vão para entity
    @JsonKey(name: 'api_id') String? apiId,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _EstablishmentModel;

  factory EstablishmentModel.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentModelFromJson(json);

  factory EstablishmentModel.fromEntity(Establishment establishment) =>
      EstablishmentModel(
        id: establishment.id,
        name: establishment.name,
        address: establishment.address,
        rating: establishment.rating,
        imageUrl: establishment.imageUrl,
        logoUrl: establishment.logoUrl,
        distance: establishment.distance,
        discount: establishment.discount,
        reviewCount: establishment.reviewCount,
        categories: establishment.categories,
      );

  const EstablishmentModel._();

  Establishment toEntity() => Establishment(
    id: id,
    name: name,
    address: address,
    rating: rating,
    imageUrl: imageUrl,
    logoUrl: logoUrl,
    distance: distance,
    discount: discount,
    reviewCount: reviewCount,
    categories: categories,
  );
}
