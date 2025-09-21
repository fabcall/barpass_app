import 'package:barpass_app/features/notifications/data/models/notification_model.dart';

/// Interface para Data Source Local
abstract class NotificationLocalDataSource {
  Future<List<NotificationModel>> getNotifications({
    int? limit,
    int? offset,
  });

  Future<NotificationModel?> getNotificationById(String id);

  Future<void> saveNotifications(List<NotificationModel> notifications);

  Future<void> saveNotification(NotificationModel notification);

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(String id);

  Future<void> deleteAllNotifications();

  Future<int> getUnreadCount();

  Future<NotificationStatsModel> getStats();

  Future<void> savePreferences(NotificationPreferencesModel preferences);

  Future<NotificationPreferencesModel> getPreferences();
}

/// Implementação do Data Source Local (SQLite, Hive, SharedPreferences)
class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  // TODO: Injetar database (sqflite, hive, etc)

  @override
  Future<List<NotificationModel>> getNotifications({
    int? limit,
    int? offset,
  }) async {
    // TODO: Implementar query no banco local
    // final db = await _database;
    // final maps = await db.query(
    //   'notifications',
    //   orderBy: 'receivedAt DESC',
    //   limit: limit,
    //   offset: offset,
    // );
    //
    // return maps.map((map) => NotificationModel.fromJson(map)).toList();

    return [];
  }

  @override
  Future<NotificationModel?> getNotificationById(String id) async {
    // TODO: Query por ID
    return null;
  }

  @override
  Future<void> saveNotifications(List<NotificationModel> notifications) async {
    // TODO: Batch insert/update
    // final db = await _database;
    // final batch = db.batch();
    // for (final notification in notifications) {
    //   batch.insert(
    //     'notifications',
    //     notification.toJson(),
    //     conflictAlgorithm: ConflictAlgorithm.replace,
    //   );
    // }
    // await batch.commit();
  }

  @override
  Future<void> saveNotification(NotificationModel notification) async {
    // TODO: Insert/update single
  }

  @override
  Future<void> markAsRead(String id) async {
    // TODO: Update isRead = true
  }

  @override
  Future<void> markAllAsRead() async {
    // TODO: Update all isRead = true
  }

  @override
  Future<void> deleteNotification(String id) async {
    // TODO: Delete by ID
  }

  @override
  Future<void> deleteAllNotifications() async {
    // TODO: Delete all
  }

  @override
  Future<int> getUnreadCount() async {
    // TODO: COUNT where isRead = false
    return 0;
  }

  @override
  Future<NotificationStatsModel> getStats() async {
    // TODO: Aggregate queries
    return const NotificationStatsModel();
  }

  @override
  Future<void> savePreferences(
    NotificationPreferencesModel preferences,
  ) async {
    // TODO: Save to SharedPreferences or similar
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('notification_preferences', json.encode(preferences.toJson()));
  }

  @override
  Future<NotificationPreferencesModel> getPreferences() async {
    // TODO: Load from SharedPreferences
    return const NotificationPreferencesModel();
  }
}
