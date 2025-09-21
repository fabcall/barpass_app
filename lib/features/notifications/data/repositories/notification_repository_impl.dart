import 'package:barpass_app/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:barpass_app/features/notifications/data/datasources/notification_remote_datasource.dart';
import 'package:barpass_app/features/notifications/data/models/notification_model.dart';
import 'package:barpass_app/features/notifications/domain/entities/notification.dart';
import 'package:barpass_app/features/notifications/domain/repositories/notification_repository.dart';

/// Implementação do Repository (Data Layer)
///
/// Coordena entre data sources (local e remote) e converte
/// Models para Entities do domínio.
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required NotificationRemoteDataSource remoteDataSource,
    required NotificationLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final NotificationRemoteDataSource _remoteDataSource;
  final NotificationLocalDataSource _localDataSource;

  @override
  Future<List<Notification>> getNotifications({
    int? limit,
    int? offset,
  }) async {
    try {
      // Tentar buscar do servidor
      final models = await _remoteDataSource.getNotifications(
        limit: limit,
        offset: offset,
      );

      // Cachear localmente
      await _localDataSource.saveNotifications(models);

      // Converter Models para Entities
      return models.map((model) => model.toEntity()).toList();
    } on Exception catch (e) {
      // Em caso de erro, buscar do cache local
      final cachedModels = await _localDataSource.getNotifications(
        limit: limit,
        offset: offset,
      );

      return cachedModels.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<Notification?> getNotificationById(String id) async {
    try {
      final model = await _remoteDataSource.getNotificationById(id);
      return model?.toEntity();
    } on Exception catch (e) {
      // Fallback para cache local
      final cachedModel = await _localDataSource.getNotificationById(id);
      return cachedModel?.toEntity();
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    // Atualizar localmente primeiro (otimista)
    await _localDataSource.markAsRead(id);

    // Sincronizar com servidor
    try {
      await _remoteDataSource.markAsRead(id);
    } on Exception catch (e) {
      // TODO: Adicionar à fila de sincronização
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead() async {
    await _localDataSource.markAllAsRead();

    try {
      await _remoteDataSource.markAllAsRead();
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    await _localDataSource.deleteNotification(id);

    try {
      await _remoteDataSource.deleteNotification(id);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAllNotifications() async {
    await _localDataSource.deleteAllNotifications();

    try {
      await _remoteDataSource.deleteAllNotifications();
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      return await _remoteDataSource.getUnreadCount();
    } on Exception catch (e) {
      // Fallback para cache local
      return await _localDataSource.getUnreadCount();
    }
  }

  @override
  Future<NotificationStats> getStats() async {
    try {
      final model = await _remoteDataSource.getStats();
      return model.toEntity();
    } on Exception catch (e) {
      final cachedModel = await _localDataSource.getStats();
      return cachedModel.toEntity();
    }
  }

  @override
  Future<void> saveToken(String token, {String? platform}) async {
    await _remoteDataSource.saveToken(token, platform: platform);
  }

  @override
  Future<void> updatePreferences(
    NotificationPreferences preferences,
  ) async {
    // Converter Entity para Model
    final model = NotificationPreferencesModel.fromEntity(preferences);

    // Salvar localmente
    await _localDataSource.savePreferences(model);

    // Sincronizar com servidor
    try {
      await _remoteDataSource.updatePreferences(model);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationPreferences> getPreferences() async {
    try {
      final model = await _remoteDataSource.getPreferences();
      return model.toEntity();
    } on Exception catch (e) {
      final cachedModel = await _localDataSource.getPreferences();
      return cachedModel.toEntity();
    }
  }
}
