import 'package:barpass_app/features/auth/di/auth_dependencies.dart';
import 'package:barpass_app/features/auth/domain/entities/auth_session.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:barpass_app/features/auth/presentation/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Provider de autenticação (gerencia apenas sessão)
@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    _checkAuthStatus();
    return const AuthState.initial();
  }

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  Future<void> _checkAuthStatus() async {
    state = const AuthState.loading();

    final hasSession = await _repository.hasActiveSession();

    if (!hasSession) {
      state = const AuthState.unauthenticated();
      return;
    }

    final sessionResult = await _repository.getCurrentSession();

    sessionResult.fold(
      (error) => state = const AuthState.unauthenticated(),
      (session) {
        if (session == null) {
          state = const AuthState.unauthenticated();
          return;
        }

        if (session.isExpired) {
          _tryRefreshToken(session);
        } else {
          state = AuthState.authenticated(session);
        }
      },
    );
  }

  Future<void> _tryRefreshToken(AuthSession session) async {
    final refreshResult = await _repository.refreshToken(
      refreshToken: session.refreshToken,
    );

    refreshResult.fold(
      (error) => state = const AuthState.unauthenticated(),
      (newSession) => state = AuthState.authenticated(newSession),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final sessionResult = await _repository.login(
      email: email,
      password: password,
    );

    sessionResult.fold(
      (error) => state = AuthState.error(error),
      (session) => state = AuthState.authenticated(session),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final sessionResult = await _repository.register(
      name: name,
      email: email,
      password: password,
    );

    sessionResult.fold(
      (error) => state = AuthState.error(error),
      (session) => state = AuthState.authenticated(session),
    );
  }

  Future<void> logout() async {
    state = const AuthState.loading();

    final result = await _repository.logout();

    result.fold(
      (error) => state = AuthState.error(error),
      (_) => state = const AuthState.unauthenticated(),
    );
  }

  Future<void> refreshToken() async {
    final currentState = state;
    if (currentState is! AuthAuthenticated) return;

    final refreshResult = await _repository.refreshToken(
      refreshToken: currentState.session.refreshToken,
    );

    refreshResult.fold(
      (error) {
        state = AuthState.error(error);
        logout();
      },
      (newSession) => state = AuthState.authenticated(newSession),
    );
  }

  Future<void> ensureValidSession() async {
    final currentState = state;
    if (currentState is! AuthAuthenticated) return;

    final session = currentState.session;

    if (session.isValid && !session.willExpireSoon) {
      return;
    }

    await refreshToken();
  }
}

// === CONVENIENCE PROVIDERS ===

/// Provider para acessar a sessão atual
@riverpod
AuthSession? currentSession(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (session) => session,
    orElse: () => null,
  );
}

/// Provider para verificar se está autenticado
@riverpod
bool isAuthenticated(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
}

/// Provider para obter o userId atual
@riverpod
String? currentUserId(Ref ref) {
  final session = ref.watch(currentSessionProvider);
  return session?.userId;
}
