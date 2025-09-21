import 'package:barpass_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:barpass_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:barpass_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_dependencies.g.dart';

/// Dependências do módulo Auth
class AuthDependencies {
  AuthDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    secureStorageProvider,
    authRemoteDataSourceProvider,
    authLocalDataSourceProvider,
    authRepositoryProvider,
  ];
}

// === STORAGE ===

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

// === DATASOURCES ===

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dataSource = AuthRemoteDataSourceImpl()..seedTestUsers();
  return dataSource;
}

@Riverpod(keepAlive: true)
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSourceImpl(storage);
}

// === REPOSITORY ===

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}
