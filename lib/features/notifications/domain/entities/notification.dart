import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

/// Tipos de notificação do app (Domain)
enum NotificationType {
  promotion,
  order,
  favorite,
  general,
  system,
}

/// Entity de Notificação
///
/// Representa uma notificação no domínio da aplicação.
/// Não contém lógica de serialização - isso fica na camada de data.
@freezed
sealed class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String title,
    required String body,
    required NotificationType type,
    required DateTime receivedAt,
    required bool isRead,
    Map<String, dynamic>? data,
    String? imageUrl,
    String? actionUrl,
  }) = _Notification;

  const Notification._();

  /// Ícone para exibir baseado no tipo
  String get iconName {
    switch (type) {
      case NotificationType.promotion:
        return 'local_offer';
      case NotificationType.order:
        return 'receipt';
      case NotificationType.favorite:
        return 'favorite';
      case NotificationType.general:
        return 'notifications';
      case NotificationType.system:
        return 'info';
    }
  }

  /// Verifica se a notificação é recente (menos de 24h)
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(receivedAt);
    return difference.inHours < 24;
  }

  /// Retorna uma descrição amigável do tempo decorrido
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(receivedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m atrás';
    } else {
      return 'Agora';
    }
  }
}

/// Entity de Preferências de Notificação (Domain Layer)
@freezed
sealed class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    required bool enablePromotions,
    required bool enableOrders,
    required bool enableFavorites,
    required bool enableGeneral,
    required bool enableSound,
    required bool enableVibration,
    required bool enableBadge,
  }) = _NotificationPreferences;

  const NotificationPreferences._();

  /// Lista de tópicos baseada nas preferências
  List<String> get enabledTopics {
    final topics = <String>[];

    if (enablePromotions) topics.add('promotions');
    if (enableOrders) topics.add('orders');
    if (enableFavorites) topics.add('favorites');
    if (enableGeneral) topics.add('general');

    return topics;
  }

  /// Verifica se pelo menos uma categoria está habilitada
  bool get hasAnyEnabled {
    return enablePromotions || enableOrders || enableFavorites || enableGeneral;
  }

  /// Retorna preferências padrão
  factory NotificationPreferences.defaults() {
    return const NotificationPreferences(
      enablePromotions: true,
      enableOrders: true,
      enableFavorites: true,
      enableGeneral: true,
      enableSound: false,
      enableVibration: true,
      enableBadge: true,
    );
  }
}

/// Entity de Estatísticas de Notificações (Domain Layer)
@freezed
sealed class NotificationStats with _$NotificationStats {
  const factory NotificationStats({
    required int total,
    required int unread,
    required int promotions,
    required int orders,
    required int favorites,
  }) = _NotificationStats;

  const NotificationStats._();

  /// Retorna o total de notificações lidas
  int get read => total - unread;

  /// Calcula a porcentagem de não lidas
  double get unreadPercentage {
    if (total == 0) return 0.0;
    return (unread / total) * 100;
  }

  /// Retorna estatísticas vazias
  factory NotificationStats.empty() {
    return const NotificationStats(
      total: 0,
      unread: 0,
      promotions: 0,
      orders: 0,
      favorites: 0,
    );
  }
}
