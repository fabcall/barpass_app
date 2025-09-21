// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      receivedAt: DateTime.parse(json['receivedAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      data: json['data'] as Map<String, dynamic>?,
      imageUrl: json['imageUrl'] as String?,
      actionUrl: json['actionUrl'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'receivedAt': instance.receivedAt.toIso8601String(),
      'isRead': instance.isRead,
      'data': instance.data,
      'imageUrl': instance.imageUrl,
      'actionUrl': instance.actionUrl,
    };

_NotificationPreferencesModel _$NotificationPreferencesModelFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferencesModel(
  enablePromotions: json['enablePromotions'] as bool? ?? true,
  enableOrders: json['enableOrders'] as bool? ?? true,
  enableFavorites: json['enableFavorites'] as bool? ?? true,
  enableGeneral: json['enableGeneral'] as bool? ?? true,
  enableSound: json['enableSound'] as bool? ?? false,
  enableVibration: json['enableVibration'] as bool? ?? true,
  enableBadge: json['enableBadge'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationPreferencesModelToJson(
  _NotificationPreferencesModel instance,
) => <String, dynamic>{
  'enablePromotions': instance.enablePromotions,
  'enableOrders': instance.enableOrders,
  'enableFavorites': instance.enableFavorites,
  'enableGeneral': instance.enableGeneral,
  'enableSound': instance.enableSound,
  'enableVibration': instance.enableVibration,
  'enableBadge': instance.enableBadge,
};

_NotificationStatsModel _$NotificationStatsModelFromJson(
  Map<String, dynamic> json,
) => _NotificationStatsModel(
  total: (json['total'] as num?)?.toInt() ?? 0,
  unread: (json['unread'] as num?)?.toInt() ?? 0,
  promotions: (json['promotions'] as num?)?.toInt() ?? 0,
  orders: (json['orders'] as num?)?.toInt() ?? 0,
  favorites: (json['favorites'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$NotificationStatsModelToJson(
  _NotificationStatsModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'unread': instance.unread,
  'promotions': instance.promotions,
  'orders': instance.orders,
  'favorites': instance.favorites,
};
