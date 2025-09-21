// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para gerenciar as configurações de push notifications

@ProviderFor(NotificationSettingsNotifier)
const notificationSettingsProvider = NotificationSettingsNotifierProvider._();

/// Provider para gerenciar as configurações de push notifications
final class NotificationSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          NotificationSettingsNotifier,
          NotificationSettings
        > {
  /// Provider para gerenciar as configurações de push notifications
  const NotificationSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSettingsNotifierHash();

  @$internal
  @override
  NotificationSettingsNotifier create() => NotificationSettingsNotifier();
}

String _$notificationSettingsNotifierHash() =>
    r'fde082056fbffe1e4dfce2cbc4602d96e144acdc';

/// Provider para gerenciar as configurações de push notifications

abstract class _$NotificationSettingsNotifier
    extends $AsyncNotifier<NotificationSettings> {
  FutureOr<NotificationSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<NotificationSettings>, NotificationSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationSettings>,
                NotificationSettings
              >,
              AsyncValue<NotificationSettings>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider para verificar se as notificações estão habilitadas

@ProviderFor(notificationsEnabled)
const notificationsEnabledProvider = NotificationsEnabledProvider._();

/// Provider para verificar se as notificações estão habilitadas

final class NotificationsEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider para verificar se as notificações estão habilitadas
  const NotificationsEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return notificationsEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationsEnabledHash() =>
    r'7665ec2db18981e5913b937aaaf296e89b154e75';

/// Provider para obter o token FCM

@ProviderFor(fcmToken)
const fcmTokenProvider = FcmTokenProvider._();

/// Provider para obter o token FCM

final class FcmTokenProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Provider para obter o token FCM
  const FcmTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmTokenHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return fcmToken(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$fcmTokenHash() => r'c19374dc1609ac0c831155b3d3b293fc15096a61';
