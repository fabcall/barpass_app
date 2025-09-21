import 'package:barpass_app/features/notifications/domain/entities/notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Model de Notificação (Data Layer)
///
/// Responsável pela serialização/deserialização de dados.
/// Mapeia entre a API/Storage e a Entity do domínio.
@freezed
sealed class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String title,
    required String body,
    required String type,
    required DateTime receivedAt,
    @Default(false) bool isRead,
    Map<String, dynamic>? data,
    String? imageUrl,
    String? actionUrl,
  }) = _NotificationModel;

  /// Cria Model a partir de Entity
  factory NotificationModel.fromEntity(Notification entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      type: entity.type.name,
      receivedAt: entity.receivedAt,
      isRead: entity.isRead,
      data: entity.data,
      imageUrl: entity.imageUrl,
      actionUrl: entity.actionUrl,
    );
  }

  const NotificationModel._();

  /// Serialização JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  /// Cria Model a partir de dados FCM
  factory NotificationModel.fromFCM(Map<String, dynamic> data) {
    return NotificationModel(
      id:
          data['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: data['title'] as String? ?? '',
      body: data['body'] as String? ?? '',
      type: data['type'] as String? ?? 'general',
      receivedAt: DateTime.now(),
      data: data,
      imageUrl: data['image_url'] as String?,
      actionUrl: data['action_url'] as String?,
    );
  }

  /// Converte Model para Entity (Domain)
  Notification toEntity() {
    // Parse do tipo com fallback seguro
    final notifType = NotificationType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => NotificationType.general,
    );

    return Notification(
      id: id,
      title: title,
      body: body,
      type: notifType,
      receivedAt: receivedAt,
      isRead: isRead,
      data: data,
      imageUrl: imageUrl,
      actionUrl: actionUrl,
    );
  }
}

/// Model de Preferências (Data Layer)
@freezed
sealed class NotificationPreferencesModel with _$NotificationPreferencesModel {
  const factory NotificationPreferencesModel({
    @Default(true) bool enablePromotions,
    @Default(true) bool enableOrders,
    @Default(true) bool enableFavorites,
    @Default(true) bool enableGeneral,
    @Default(false) bool enableSound,
    @Default(true) bool enableVibration,
    @Default(true) bool enableBadge,
  }) = _NotificationPreferencesModel;

  /// Cria Model a partir de Entity
  factory NotificationPreferencesModel.fromEntity(
    NotificationPreferences entity,
  ) {
    return NotificationPreferencesModel(
      enablePromotions: entity.enablePromotions,
      enableOrders: entity.enableOrders,
      enableFavorites: entity.enableFavorites,
      enableGeneral: entity.enableGeneral,
      enableSound: entity.enableSound,
      enableVibration: entity.enableVibration,
      enableBadge: entity.enableBadge,
    );
  }

  const NotificationPreferencesModel._();

  /// Serialização JSON
  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesModelFromJson(json);

  /// Converte Model para Entity
  NotificationPreferences toEntity() {
    return NotificationPreferences(
      enablePromotions: enablePromotions,
      enableOrders: enableOrders,
      enableFavorites: enableFavorites,
      enableGeneral: enableGeneral,
      enableSound: enableSound,
      enableVibration: enableVibration,
      enableBadge: enableBadge,
    );
  }
}

/// Model de Estatísticas (Data Layer)
@freezed
sealed class NotificationStatsModel with _$NotificationStatsModel {
  const factory NotificationStatsModel({
    @Default(0) int total,
    @Default(0) int unread,
    @Default(0) int promotions,
    @Default(0) int orders,
    @Default(0) int favorites,
  }) = _NotificationStatsModel;

  /// Cria Model a partir de Entity
  factory NotificationStatsModel.fromEntity(NotificationStats entity) {
    return NotificationStatsModel(
      total: entity.total,
      unread: entity.unread,
      promotions: entity.promotions,
      orders: entity.orders,
      favorites: entity.favorites,
    );
  }

  const NotificationStatsModel._();

  /// Serialização JSON
  factory NotificationStatsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationStatsModelFromJson(json);

  /// Converte Model para Entity
  NotificationStats toEntity() {
    return NotificationStats(
      total: total,
      unread: unread,
      promotions: promotions,
      orders: orders,
      favorites: favorites,
    );
  }
}
