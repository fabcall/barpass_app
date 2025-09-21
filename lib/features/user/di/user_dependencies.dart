import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:barpass_app/features/auth/di/auth_dependencies.dart';
import 'package:barpass_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:barpass_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:barpass_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:barpass_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:barpass_app/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_dependencies.g.dart';

/// Dependências do módulo User
class UserDependencies {
  UserDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    userRemoteDataSourceProvider,
    userLocalDataSourceProvider,
    userRepositoryProvider,
  ];
}

// === DATASOURCES ===

@Riverpod(keepAlive: true)
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  // Obtém referência ao banco de dados do AuthRemoteDataSource
  final authRemoteDs =
      ref.watch(authRemoteDataSourceProvider) as AuthRemoteDataSourceImpl;

  return UserRemoteDataSourceImpl(authRemoteDs.usersDatabase);
}

@Riverpod(keepAlive: true)
UserLocalDataSource userLocalDataSource(Ref ref) {
  final storage = ref.watch(storageServiceProvider);
  return UserLocalDataSourceImpl(storage);
}

// === REPOSITORY ===

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localDataSource = ref.watch(userLocalDataSourceProvider);

  String getCurrentUserId() {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      throw Exception('Nenhuma sessão ativa');
    }
    return userId;
  }

  return UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    getCurrentUserId: getCurrentUserId,
  );
}
