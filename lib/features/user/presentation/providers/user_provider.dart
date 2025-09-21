import 'package:barpass_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:barpass_app/features/auth/presentation/state/auth_state.dart';
import 'package:barpass_app/features/user/di/user_dependencies.dart';
import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:barpass_app/features/user/domain/repositories/user_repository.dart';
import 'package:barpass_app/features/user/presentation/state/user_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

/// Provider de usuário (gerencia dados do user)
@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  UserState build() {
    // Escuta mudanças na autenticação
    ref.listen(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (_) => _loadUser(),
        unauthenticated: () => state = const UserState.unauthenticated(),
        error: (_) => state = const UserState.unauthenticated(),
      );
    });

    // Carrega usuário se já estiver autenticado
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (isAuthenticated) {
      _loadUser();
    }

    return const UserState.initial();
  }

  UserRepository get _repository => ref.read(userRepositoryProvider);

  Future<void> _loadUser() async {
    state = const UserState.loading();

    final result = await _repository.getCurrentUser();

    result.fold(
      (error) => state = UserState.error(error),
      (user) => state = UserState.loaded(user),
    );
  }

  Future<void> updateProfile({
    String? name,
    String? avatarUrl,
    String? phoneNumber,
  }) async {
    state = const UserState.loading();

    final result = await _repository.updateProfile(
      name: name,
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (error) => state = UserState.error(error),
      (user) => state = UserState.loaded(user),
    );
  }

  Future<void> uploadAvatar(String filePath) async {
    state = const UserState.loading();

    final result = await _repository.uploadAvatar(filePath);

    await result.fold(
      (error) async => state = UserState.error(error),
      (avatarUrl) async => await updateProfile(avatarUrl: avatarUrl),
    );
  }

  Future<void> deleteAccount() async {
    state = const UserState.loading();

    final result = await _repository.deleteAccount();

    await result.fold(
      (error) async => state = UserState.error(error),
      (_) async {
        await _repository.clearCache();
        await ref.read(authProvider.notifier).logout();
        state = const UserState.unauthenticated();
      },
    );
  }

  Future<void> reloadUser() async {
    await _loadUser();
  }

  void clearCache() {
    _repository.clearCache();
  }
}

// === CONVENIENCE PROVIDERS ===

/// Provider para acessar apenas o usuário
@riverpod
User? currentUser(Ref ref) {
  final userState = ref.watch(userProvider);
  return userState.maybeWhen(
    loaded: (user) => user,
    orElse: () => null,
  );
}
