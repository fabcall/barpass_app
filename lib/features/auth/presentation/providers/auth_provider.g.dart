// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider de autenticação (gerencia apenas sessão)

@ProviderFor(Auth)
const authProvider = AuthProvider._();

/// Provider de autenticação (gerencia apenas sessão)
final class AuthProvider extends $NotifierProvider<Auth, AuthState> {
  /// Provider de autenticação (gerencia apenas sessão)
  const AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authHash() => r'b296cccbfe7096934b7d223876398e35422a6745';

/// Provider de autenticação (gerencia apenas sessão)

abstract class _$Auth extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider para acessar a sessão atual

@ProviderFor(currentSession)
const currentSessionProvider = CurrentSessionProvider._();

/// Provider para acessar a sessão atual

final class CurrentSessionProvider
    extends $FunctionalProvider<AuthSession?, AuthSession?, AuthSession?>
    with $Provider<AuthSession?> {
  /// Provider para acessar a sessão atual
  const CurrentSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSessionHash();

  @$internal
  @override
  $ProviderElement<AuthSession?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthSession? create(Ref ref) {
    return currentSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSession? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSession?>(value),
    );
  }
}

String _$currentSessionHash() => r'51469ce84c94cb0e0055e589c771f92b4eb53b0b';

/// Provider para verificar se está autenticado

@ProviderFor(isAuthenticated)
const isAuthenticatedProvider = IsAuthenticatedProvider._();

/// Provider para verificar se está autenticado

final class IsAuthenticatedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider para verificar se está autenticado
  const IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthenticated(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthenticatedHash() => r'f811c14ed44cf8855206d937873d789b5c5b3025';

/// Provider para obter o userId atual

@ProviderFor(currentUserId)
const currentUserIdProvider = CurrentUserIdProvider._();

/// Provider para obter o userId atual

final class CurrentUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Provider para obter o userId atual
  const CurrentUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return currentUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentUserIdHash() => r'8e02739c668b14c44181aefb29f0964d769f3228';
