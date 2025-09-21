import 'package:barpass_app/features/notifications/data/models/notification_model.dart';

/// Interface para Data Source Remoto
abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({
    int? limit,
    int? offset,
  });

  Future<NotificationModel?> getNotificationById(String id);

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(String id);

  Future<void> deleteAllNotifications();

  Future<int> getUnreadCount();

  Future<NotificationStatsModel> getStats();

  Future<void> saveToken(String token, {String? platform});

  Future<void> updatePreferences(NotificationPreferencesModel preferences);

  Future<NotificationPreferencesModel> getPreferences();
}

/// Implementação do Data Source Remoto (API)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  // TODO: Injetar HTTP client (Dio, http, etc)

  @override
  Future<List<NotificationModel>> getNotifications({
    int? limit,
    int? offset,
  }) async {
    // TODO: Implementar chamada à API
    // final response = await _client.get(
    //   '/api/notifications',
    //   queryParameters: {
    //     'limit': limit,
    //     'offset': offset,
    //   },
    // );
    //
    // final List data = response.data['notifications'];
    // return data.map((json) => NotificationModel.fromJson(json)).toList();

    // Mock temporário
    return [];
  }

  @override
  Future<NotificationModel?> getNotificationById(String id) async {
    // TODO: GET /api/notifications/{id}
    return null;
  }

  @override
  Future<void> markAsRead(String id) async {
    // TODO: PATCH /api/notifications/{id}/read
  }

  @override
  Future<void> markAllAsRead() async {
    // TODO: POST /api/notifications/mark-all-read
  }

  @override
  Future<void> deleteNotification(String id) async {
    // TODO: DELETE /api/notifications/{id}
  }

  @override
  Future<void> deleteAllNotifications() async {
    // TODO: DELETE /api/notifications
  }

  @override
  Future<int> getUnreadCount() async {
    // TODO: GET /api/notifications/unread-count
    return 0;
  }

  @override
  Future<NotificationStatsModel> getStats() async {
    // TODO: GET /api/notifications/stats
    return const NotificationStatsModel();
  }

  @override
  Future<void> saveToken(String token, {String? platform}) async {
    // TODO: POST /api/devices/tokens
    // Body: { "token": token, "platform": platform }
  }

  @override
  Future<void> updatePreferences(
    NotificationPreferencesModel preferences,
  ) async {
    // TODO: PUT /api/notifications/preferences
    // Body: preferences.toJson()
  }

  @override
  Future<NotificationPreferencesModel> getPreferences() async {
    // TODO: GET /api/notifications/preferences
    return const NotificationPreferencesModel();
  }
}
