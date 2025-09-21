import 'package:barpass_app/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:barpass_app/features/notifications/data/datasources/notification_remote_datasource.dart';
import 'package:barpass_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:barpass_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_dependencies.g.dart';

/// Dependências do módulo notifications
class NotificationDependencies {
  NotificationDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Datasources
    notificationLocalDataSourceProvider,
    notificationRemoteDataSourceProvider,

    // Repositories
    notificationRepositoryProvider,
  ];
}

// === DATASOURCES ===

@Riverpod(keepAlive: true)
NotificationLocalDataSource notificationLocalDataSource(Ref ref) {
  // TODO: Injetar dependências necessárias (database, etc)
  return NotificationLocalDataSourceImpl();
}

@Riverpod(keepAlive: true)
NotificationRemoteDataSource notificationRemoteDataSource(Ref ref) {
  // TODO: Injetar dependências necessárias (HTTP client, etc)
  return NotificationRemoteDataSourceImpl();
}

// === REPOSITORIES ===

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  final localDataSource = ref.read(notificationLocalDataSourceProvider);
  final remoteDataSource = ref.read(notificationRemoteDataSourceProvider);

  return NotificationRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}
