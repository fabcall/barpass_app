import 'package:barpass_app/features/notifications/domain/entities/notification.dart';

/// Interface do Repository (Domain Layer)
///
/// Define o contrato para operações de notificações.
/// A implementação fica na camada de data.
abstract class NotificationRepository {
  /// Lista todas as notificações do usuário
  Future<List<Notification>> getNotifications({
    int? limit,
    int? offset,
  });

  /// Obtém uma notificação específica
  Future<Notification?> getNotificationById(String id);

  /// Marca uma notificação como lida
  Future<void> markAsRead(String id);

  /// Marca todas as notificações como lidas
  Future<void> markAllAsRead();

  /// Deleta uma notificação
  Future<void> deleteNotification(String id);

  /// Deleta todas as notificações
  Future<void> deleteAllNotifications();

  /// Obtém o número de notificações não lidas
  Future<int> getUnreadCount();

  /// Obtém estatísticas de notificações
  Future<NotificationStats> getStats();

  /// Salva o token FCM no servidor
  Future<void> saveToken(String token, {String? platform});

  /// Atualiza as preferências de notificação
  Future<void> updatePreferences(NotificationPreferences preferences);

  /// Obtém as preferências de notificação
  Future<NotificationPreferences> getPreferences();
}
