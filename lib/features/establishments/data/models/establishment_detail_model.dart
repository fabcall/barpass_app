import 'package:barpass_app/features/establishments/domain/entities/establishment_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'establishment_detail_model.freezed.dart';
part 'establishment_detail_model.g.dart';

@freezed
sealed class EstablishmentDetailModel with _$EstablishmentDetailModel {
  const factory EstablishmentDetailModel({
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

    // Campos adicionais
    String? description,
    String? phone,
    String? email,
    String? website,
    @JsonKey(name: 'opening_hours') String? openingHours,
    @JsonKey(name: 'is_open') bool? isOpen,
    @JsonKey(name: 'payment_methods') @Default([]) List<String> paymentMethods,
    @Default([]) List<String> facilities,
    @Default([]) List<String> photos,
    @JsonKey(name: 'menu_categories')
    @Default([])
    List<MenuCategoryModel> menuCategories,
    @Default([]) List<ReviewModel> reviews,
  }) = _EstablishmentDetailModel;

  factory EstablishmentDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentDetailModelFromJson(json);

  const EstablishmentDetailModel._();

  EstablishmentDetail toEntity() => EstablishmentDetail(
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
    description: description,
    phone: phone,
    email: email,
    website: website,
    openingHours: openingHours,
    isOpen: isOpen,
    paymentMethods: paymentMethods,
    facilities: facilities,
    photos: photos,
    menuCategories: menuCategories.map((m) => m.toEntity()).toList(),
    reviews: reviews.map((r) => r.toEntity()).toList(),
  );
}

@freezed
sealed class MenuCategoryModel with _$MenuCategoryModel {
  const factory MenuCategoryModel({
    required String id,
    required String name,
    String? description,
    @Default([]) List<MenuItemModel> items,
  }) = _MenuCategoryModel;

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryModelFromJson(json);

  const MenuCategoryModel._();

  MenuCategory toEntity() => MenuCategory(
    id: id,
    name: name,
    description: description,
    items: items.map((i) => i.toEntity()).toList(),
  );
}

@freezed
sealed class MenuItemModel with _$MenuItemModel {
  const factory MenuItemModel({
    required String id,
    required String name,
    required String description,
    required String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
  }) = _MenuItemModel;

  factory MenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemModelFromJson(json);

  const MenuItemModel._();

  MenuItem toEntity() => MenuItem(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
    isAvailable: isAvailable,
  );
}

@freezed
sealed class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    @JsonKey(name: 'user_name') required String userName,
    required int rating,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'user_avatar_url') String? userAvatarUrl,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  const ReviewModel._();

  Review toEntity() => Review(
    id: id,
    userName: userName,
    rating: rating,
    comment: comment,
    createdAt: createdAt,
    userAvatarUrl: userAvatarUrl,
  );
}
