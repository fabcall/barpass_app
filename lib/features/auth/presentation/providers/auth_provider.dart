import 'package:barpass_app/features/auth/di/auth_dependencies.dart';
import 'package:barpass_app/features/auth/domain/entities/user.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:barpass_app/features/auth/presentation/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

// Auth State Notifier
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

    final result = await _repository.getCurrentUser();

    result.fold(
      (error) => state = const AuthState.unauthenticated(),
      (user) => state = user != null
          ? AuthState.authenticated(user)
          : const AuthState.unauthenticated(),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final loginUseCase = ref.read(loginUseCaseProvider);
    final result = await loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (error) => state = AuthState.error(error),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final registerUseCase = ref.read(registerUseCaseProvider);
    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (error) => state = AuthState.error(error),
      (user) => state = AuthState.authenticated(user),
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
}

// Convenience provider para usuário atual
@riverpod
User? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
}
