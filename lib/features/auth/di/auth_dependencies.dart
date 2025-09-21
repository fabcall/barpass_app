import 'package:barpass_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:barpass_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:barpass_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_dependencies.g.dart';

/// Dependências do módulo auth
class AuthDependencies {
  AuthDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Repository
    authRepositoryProvider,

    // Use Cases
    loginUseCaseProvider,
    registerUseCaseProvider,
  ];
}

// === REPOSITORY ===
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final repo = AuthRepositoryImpl()
    // Adiciona usuários de teste
    ..seedTestUsers();
  return repo;
}

// === USE CASES ===
@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
}

@Riverpod(keepAlive: true)
RegisterUseCase registerUseCase(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUseCase(repository);
}
