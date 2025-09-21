// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstablishmentModel _$EstablishmentModelFromJson(Map<String, dynamic> json) =>
    _EstablishmentModel(
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
      apiId: json['api_id'] as String?,
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$EstablishmentModelToJson(_EstablishmentModel instance) =>
    <String, dynamic>{
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
      'api_id': instance.apiId,
      'last_updated': instance.lastUpdated?.toIso8601String(),
      'is_active': instance.isActive,
    };
