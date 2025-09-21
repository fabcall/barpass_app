// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationLocalDataSource)
const notificationLocalDataSourceProvider =
    NotificationLocalDataSourceProvider._();

final class NotificationLocalDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationLocalDataSource,
          NotificationLocalDataSource,
          NotificationLocalDataSource
        >
    with $Provider<NotificationLocalDataSource> {
  const NotificationLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationLocalDataSource create(Ref ref) {
    return notificationLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationLocalDataSource>(value),
    );
  }
}

String _$notificationLocalDataSourceHash() =>
    r'ee39c36072a7269d6629f29bb175e6647b42dc27';

@ProviderFor(notificationRemoteDataSource)
const notificationRemoteDataSourceProvider =
    NotificationRemoteDataSourceProvider._();

final class NotificationRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationRemoteDataSource,
          NotificationRemoteDataSource,
          NotificationRemoteDataSource
        >
    with $Provider<NotificationRemoteDataSource> {
  const NotificationRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRemoteDataSource create(Ref ref) {
    return notificationRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRemoteDataSource>(value),
    );
  }
}

String _$notificationRemoteDataSourceHash() =>
    r'a60cfe86f292e76ecf3e57913b643d75dee12d6b';

@ProviderFor(notificationRepository)
const notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  const NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'ed9fbe161277c538f5c669848bd03354b1c21a9c';
