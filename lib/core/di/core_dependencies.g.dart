// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para SharedPreferencesAsync

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider para SharedPreferencesAsync

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferencesAsync,
          SharedPreferencesAsync,
          SharedPreferencesAsync
        >
    with $Provider<SharedPreferencesAsync> {
  /// Provider para SharedPreferencesAsync
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferencesAsync> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferencesAsync create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferencesAsync value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferencesAsync>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'27f75883fdfa5699515101e124521cad2de328e6';

/// Provider para StorageService

@ProviderFor(storageService)
const storageServiceProvider = StorageServiceProvider._();

/// Provider para StorageService

final class StorageServiceProvider
    extends $FunctionalProvider<StorageService, StorageService, StorageService>
    with $Provider<StorageService> {
  /// Provider para StorageService
  const StorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageServiceHash();

  @$internal
  @override
  $ProviderElement<StorageService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StorageService create(Ref ref) {
    return storageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageService>(value),
    );
  }
}

String _$storageServiceHash() => r'c5c634c680f040c45231a874bdd7569a2eb1af72';

/// Provider para o serviço de redirecionamento

@ProviderFor(redirectService)
const redirectServiceProvider = RedirectServiceProvider._();

/// Provider para o serviço de redirecionamento

final class RedirectServiceProvider
    extends
        $FunctionalProvider<RedirectService, RedirectService, RedirectService>
    with $Provider<RedirectService> {
  /// Provider para o serviço de redirecionamento
  const RedirectServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redirectServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redirectServiceHash();

  @$internal
  @override
  $ProviderElement<RedirectService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RedirectService create(Ref ref) {
    return redirectService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RedirectService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RedirectService>(value),
    );
  }
}

String _$redirectServiceHash() => r'ec07006816ed04f0024fb55a50101352b5fc56d9';
