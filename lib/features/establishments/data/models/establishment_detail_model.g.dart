// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstablishmentDetailModel _$EstablishmentDetailModelFromJson(
  Map<String, dynamic> json,
) => _EstablishmentDetailModel(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  rating: (json['rating'] as num).toDouble(),
  imageUrl: json['image_url'] as String,
  logoUrl: json['logo_url'] as String,
  distance: json['distance'] as String,
  discount: json['discount'] as String,
  reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  description: json['description'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
  openingHours: json['opening_hours'] as String?,
  isOpen: json['is_open'] as bool?,
  paymentMethods:
      (json['payment_methods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  facilities:
      (json['facilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  menuCategories:
      (json['menu_categories'] as List<dynamic>?)
          ?.map((e) => MenuCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$EstablishmentDetailModelToJson(
  _EstablishmentDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'rating': instance.rating,
  'image_url': instance.imageUrl,
  'logo_url': instance.logoUrl,
  'distance': instance.distance,
  'discount': instance.discount,
  'review_count': instance.reviewCount,
  'categories': instance.categories,
  'description': instance.description,
  'phone': instance.phone,
  'email': instance.email,
  'website': instance.website,
  'opening_hours': instance.openingHours,
  'is_open': instance.isOpen,
  'payment_methods': instance.paymentMethods,
  'facilities': instance.facilities,
  'photos': instance.photos,
  'menu_categories': instance.menuCategories,
  'reviews': instance.reviews,
};

_MenuCategoryModel _$MenuCategoryModelFromJson(Map<String, dynamic> json) =>
    _MenuCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MenuCategoryModelToJson(_MenuCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'items': instance.items,
    };

_MenuItemModel _$MenuItemModelFromJson(Map<String, dynamic> json) =>
    _MenuItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      imageUrl: json['image_url'] as String?,
      isAvailable: json['is_available'] as bool? ?? true,
    );

Map<String, dynamic> _$MenuItemModelToJson(_MenuItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image_url': instance.imageUrl,
      'is_available': instance.isAvailable,
    };

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  id: json['id'] as String,
  userName: json['user_name'] as String,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  userAvatarUrl: json['user_avatar_url'] as String?,
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'user_avatar_url': instance.userAvatarUrl,
    };
