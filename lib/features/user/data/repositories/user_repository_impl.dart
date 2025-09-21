import 'package:barpass_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:barpass_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:barpass_app/features/user/domain/entities/user.dart';
import 'package:barpass_app/features/user/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
    required String Function() getCurrentUserId,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _getCurrentUserId = getCurrentUserId;

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final String Function() _getCurrentUserId;

  @override
  Future<Either<String, User>> getCurrentUser() async {
    try {
      // Obtém o userId da sessão atual
      final userId = _getCurrentUserId();

      // Busca do backend
      final userModel = await _remoteDataSource.getCurrentUser(userId);

      // Salva em cache
      await _localDataSource.cacheUser(userModel);

      // Converte para entity e retorna
      return right(userModel.toEntity());
    } catch (e) {
      // Se falhar, tenta retornar do cache
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return right(cachedUser.toEntity());
      }

      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, User>> getUserById(String userId) async {
    try {
      final userModel = await _remoteDataSource.getUserById(userId);
      return right(userModel.toEntity());
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, User>> updateProfile({
    String? name,
    String? avatarUrl,
    String? phoneNumber,
  }) async {
    try {
      final userId = _getCurrentUserId();

      final userModel = await _remoteDataSource.updateProfile(
        userId: userId,
        name: name,
        avatarUrl: avatarUrl,
        phoneNumber: phoneNumber,
      );

      // Atualiza o cache
      await _localDataSource.cacheUser(userModel);

      return right(userModel.toEntity());
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, String>> uploadAvatar(String filePath) async {
    try {
      final userId = _getCurrentUserId();

      final avatarUrl = await _remoteDataSource.uploadAvatar(
        userId: userId,
        filePath: filePath,
      );

      // Atualiza o perfil com a nova URL
      await updateProfile(avatarUrl: avatarUrl);

      return right(avatarUrl);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, void>> deleteAccount() async {
    try {
      final userId = _getCurrentUserId();

      await _remoteDataSource.deleteAccount(userId);

      // Limpa o cache local
      await _localDataSource.clearAll();

      return right(null);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, void>> verifyEmail(String code) async {
    try {
      final userId = _getCurrentUserId();

      await _remoteDataSource.verifyEmail(
        userId: userId,
        code: code,
      );

      // Atualiza o cache
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        final updatedUser = cachedUser.copyWith(isEmailVerified: true);
        await _localDataSource.cacheUser(updatedUser);
      }

      return right(null);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, void>> verifyPhone(String code) async {
    try {
      final userId = _getCurrentUserId();

      await _remoteDataSource.verifyPhone(
        userId: userId,
        code: code,
      );

      // Atualiza o cache
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        final updatedUser = cachedUser.copyWith(isPhoneVerified: true);
        await _localDataSource.cacheUser(updatedUser);
      }

      return right(null);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, void>> updatePreferences(
    Map<String, dynamic> preferences,
  ) async {
    try {
      final userId = _getCurrentUserId();

      await _remoteDataSource.updatePreferences(
        userId: userId,
        preferences: preferences,
      );

      // Salva localmente
      await _localDataSource.savePreferences(preferences);

      return right(null);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<User?> getCachedUser() async {
    final cachedUser = await _localDataSource.getCachedUser();
    return cachedUser?.toEntity();
  }

  @override
  Future<void> clearCache() async {
    await _localDataSource.clearAll();
  }
}
